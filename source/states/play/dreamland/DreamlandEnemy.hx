package states.play.dreamland;

import flixel.FlxSprite;

class DreamlandEnemy extends FlxSprite
{
	override public function new()
	{
		super(0, 0);

		makeGraphic(40, 40, flixel.util.FlxColor.RED);

		// scale.set(2, 2);
		// updateHitbox();
	}
}
