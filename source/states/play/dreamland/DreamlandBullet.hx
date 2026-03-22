package states.play.dreamland;

import flixel.util.FlxColor;
import flixel.FlxSprite;

class DreamlandBullet extends FlxSprite
{
	override public function new()
	{
		super(0, 0);

		makeGraphic(16, 8, FlxColor.YELLOW);
	}
}
