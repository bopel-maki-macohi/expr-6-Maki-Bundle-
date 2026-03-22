package states.menus;

import flixel.util.FlxColor;
import flixel.FlxG;

class CreditsMenuState extends AboutMenuState
{
	override function create()
	{
		super.create();

        aboutText.text = AssetsUtil.getText('menus/credits.txt');
        aboutText.y += back.y + back.height;

        FlxG.camera.bgColor = FlxColor.BLACK;
        back.color = FlxColor.WHITE;
        aboutText.color = FlxColor.WHITE;
	}
}
