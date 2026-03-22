package states.menus;

import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;

class TitleMenuState extends FlxState
{
	public var logo:FlxSprite = new FlxSprite(0, 0, AssetsUtil.image('title/logo'));
	public var versionText:FlxText = new FlxText(0, 0, 0, 'V${VersionUtil.getVersion()}', 16);

	public var funding:Funding = new Funding(#if FORCE_FUNDING_POPUP true #else null #end);

	override function create()
	{
		super.create();

		FlxG.camera.bgColor = FlxColor.WHITE;

		funding.scale.set(0.5, 0.5);
		funding.updateHitbox();

		if (Save.getBool('shamelessPlug'))
			add(funding);

		funding.x = FlxG.width - (funding.width * 0.8);
		funding.y = FlxG.height - (funding.height);

		logo.scale.set(0.5, 0.5);
		logo.updateHitbox();

		logo.setPosition(-20, -20);
		add(logo);

		versionText.setPosition(logo.x + (logo.width / 1.3), logo.y + (logo.height / 1.5));
		add(versionText);
		versionText.color = FlxColor.BLACK;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
