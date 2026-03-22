package save;

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

	public static function getBool(field:String):Bool
		return (getField(field) == true) ?? false;

	public static function init()
	{
		FlxG.save.bind('MakiBundle', Application.current.meta.get('company'));

        #if CLEAR_SAVE
        FlxG.save.erase();
        #end

		Application.current.onExit.add(function(l)
		{
			FlxG.save.flush();
		});

		if (getField('shamelessPlug') == null)
			setField('shamelessPlug', true);
		else if (getBool('shamelessPlug'))
			setField('shamelessPlug', false);
	}
}
