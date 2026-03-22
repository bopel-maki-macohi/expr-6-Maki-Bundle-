package states.menus;

import flixel.util.FlxColor;
import flixel.FlxG;

class CreditsMenuState extends BackMenuState
{
    public var creditText:ButtonText = new ButtonText('Credits.com', false, 8, 0, 0, FlxG.width);

	override function create()
	{
		super.create();

        creditText.text = AssetsUtil.getText('menus/credits.txt');
        creditText.y += back.y + back.height;
        creditText.alignment = CENTER;
        add(creditText);

        FlxG.camera.bgColor = FlxColor.BLACK;
        back.color = FlxColor.WHITE;
        creditText.color = FlxColor.WHITE;
	}
}
