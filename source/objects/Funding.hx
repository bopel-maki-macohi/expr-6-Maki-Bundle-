package objects;

import flixel.FlxG;

class Funding extends ButtonSprite
{
	override public function new(?enabled:Null<Bool>)
	{
		super(0, 0, AssetsUtil.image('title/shameless-plug'));

		this.enabled = enabled ?? Save.getBool('shamelessPlug');

		onClick.add(function()
		{
			FlxG.openURL(Constants.LINK_KOFI);
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
