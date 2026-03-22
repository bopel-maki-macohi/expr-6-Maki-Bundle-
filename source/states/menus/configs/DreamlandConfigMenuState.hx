package states.menus.configs;

import flixel.FlxG;

class DreamlandConfigMenuState extends MenuState
{
	public var titleConfig:ButtonText = new ButtonText('Dreamland Config Menu', false, ButtonText.SCALE_MAIN);
    public var defaultConfig:ButtonText = new ButtonText('Default', true, ButtonText.SCALE_HALF);

	override function create()
	{
		super.create();

        titleConfig.screenCenter();
        add(titleConfig);
        titleConfig.y = 10;

		defaultConfig.screenCenter();
		add(defaultConfig);

		defaultConfig.onClick.add(function()
		{
			Constants.selectSfx();
			FlxG.switchState(() -> new Dreamland(DreamlandConfigs.DEFAULT));
		});
	}
}
