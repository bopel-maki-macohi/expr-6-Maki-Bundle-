package states.play.aliotow;

import flixel.util.FlxColor;
import flixel.FlxSprite;

class AliotowPlayer extends FlxSprite
{
	override public function new()
	{
		super();

		makeGraphic(128, 128, FlxColor.LIME);
	}
}
