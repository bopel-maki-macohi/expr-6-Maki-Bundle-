package states.play.dreamland;

import flixel.FlxSprite;

class DreamlandPlayer extends FlxSprite
{
	override public function new()
	{
		super(0, 0);

		loadGraphic(AssetsUtil.image('play/dreamland/player'), true, 32, 32);
		animation.add('idle', [0]);
		animation.add('shoot-a2', [1, 2], 4, false);
		animation.add('shoot-a1', [2, 3], 4, false);
		animation.add('shoot-a0', [3, 4], 4, false);
		animation.play('idle');

		animation.onFinish.add(function(animName)
		{
			if (animName != null)
				animation.play('idle');
		});

		scale.set(2, 2);
		updateHitbox();
	}
}
