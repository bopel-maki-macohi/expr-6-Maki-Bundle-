package;

import util.tools.CrashHandler;
import flixel.FlxGame;
import openfl.display.Sprite;

using StringTools;

class Main extends Sprite
{
	public function new()
	{
		super();

		CrashHandler.initialize();
		CrashHandler.queryStatus();

		// shut up
		openfl.utils._internal.Log.level = openfl.utils._internal.Log.LogLevel.INFO;

		addChild(new FlxGame(0, 0, InitState, 60, 60, true, false));
	}
}
