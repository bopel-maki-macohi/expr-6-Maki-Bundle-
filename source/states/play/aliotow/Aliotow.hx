package states.play.aliotow;

import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.group.FlxGroup.FlxTypedGroup;

class Aliotow extends PlayState
{
	public var config:AliotowConfig;

	public var score:Int = 0;
	public var highscore:Null<Int> = null;

	override public function new(config:AliotowConfig)
	{
		super();

		this.config = config;
		trace('Config: ${this.config.tweaks.id}');

		highscore = Save.getHighscore('aliotow', config.tweaks.id);

		if (highscore == null)
			highscore = 0;
	}

	public var player:AliotowPlayer = new AliotowPlayer();

	public var bullets:FlxTypedSpriteGroup<AliotowBullet> = new FlxTypedSpriteGroup<AliotowBullet>();
	public var enemies:FlxTypedSpriteGroup<AliotowEnemy> = new FlxTypedSpriteGroup<AliotowEnemy>();

	override function create()
	{
		super.create();

		add(enemies);

		add(bullets);

		player.screenCenter();
		player.y = FlxG.height - player.height;
		add(player);

		appendBaseObjects();

		FlxG.mouse.visible = true;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (score > highscore)
			highscore = score;
		Save.setHighscore('aliotow', config.tweaks.id, highscore);
	}

	override function unpausedUpdate()
	{
		super.unpausedUpdate();

		if (FlxG.random.int(0, 45) == 5)
			spawnEnemy();

		for (enemy in enemies)
		{
			if (enemy == null)
				continue;

			enemy.x -= enemy.width / 4;

			if (enemy.x < (enemy.width * -2))
			{
				enemies.remove(enemy);
				enemy.destroy();
				continue;
			}

			if (FlxG.mouse.overlaps(enemy) && FlxG.mouse.justPressed)
			{
				Constants.flashSprite(enemy, .1 * enemy.health);

				enemy.health--;

				if (enemy.health <= 0)
				{
					enemies.remove(enemy);
					enemy.destroy();
				}
			}
		}
	}

	public function spawnEnemy()
	{
		var newEnemy:AliotowEnemy = new AliotowEnemy();
		newEnemy.screenCenter();

		newEnemy.y *= FlxG.random.float(.8, 1.2);
		newEnemy.x = FlxG.width + (newEnemy.width * 2);

		for (enemy in enemies)
		{
			if (newEnemy.overlaps(enemy))
				return;
			else
				continue;
		}

		enemies.add(newEnemy);
	}
}
