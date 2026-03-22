package states.menus;

import flixel.FlxG;
import flixel.FlxSprite;

class TitleMenuState extends MenuState
{
	public var logo:FlxSprite = new FlxSprite(0, 0, AssetsUtil.image('menus/title/logo'));
	public var versionText:ButtonText = new ButtonText(VersionUtil.getVersion(true), false, ButtonText.SCALE_HALF);

	public var funding:Funding = new Funding((Defines.FORCE_FUNDING_POPUP) ? true : null);

	public var play:ButtonSprite = new ButtonSprite(0, 0, AssetsUtil.image('menus/title/play'));
	public var about:ButtonSprite = new ButtonSprite(0, 0, AssetsUtil.image('menus/title/about'));
	public var credits:ButtonSprite = new ButtonSprite(0, 0, AssetsUtil.image('menus/title/credits'));
	public var options:ButtonSprite = new ButtonSprite(0, 0, AssetsUtil.image('menus/title/options'));

	public var bugReportText:ButtonText = new ButtonText('Report Bugs', true, ButtonText.SCALE_HALF);

	override function create()
	{
		super.create();

		funding.scale.set(0.5, 0.5);
		funding.updateHitbox();

		if (funding.enabled)
			add(funding);

		funding.x = FlxG.width - (funding.width * 0.85);
		funding.y = FlxG.height - (funding.height);

		logo.scale.set(0.5, 0.5);
		logo.updateHitbox();

		logo.setPosition(-20, -20);
		add(logo);

		bugReportText.setPosition(FlxG.width - bugReportText.width, FlxG.height - bugReportText.height);
		add(bugReportText);

		if (funding.enabled)
			bugReportText.x = 0;

		bugReportText.onClick.add(function()
		{
			FlxG.openURL(Constants.LINK_GITHUB);
		});

		final menuItems = [play, about, credits, options];
		final disabledMenuItem = [false, false, false, true];
		for (i in 0...menuItems.length)
		{
			menuItems[i].ID = i;
			menuItems[i].enabled = !disabledMenuItem[i];
			add(menuItems[i]);

			menuItems[i].screenCenter();
			menuItems[i].y *= 0.125 * 0.125 * 0.125 * 0.125;

			if (funding.enabled)
			{
				menuItems[i].x *= 1.75;

				menuItems[i].y += i * 96;
			}
			else
			{
				menuItems[i].x *= 2;

				menuItems[i].y += i * 112;
			}

			menuItems[i].x -= i * 128;

			if (disabledMenuItem[i])
				menuItems[i].alpha = 0.5;

			menuItems[i].onOverlap.add(function()
			{
				menuItems[i].setColorTransform(1.2, 1.2, 1.2);
			});

			menuItems[i].onUnoverlap.add(function()
			{
				menuItems[i].setColorTransform(1.0, 1.0, 1.0);
			});
		}

		versionText.setPosition(logo.x + (logo.width / 1.3), logo.y + (logo.height * 0.1));
		add(versionText);

		play.onClick.add(() -> FlxG.switchState(() -> new PlayMenuState()));
		about.onClick.add(() -> FlxG.switchState(() -> new AboutMenuState()));
		credits.onClick.add(() -> FlxG.switchState(() -> new CreditsMenuState()));
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
