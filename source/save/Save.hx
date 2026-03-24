package save;

import haxe.Json;
import lime.app.Application;
import flixel.FlxG;

class Save
{
	public static function getField(field:String):Dynamic
	{
		if (FlxG.save.isBound)
			return Reflect.field(FlxG.save.data, field);

		return null;
	}

	public static function setField(field:String, value:Dynamic)
	{
		if (FlxG.save.isBound)
			Reflect.setField(FlxG.save.data, field, value);
	}

	public static function getString(field:String):String
	{
		return Std.string(getField(field));
	}

	public static function getBool(field:String):Bool
	{
		return (getField(field) == true) ?? false;
	}

	public static function getFloat(field:String):Float
	{
		return Std.parseFloat(getString(field));
	}

	public static function getInt(field:String):Float
	{
		return Std.parseInt(getString(field));
	}

	public static function getData(field:String):Dynamic
	{
		try
		{
			// trace('Getting Save "data" field($field): ${getString(field)}');
			return Json.parse(getString(field));
		}
		catch (e)
		{
			if (Defines.debug)
				trace('Save "data" field($field) retrival error: $e');

			return null;
		}
	}

	public static function getDataFieldField(datafield:String, field:String):Dynamic
	{
		if (getData(datafield) == null)
			return null;

		var data:Dynamic = getData(datafield);

		return Reflect.field(data, field);
	}

	public static function setDataFieldField(datafield:String, field:String, value:Dynamic)
	{
		if (getData(datafield) == null)
			return;

		var data:Dynamic = getData(datafield);
		Reflect.setField(data, field, value);

		setField(datafield, Json.stringify(data));
	}

	public static function init()
	{
		trace('Binding save...');
		FlxG.save.bind('MakiBundle', Application.current.meta.get('company'));

		if (Defines.CLEAR_SAVE)
		{
			trace('Clearing save...');
			FlxG.save.erase();
		}

		if (!Application.current.onExit.has(onExit))
			Application.current.onExit.add(onExit);

		trace('Setting save variables...');

		if (getField('shamelessPlug') == null)
			setField('shamelessPlug', true);
		else if (getBool('shamelessPlug'))
			setField('shamelessPlug', false);

		if (getData('highscores') == null)
			setField('highscores', {});

		if (getDataFieldField('highscores', 'dreamland') == null)
			setDataFieldField('highscores', 'dreamland', {});

		var intDreamlandScore:Null<Int> = null;

		try
		{
			intDreamlandScore = cast getDataFieldField('highscores', 'dreamland');
		}
		catch (e)
		{
			intDreamlandScore = null;
		}

		if (getString('version') == null || intDreamlandScore != null) // 0.1 - 0.1.1 saves
		{
			setDataFieldField('highscores', 'dreamland', {
				"default": intDreamlandScore
			});
		}

		setField('version', VersionUtil.getRawVersion());

		trace('Save initalization complete!');
		trace(FlxG.save.data);
	}

	static function onExit(l:Int)
	{
		trace('Saving...');
		trace(FlxG.save.data);
		FlxG.save.flush();
	}
}
