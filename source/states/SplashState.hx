package states;

import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;

class SplashState extends FlxState
{
	public var splashTexture:FlxSprite = new FlxSprite(0, 0, AssetsUtil.image('splash/splashTexture'));

	override function create()
	{
		super.create();

		splashTexture.screenCenter();
		add(splashTexture);

		if (Defines.debug)
		{
			trace('Skipping splash...');
			endSplash();
			return;
		}

		trace('Starting splash...');
		FlxG.sound.play(AssetsUtil.sound('splash/splashJingle'), 1.0, false, null, true, function()
		{
			FlxTween.tween(splashTexture, {alpha: 0}, 1, {
				startDelay: 1,
				onComplete: function(t)
				{
					FlxTimer.wait(1, endSplash);
				}
			});
		});
	}

	public function endSplash()
	{
		trace('Ending splash...');

		if (Defines.html5)
			FlxG.switchState(() -> new WebInitMenu(startingStateBehavior));
		else
			startingStateBehavior();
	}

	public static function startingStateBehavior()
	{
		FlxG.switchState(() -> new TitleMenuState());
	}
}
