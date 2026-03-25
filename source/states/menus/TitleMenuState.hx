package states.menus;

import flixel.FlxG;
import flixel.FlxSprite;

class TitleMenuState extends MenuState
{
	public var logo:FlxSprite = new FlxSprite(0, 0, AssetsUtil.image('menus/title/logo'));
	public var versionText:ButtonText = new ButtonText(VersionUtil.getVersion(), false, ButtonText.SCALE_HALF);

	public var popup:Popup;

	public var play:ButtonSprite = new ButtonSprite(0, 0, AssetsUtil.image('menus/title/play'));
	public var about:ButtonSprite = new ButtonSprite(0, 0, AssetsUtil.image('menus/title/about'));
	public var credits:ButtonSprite = new ButtonSprite(0, 0, AssetsUtil.image('menus/title/credits'));
	public var options:ButtonSprite = new ButtonSprite(0, 0, AssetsUtil.image('menus/title/options'));

	public var bugReportText:ButtonText = new ButtonText('Report Bugs', true, ButtonText.SCALE_HALF);

	override function create()
	{
		super.create();

		logo.updateHitbox();

		logo.setPosition(-80, -40);
		add(logo);

		bugReportText.setPosition(FlxG.width - bugReportText.width, FlxG.height - bugReportText.height);
		add(bugReportText);

		bugReportText.onClick.add(function()
		{
			Constants.selectSfx();
			FlxG.openURL(Constants.LINK_GITHUB_ISSUES);
		});

		final menuItems = [play, about, credits, options];
		final disabledMenuItem = [false, false, false, true];
		for (i in 0...menuItems.length)
		{
			menuItems[i].ID = i;
			menuItems[i].enabled = !disabledMenuItem[i];
			add(menuItems[i]);

			menuItems[i].screenCenter();
			menuItems[i].x *= 2;
			menuItems[i].y *= 0.125 * 0.125 * 0.125 * 0.125;

			menuItems[i].x -= i * (128 * 2.75);
			menuItems[i].y += i * (128 * 1.25);

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

		versionText.setPosition(10, 10);
		add(versionText);

		play.onClick.add(() -> FlxG.switchState(() -> new PlayMenuState()));
		about.onClick.add(() -> FlxG.switchState(() -> new AboutMenuState()));
		credits.onClick.add(() -> FlxG.switchState(() -> new CreditsMenuState()));

		for (i in 0...menuItems.length)
			menuItems[i].onClick.add(Constants.selectSfx);

		if ((Defines.FORCE_FUNDING_POPUP) ? true : Save.data.shamelessPlug)
		{
			popup = new Popup('funding', true);

			popup.onClick.add(function()
			{
				Constants.selectSfx();
				FlxG.openURL(Constants.LINK_KOFI);
			});
		}
		else if ((Defines.FORCE_UPDATE_POPUP) ? true : ((VersionUtil.getRawVersion() != UpdateUtil.latestVersion)
			&& Defines.PRE_RELEASE == null))
		{
			final updateType = VersionUtil.compareVersions(VersionUtil.getRawVersion(), UpdateUtil.latestVersion);

			switch (updateType)
			{
				case major, minor:
					popup = new Popup('update-content', true);

				case patch:
					popup = new Popup('update-patch', true);

				default:
			}

			if (popup != null)
				popup.onClick.add(function()
				{
					Constants.selectSfx();
					FlxG.openURL(Constants.LINK_GITHUB_RELEASES);
				});
		}

		if (popup != null && popup.enabled)
		{
			add(popup);
			bugReportText.x = 0;

			popup.scale.set(0.75, 0.75);
			popup.updateHitbox();

			popup.x = FlxG.width - (popup.width * 1);
			popup.y = FlxG.height - (popup.height);
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
