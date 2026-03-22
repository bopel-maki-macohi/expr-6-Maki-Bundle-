package states.play.dreamland;

import flixel.FlxG;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;

class Dreamland extends PlayState
{
	public var player:DreamlandPlayer = new DreamlandPlayer();

	public var bulletGroup:FlxTypedSpriteGroup<DreamlandBullet> = new FlxTypedSpriteGroup<DreamlandBullet>();
	public var maxBullets:Int = 2;

	override function create()
	{
		super.create();

		add(bulletGroup);
		add(player);

		player.screenCenter();
		player.x *= 0.1;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		player.y += (((FlxG.keys.anyPressed([DOWN, S])) ? 1 : 0) - ((FlxG.keys.anyPressed([UP, W])) ? 1 : 0)) * 4;

		if (FlxG.keys.justReleased.SPACE)
			fireBullet();

        for (bullet in bulletGroup.members)
        {
            if (bullet == null) continue;

            bullet.x += bullet.width;
            if (bullet.x > FlxG.width + (bullet.width * 2))
            {
                bulletGroup.members.remove(bullet);
                bullet.destroy();
            }
        }
	}

	public function fireBullet()
	{
		player.animation.play('shoot-a${maxBullets - bulletGroup.members.length}');

		if (bulletGroup.members.length == maxBullets)
			return;

		FlxG.sound.play(AssetsUtil.sound('play/dreamland/shoot${FlxG.random.int(1, 4)}'));

		var newBullet:DreamlandBullet = new DreamlandBullet();
		newBullet.setPosition(player.getGraphicMidpoint().x, player.getGraphicMidpoint().y);
		bulletGroup.add(newBullet);
	}
}
