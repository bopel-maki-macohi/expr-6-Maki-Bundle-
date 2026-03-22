package states.menus;

import lime.utils.Assets;
import flixel.FlxG;

class AboutMenuState extends MenuState
{
    public var back:ButtonText = new ButtonText('Back', true, 16);

    public var aboutText:ButtonText = new ButtonText('About.com', false, 8, 0, 0, FlxG.width);

	override function create()
	{
		super.create();

        add(back);
        back.onClick.add(function() {
            FlxG.switchState(() -> new TitleMenuState());
        });

        aboutText.text = AssetsUtil.getText('menus/about.txt');
        aboutText.y += back.y + back.height;
        aboutText.alignment = CENTER;
        add(aboutText);
	}
}
