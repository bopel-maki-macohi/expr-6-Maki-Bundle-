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

		if (Std.isOfType(data.highscores, String))
			data.highscores = null;

		data.highscores ??= {};

		if (Std.isOfType(data.highscores.dreamland, Int)) // 0.1 - 0.1.1 saves
		{
			final s = data.highscores.dreamland;

			data.highscores.dreamland = {};
			setHighscore('dreamland', 'default', data.highscores.dreamland);
		}

		for (minigame in ['dreamland', 'aliotow'])
		{
			if (Reflect.field(data.highscores, minigame) == null)
				Reflect.setField(data.highscores, minigame, {});

			if (getHighscore(minigame, 'default') == null)
				setHighscore(minigame, 'default', 0);
		}

		data.version = VersionUtil.getRawVersion();

		trace('Save initalization complete!');
		save();
	}

	static function onExit(l:Int)
	{
		trace('Saving...');
		save();
		FlxG.save.flush();
	}

	public static function save()
	{
		for (field in Reflect.fields(data))
			Reflect.setField(FlxG.save.data, field, Reflect.field(data, field));
		trace(FlxG.save.data);
	}

	public static function getHighscore(minigame:String, config:String):Null<Int>
		return Reflect.field(Reflect.field(data.highscores, minigame), config);

	public static function setHighscore(minigame:String, config:String, value:Int = 0)
		return Reflect.setField(Reflect.field(data.highscores, minigame), config, value);
}
