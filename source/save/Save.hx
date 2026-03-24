package save;

import lime.app.Application;
import flixel.FlxG;

class Save
{
	public static var data:SaveData = null;

	public static function init()
	{
		trace('Binding save...');
		FlxG.save.bind('MakiBundle', Application.current.meta.get('company'));

		if (Defines.CLEAR_SAVE)
		{
			trace('Clearing save...');
			FlxG.save.erase();
		}

		data = FlxG.save.data;

		if (!Application.current.onExit.has(onExit))
			Application.current.onExit.add(onExit);

		trace('Setting save variables...');

		if (data.shamelessPlug == null)
			data.shamelessPlug = true;
		else if (data.shamelessPlug)
			data.shamelessPlug = false;

		if (data.highscores == null)
			data.highscores = {
				dreamland: {'default': 0},
				aliotow: {'default': 0},
			};

		var intDreamlandScore:Null<Int> = null;

		try
		{
			intDreamlandScore = cast data.highscores.dreamland;
		}
		catch (e)
		{
			intDreamlandScore = null;
		}

		if (data.version == null || intDreamlandScore != null) // 0.1 - 0.1.1 saves
		{
			if (Std.isOfType(intDreamlandScore, Int))
				setHighscore('dreamland', 'default', intDreamlandScore);
		}

		if (getHighscore('dreamland', 'default') == null)
			setHighscore('dreamland', 'default', 0);

		data.version = VersionUtil.getRawVersion();

		trace('Save initalization complete!');

		save();
		trace(FlxG.save.data);
	}

	static function onExit(l:Int)
	{
		trace('Saving...');

		save();
		trace(FlxG.save.data);

		FlxG.save.flush();
	}

	public static function save()
	{
		for (field in Reflect.fields(data))
			Reflect.setField(FlxG.save.data, field, Reflect.field(data, field));
	}

	public static function getHighscore(minigame:String, config:String):Null<Int>
		return Reflect.field(Reflect.field(data.highscores, minigame), config);

	public static function setHighscore(minigame:String, config:String, value:Int = 0)
		return Reflect.setField(Reflect.field(data.highscores, minigame), config, value);
}
