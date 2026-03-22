package states.menus;

import flixel.util.FlxColor;
import flixel.FlxG;

class WebInitMenu extends AboutMenuState
{
	public dynamic function endingFunction()
	{
		FlxG.switchState(() -> new TitleMenuState());
	}

	override public function new(?endingFunction:Void->Void)
	{
		super();

		if (endingFunction != null)
			this.endingFunction = endingFunction;
	}

	override function create()
	{
		super.create();

		aboutText.text = AssetsUtil.getText('menus/web-init.txt');
		aboutText.size = ButtonText.SCALE_HALF;
		aboutText.screenCenter();

		FlxG.camera.bgColor = FlxColor.BLACK;

		remove(back);

		aboutText.color = FlxColor.WHITE;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.mouse.justReleased)
			endingFunction();
	}
}
