package states.play;

import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxState;

class PlayState extends FlxState
{
	public var paused:Bool = false;

	public var pauseBG:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
	public var pauseText:ButtonText = new ButtonText('PAUSED\n(Escape to leave)', true, ButtonText.SCALE_MAIN);

	public var devbuild:ButtonText = new ButtonText('${VersionUtil.getVersion()} Development Build', false, ButtonText.SCALE_QUARTER, 10, 10);

	override function create()
	{
		super.create();

		pauseBG.alpha = .6;

		pauseText.screenCenter();
		pauseText.onClick.add(function()
		{
			if (paused)
				FlxG.switchState(() -> new PlayMenuState());
		});
		pauseText.color = FlxColor.WHITE;

		FlxG.mouse.visible = false;
		
		devbuild.color = FlxColor.WHITE;
	}

	public function appendBaseObjects()
	{
		add(pauseBG);
		add(pauseText);

		if (Defines.debug)
			add(devbuild);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justReleased.ENTER)
			paused = !paused;

		pauseBG.visible = paused;
		pauseText.visible = paused;

		if (paused)
		{
			if (FlxG.keys.justReleased.ESCAPE)
				FlxG.switchState(() -> new PlayMenuState());

			pausedUpdate();
		}
		else
			unpausedUpdate();
	}

	public function pausedUpdate() {};

	public function unpausedUpdate() {};
}
