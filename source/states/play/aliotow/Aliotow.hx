package states.play.aliotow;

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

		highscore = Reflect.field(Save.getDataFieldField('highscores', 'aliotow'), this.config.tweaks.id);

		if (highscore == null)
			highscore = 0;
	}

	override function create()
	{
		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (score > highscore)
			highscore = score;
		Reflect.setField(Save.getDataFieldField('highscores', 'aliotow'), config.tweaks.id, highscore);
	}

	override function unpausedUpdate()
	{
		super.unpausedUpdate();
	}
}
