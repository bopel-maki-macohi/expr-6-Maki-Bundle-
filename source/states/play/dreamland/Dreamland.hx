package states.play.dreamland;

import flixel.util.FlxCollision;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;

class Dreamland extends PlayState
{
	public var player:DreamlandPlayer = new DreamlandPlayer();

	public var bulletGroup:FlxTypedSpriteGroup<DreamlandBullet> = new FlxTypedSpriteGroup<DreamlandBullet>();
	public var maxBullets:Int = 2;

	public var enemyGroup:FlxTypedSpriteGroup<DreamlandEnemy> = new FlxTypedSpriteGroup<DreamlandEnemy>();
	public var enemy_offscreen_padding:Float = 40;

	public var bg = new FlxSprite(0, 0, AssetsUtil.image('play/dreamland/bg'));

	override function create()
	{
		super.create();

		add(bg);

		bg.scale.set(2, 2);
		bg.updateHitbox();

		bg.screenCenter();

		add(bulletGroup);
		add(player);
		add(enemyGroup);

		player.screenCenter();
		player.x *= 0.1;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		player.y += (((FlxG.keys.anyPressed([DOWN, S])) ? 1 : 0) - ((FlxG.keys.anyPressed([UP, W])) ? 1 : 0)) * 4;

		if (player.y < player.height)
			player.y = player.height;
		if (player.y > FlxG.height - player.height)
			player.y = FlxG.height - player.height;

		if (FlxG.keys.justReleased.SPACE)
			fireBullet();

		if (FlxG.random.int(0, 20) == 10)
			spawnEnemy();

		for (bullet in bulletGroup.members)
		{
			if (bullet == null)
				continue;

			bullet.x += bullet.width;
			if (bullet.x > FlxG.width + (bullet.width * 2))
			{
				bulletGroup.members.remove(bullet);
				bullet.destroy();
			}

			for (enemy in enemyGroup.members)
				if (bullet.overlaps(enemy))
				{
					enemyGroup.members.remove(enemy);
					enemy.destroy();

					bulletGroup.members.remove(bullet);
					bullet.destroy();

					FlxG.sound.play(AssetsUtil.sound('play/dreamland/explode${FlxG.random.int(1, 3)}'));
				}
		}

		for (enemy in enemyGroup.members)
		{
			if (enemy == null)
				continue;

			enemy.x -= enemy.width / 6;
			if (enemy.x < 0 - enemy.width * 2)
			{
				enemyGroup.members.remove(enemy);
				enemy.destroy();
			}

			if (FlxCollision.pixelPerfectCheck(enemy, player))
			{
				FlxG.switchState(() -> new PlayMenuState());
			}
		}
	}

	public function fireBullet()
	{
		player.animation.play('shoot-a${maxBullets - bulletGroup.members.length}');

		if (bulletGroup.members.length == maxBullets)
			return;

		FlxG.sound.play(AssetsUtil.sound('play/dreamland/shoot${FlxG.random.int(1, 3)}'));

		var newBullet:DreamlandBullet = new DreamlandBullet();
		newBullet.setPosition(player.getGraphicMidpoint().x, player.getGraphicMidpoint().y);
		bulletGroup.add(newBullet);
	}

	public function spawnEnemy()
	{
		var enemySkin:String = 'normal';

		if (FlxG.random.bool(7.5))
			enemySkin = 'hard';
		else if (FlxG.random.bool(30))
			enemySkin = 'easy';

		var newEnemy:DreamlandEnemy = new DreamlandEnemy(enemySkin);

		newEnemy.setPosition(FlxG.width + newEnemy.width * 2, player.y + FlxG.random.float(-120, 120));
		if (newEnemy.y < 0 + enemy_offscreen_padding)
			newEnemy.y = 0 + enemy_offscreen_padding;
		if (newEnemy.y > FlxG.height - newEnemy.height - enemy_offscreen_padding)
			newEnemy.y = FlxG.height - newEnemy.height - enemy_offscreen_padding;

		enemyGroup.add(newEnemy);
	}
}
