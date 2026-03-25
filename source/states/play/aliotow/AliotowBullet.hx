package states.play.aliotow;

import flixel.util.FlxColor;
import flixel.FlxSprite;

class AliotowBullet extends FlxSprite
{
	override public function new()
	{
		super();

		makeGraphic(8, 16, FlxColor.YELLOW);
	}
}
