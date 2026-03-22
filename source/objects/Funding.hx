package objects;

import flixel.FlxG;

class Funding extends ButtonSprite
{
	override public function new(?enabled:Null<Bool>)
	{
		super(0, 0, AssetsUtil.image('title/shameless-plug'));

		this.enabled = enabled ?? Save.getBool('shamelessPlug');

		useDefaultOnClickCondition = false;

		overlapUpdate.add(function()
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
				if (onClick != null)
					onClick.dispatch();
		});

		onClick.add(function()
		{
			FlxG.openURL('https://ko-fi.com/bopel_maki_macohi/goal?g=0');
		});

		onOverlap.add(function()
		{
			setColorTransform(1.2, 1.2, 1.2);
		});

		onUnoverlap.add(function()
		{
			setColorTransform(1.0, 1.0, 1.0);
		});
	}
}
