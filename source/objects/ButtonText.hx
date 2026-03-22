package objects;

import flixel.util.FlxColor;
import flixel.util.FlxSignal;
import flixel.FlxG;
import flixel.text.FlxText;

class ButtonText extends FlxText
{
	public var enabled:Bool = true;

	public var onClick:FlxSignal = new FlxSignal();

	override public function new(t:String, e:Bool = true, s:Int = 8, ?x:Float, ?y:Float, ?fw:Float = 0)
	{
        this.enabled = e;

		super(x, y, fw, t, s);

		color = FlxColor.BLACK;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (!enabled)
			return;

		this.underline = FlxG.mouse.overlaps(this);

		if (this.underline && FlxG.mouse.justReleased)
			if (onClick != null)
				onClick.dispatch();
	}
}
