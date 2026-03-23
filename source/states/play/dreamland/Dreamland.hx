package states.play.dreamland;

import flixel.util.FlxColor;
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

	public var bg = new FlxSprite(0, 0);

	public var scoreText:ButtonText = new ButtonText('score', false, ButtonText.SCALE_HALF);
	public var score:Int = 0;

	public var config:DreamlandConfig;

	override public function new(config:DreamlandConfig)
	{
		super();

		this.config = config;
	}

	override function create()
	{
		super.create();

		add(bg);

		bg.loadGraphic(AssetsUtil.image('play/dreamland/backgrounds/' + config?.visuals?.background ?? 'default'));

		bg.scale.set(2, 2);
		bg.updateHitbox();

		bg.screenCenter();

		add(bulletGroup);
		add(player);
		add(enemyGroup);

		player.screenCenter();
		player.x *= 0.1;

		scoreText.color = FlxColor.WHITE;
		add(scoreText);

		add(pauseBG);
		add(pauseText);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (score > Save.getDataFieldField('highscores', 'dreamland'))
			Save.setDataFieldField('highscores', 'dreamland', score);

		scoreText.text = 'Score: $score | Highscore: ${Save.getDataFieldField('highscores', 'dreamland')}';
		scoreText.screenCenter();
		scoreText.y = 10;

		if (player.y < player.height)
			player.y = player.height;
		if (player.y > FlxG.height - player.height)
			player.y = FlxG.height - player.height;
	}

	override function unpausedUpdate()
	{
		super.unpausedUpdate();

		player.y += (((FlxG.keys.anyPressed([DOWN, S])) ? 1 : 0) - ((FlxG.keys.anyPressed([UP, W])) ? 1 : 0)) * 8;

		bg.screenCenter();
		bg.y += player.y / 50;

		if (FlxG.keys.justReleased.SPACE)
			fireBullet();

		if (FlxG.random.int(0, 20) == 10)
			spawnEnemy();

		for (bullet in bulletGroup.members)
		{
			if (bullet == null)
				continue;

			bullet.x += bullet.width * 2;
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

					if (enemy.enemySkin == config.enemySkins.easy)
						score += config.enemyScores.easy;
					else if (enemy.enemySkin == config.enemySkins.normal)
						score += config.enemyScores.normal;
					else if (enemy.enemySkin == config.enemySkins.hard)
						score += config.enemyScores.hard;
					else
						score -= 1;

					FlxG.sound.play(AssetsUtil.sound('play/dreamland/explode${FlxG.random.int(1, 3)}'));
				}
		}

		for (enemy in enemyGroup.members)
		{
			if (enemy == null)
				continue;

			if (enemy.enemySkin == config.enemySkins.easy)
				enemy.x -= enemy.width / config.enemySpeedDividers.easy;
			else if (enemy.enemySkin == config.enemySkins.normal)
				enemy.x -= enemy.width / config.enemySpeedDividers.normal;
			else if (enemy.enemySkin == config.enemySkins.hard)
				enemy.x -= enemy.width / config.enemySpeedDividers.hard;
			else
				enemy.x -= enemy.width / 6;

			if (enemy.x < 0 - enemy.width * 2)
			{
				enemyGroup.members.remove(enemy);
				enemy.destroy();
			}
			else if (FlxCollision.pixelPerfectCheck(enemy, player))
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
		var enemySkin:String = config.enemySkins.normal;

		if (FlxG.random.bool(config.enemyChances.hard))
			enemySkin = config.enemySkins.hard;
		else if (FlxG.random.bool(config.enemyChances.easy))
			enemySkin = config.enemySkins.easy;

		var newEnemy:DreamlandEnemy = new DreamlandEnemy(enemySkin, config.visuals.enemySkinScale);

		newEnemy.setPosition(FlxG.width + newEnemy.width * 2, player.y + FlxG.random.float(-240, 240));
		if (newEnemy.y < 0 + enemy_offscreen_padding)
			newEnemy.y = 0 + enemy_offscreen_padding;
		if (newEnemy.y > FlxG.height - newEnemy.height - enemy_offscreen_padding)
			newEnemy.y = FlxG.height - newEnemy.height - enemy_offscreen_padding;

		enemyGroup.add(newEnemy);
	}
}
