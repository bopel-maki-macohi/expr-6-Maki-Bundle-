package;

import util.tools.CrashHandler;
import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();

		CrashHandler.initialize();
		CrashHandler.queryStatus();

		addChild(new FlxGame(0, 0, InitState, 60, 60, true, false));
	}
}
