package states.play.aliotow;

import flixel.util.FlxColor;
import flixel.FlxSprite;

class AliotowEnemy extends FlxSprite
{
	public var health:Int = 2;

	override public function new()
	{
		super();

		makeGraphic(32, 32, FlxColor.RED);
	}
}
