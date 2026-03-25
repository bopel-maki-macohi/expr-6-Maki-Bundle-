package states.play.aliotow;

import flixel.util.FlxColor;
import flixel.FlxSprite;

class AliotowPlayer extends FlxSprite
{
	override public function new()
	{
		super();

		makeGraphic(32, 32, FlxColor.LIME);
	}
}
