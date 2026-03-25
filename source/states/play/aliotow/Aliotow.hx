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
		spawnEnemy();

		add(bullets);

		player.screenCenter();
		player.y = FlxG.height - player.height;
		add(player);

		appendBaseObjects();
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
	}

	public function spawnEnemy()
	{
		var x = 0;
		var y = 0;

		var enemySpacingOffset:Int = config.enemies.spacing;

		while (y < config.enemies.vertical_count)
		{
			while (x < config.enemies.horizontal_count)
			{
				var newEnemy:AliotowEnemy = new AliotowEnemy();
				enemies.add(newEnemy);

				newEnemy.screenCenter();

				final xInc = (newEnemy.width + enemySpacingOffset);
				final yInc = (newEnemy.height + enemySpacingOffset);

				newEnemy.x += xInc * (x - (config.enemies.horizontal_count / 2));
				newEnemy.y += yInc * (y - (config.enemies.vertical_count / 2));

				x++;
			}

			x = 0;
			y++;
		}
	}
}
