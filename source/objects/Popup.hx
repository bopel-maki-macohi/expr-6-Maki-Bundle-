package objects;

import flixel.FlxG;

class Popup extends ButtonSprite
{
	override public function new(popup:String, ?enabled:Null<Bool>)
	{
		super(0, 0, AssetsUtil.image('popups/$popup'));

		this.enabled = enabled ?? false;

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
