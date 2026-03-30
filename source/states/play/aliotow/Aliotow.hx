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

		if (FlxG.random.int(0, 20) <= 4)
			spawnEnemy();
	}

	public function spawnEnemy()
	{
		var newEnemy:AliotowEnemy = new AliotowEnemy();
		enemies.add(newEnemy);

		newEnemy.screenCenter();
	}
}
