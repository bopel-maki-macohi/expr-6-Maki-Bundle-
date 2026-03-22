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

	public var funding:FlxSprite = new FlxSprite(0, 0, AssetsUtil.image('title/shameless-plug'));

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

		if (members.contains(funding))
		{
			final mouseX = FlxG.mouse.x;
			final mouseY = FlxG.mouse.y;

			final fundingTargetX = funding.getGraphicMidpoint().x;
			final fundingTargetY = funding.getGraphicMidpoint().y;

			final negativeX = 1.3;
			final positiveX = 0.7;

			final negativeY = 1.7;
			final positiveY = 0.8;

			if ((mouseX < fundingTargetX * negativeX && mouseX > fundingTargetX * positiveX) && (mouseY < fundingTargetY * negativeY && mouseY > fundingTargetY * positiveY))
			{
				funding.setColorTransform(1.2, 1.2, 1.2);

				if (FlxG.mouse.justReleased)
					FlxG.openURL('https://ko-fi.com/bopel_maki_macohi/goal?g=0');
			}
			else
				funding.setColorTransform(1.0, 1.0, 1.0);
		}
	}
}
