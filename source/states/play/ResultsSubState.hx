package states.play;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;

class ResultsSubState extends FlxSubState
{
	public var died:Bool = false;

	override public function new(died:Bool = true)
	{
        super();

		this.died = died;
	}

	public var bg:FlxSprite;

	override function create()
	{
		super.create();

		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.fromString('#FFDD00'));
		add(bg);
		bg.screenCenter();

		bg.alpha = 0;
		FlxTween.tween(bg, {alpha: 1}, 1, {
			ease: FlxEase.sineInOut
		});
	}
}
