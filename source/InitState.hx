package;

import flixel.FlxG;
import flixel.FlxState;

class InitState extends FlxState
{
	override public function create()
	{
		super.create();

		trace(VersionUtil.getVersion());

		Save.init();

		FlxG.switchState(() -> new SplashState());
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
