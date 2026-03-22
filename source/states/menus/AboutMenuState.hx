package states.menus;

import flixel.FlxG;

class AboutMenuState extends BackMenuState
{
    public var aboutText:ButtonText = new ButtonText('About.com', false, ButtonText.SCALE_HALF, 0, 0, FlxG.width);

	override function create()
	{
		super.create();

        aboutText.text = AssetsUtil.getText('menus/about.txt');
        aboutText.y += back.y + back.height;
        aboutText.alignment = CENTER;
        add(aboutText);
	}
}
