package states.play.dreamland;

import flixel.FlxSprite;

class DreamlandEnemy extends FlxSprite
{
	public var enemySkin:String = '';

	override public function new(?enemySkin:String)
	{
		super(0, 0);

		this.enemySkin = enemySkin ?? 'normal';
		loadGraphic(AssetsUtil.image('play/dreamland/enemies/${this.enemySkin}'));

		scale.set(2, 2);
		updateHitbox();
	}
}
