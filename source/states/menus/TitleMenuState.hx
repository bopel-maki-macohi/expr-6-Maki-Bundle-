package states.menus;

import lime.app.Application;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;

class TitleMenuState extends FlxState
{
	public var logo:FlxSprite = new FlxSprite(0, 0, AssetsUtil.image('title/logo'));
    public var versionText:FlxText = new FlxText(0,0, 0, 'V${VersionUtil.getVersion()}', 16);

    override function create() {
        super.create();

        FlxG.camera.bgColor = FlxColor.WHITE;

        logo.scale.set(0.5, 0.5);
        logo.updateHitbox();

        logo.screenCenter();
        logo.y *= 1 / 2;
        logo.x *= 1 / 8;
        
        add(logo);

        versionText.setPosition(logo.x + (logo.width / 1.3), logo.y + (logo.height / 1.5));
        add(versionText);
        versionText.color = FlxColor.BLACK;
    }
}