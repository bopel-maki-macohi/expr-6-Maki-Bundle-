package;

import flixel.FlxG;
import flixel.FlxState;

class InitState extends FlxState
{
	override public function create()
	{
		super.create();

		CrashHandler.errorSignal.add(function(error)
		{
			trace(error);
		});

		trace('curVersion: ' + VersionUtil.getVersion());
		trace('curVersion (raw): ' + VersionUtil.getRawVersion());
		UpdateUtil.checkForUpdate();

		if (UpdateUtil.latestVersion == null || UpdateUtil.latestVersion == '')
			UpdateUtil.latestVersion = VersionUtil.getRawVersion();

		Save.init();

		if (!FlxG.signals.postUpdate.has(postUpdate))
			FlxG.signals.postUpdate.add(postUpdate);

		FlxG.stage.window.title = '${FlxG.stage.application.meta.get('title')} ${VersionUtil.getVersion()}';

		if (Defines.html5)
			FlxG.switchState(() -> new WebInitMenu(() -> FlxG.switchState(() -> new SplashState())));
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
