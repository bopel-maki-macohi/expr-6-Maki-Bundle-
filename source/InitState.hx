package;

import flixel.FlxG;
import flixel.FlxState;

class InitState extends FlxState
{
	override public function create()
	{
		super.create();

		trace('curVersion: ' + VersionUtil.getVersion());
		trace('curVersion (raw): ' + VersionUtil.getRawVersion());
		UpdateUtil.checkForUpdate();

		if (UpdateUtil.latestVersion == null || UpdateUtil.latestVersion == '')
			UpdateUtil.latestVersion = VersionUtil.getRawVersion();

		Save.init();

		if (!FlxG.signals.postUpdate.has(postUpdate))
			FlxG.signals.postUpdate.add(postUpdate);

		if (Defines.html5)
			FlxG.switchState(() -> new WebInitMenu(() -> new SplashState()));
		else
			FlxG.switchState(() -> new SplashState());
	}

	function postUpdate()
	{
		if (FlxG.keys.pressed.F3)
			if (FlxG.keys.justPressed.C)
				throw 'Debug Crash';
	}
}
