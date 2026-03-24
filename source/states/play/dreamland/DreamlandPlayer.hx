package states.play.dreamland;

import flixel.FlxSprite;

class DreamlandPlayer extends FlxSprite
{
	public var playerSkin:String = '';

	override public function new(data:DreamlandConfig)
	{
		super(0, 0);

		this.playerSkin = data.visuals?.player ?? 'default';
		loadGraphic(AssetsUtil.image('play/dreamland/players/${this.playerSkin}'), true, 32, 32);
		animation.add('idle', [0]);

		var i = data.tweaks?.bullets ?? 2;
		var a = 0;

		while (i > -1)
		{
			a++;

			if (this.frames.frames.length < (a + 1))
				animation.add('shoot-a$i', [a, a + 1], 4, false);
			else
				animation.add('shoot-a$i', [a], 4, false);

			i--;
		}

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
