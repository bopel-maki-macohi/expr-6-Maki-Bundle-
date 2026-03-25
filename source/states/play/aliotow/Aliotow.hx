package states.play.aliotow;

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
}
