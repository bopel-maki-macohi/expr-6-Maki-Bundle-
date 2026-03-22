package states.menus;

import flixel.FlxG;
import flixel.FlxSprite;

class TitleMenuState extends MenuState
{
	public var logo:FlxSprite = new FlxSprite(0, 0, AssetsUtil.image('title/logo'));
	public var versionText:ButtonText = new ButtonText('V${VersionUtil.getVersion()}', false);

	public var funding:Funding = new Funding(#if FORCE_FUNDING_POPUP true #else null #end);

	public var play:ButtonSprite = new ButtonSprite(0, 0, AssetsUtil.image('title/play'));
	public var about:ButtonSprite = new ButtonSprite(0, 0, AssetsUtil.image('title/about'));
	public var credits:ButtonSprite = new ButtonSprite(0, 0, AssetsUtil.image('title/credits'));
	public var options:ButtonSprite = new ButtonSprite(0, 0, AssetsUtil.image('title/options'));

	public var bugReportText:ButtonText = new ButtonText('Report Bugs', true);

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

		versionText.setPosition(logo.x + (logo.width / 1.3), logo.y + (logo.height / 1.5));
		add(versionText);

		bugReportText.setPosition(FlxG.width - bugReportText.width, FlxG.height - bugReportText.height);
		add(bugReportText);

		if (funding.enabled)
			bugReportText.x = 0;

		bugReportText.onClick.add(function()
		{
			FlxG.openURL('https://github.com/bopel-maki-macohi/expr-6-Maki-Bundle-/issues');
		});

		final menuItems = [play, about, credits, options];
		final disabledMenuItem = [true, false, false, true];
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

			menuItems[i].onClick.add(function()
			{
				trace(i);
			});
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
