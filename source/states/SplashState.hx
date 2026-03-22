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

		#if debug
		trace('Skipping splash...');
		endSplash();
		#else
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
		#end
	}

	public function endSplash()
	{
		trace('Ending splash...');

		FlxG.switchState(() -> new TitleMenuState());
	}
}
