package objects;

import flixel.FlxG;
import flixel.FlxSprite;

class Funding extends FlxSprite
{
	public var enabled:Bool = false;

	override public function new(?enabled:Null<Bool>)
	{
		super(0, 0, AssetsUtil.image('title/shameless-plug'));

		this.enabled = enabled ?? Save.getBool('shamelessPlug');
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (this.enabled)
		{
			final mouseX = FlxG.mouse.x;
			final mouseY = FlxG.mouse.y;

			final fundingTargetX = getGraphicMidpoint().x;
			final fundingTargetY = getGraphicMidpoint().y;

			final negativeX = 1.3;
			final positiveX = 0.7;

			final negativeY = 1.7;
			final positiveY = 0.8;

			if ((mouseX < fundingTargetX * negativeX && mouseX > fundingTargetX * positiveX)
				&& (mouseY < fundingTargetY * negativeY && mouseY > fundingTargetY * positiveY))
			{
				setColorTransform(1.2, 1.2, 1.2);

				if (FlxG.mouse.justReleased)
					FlxG.openURL('https://ko-fi.com/bopel_maki_macohi/goal?g=0');
			}
			else
				setColorTransform(1.0, 1.0, 1.0);
		}
	}
}
