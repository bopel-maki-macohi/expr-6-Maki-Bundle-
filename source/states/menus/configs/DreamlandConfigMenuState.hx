package states.menus.configs;

import flixel.FlxG;

class DreamlandConfigMenuState extends MenuState
{
	public var titleConfig:ButtonText = new ButtonText('Dreamland Config Menu', false, ButtonText.SCALE_MAIN);

    public var defaultConfig:ButtonText = new ButtonText('Default', true, ButtonText.SCALE_HALF);
    public var gehennaConfig:ButtonText = new ButtonText('Gehenna', true, ButtonText.SCALE_HALF);

	override function create()
	{
		super.create();

        titleConfig.screenCenter();
        add(titleConfig);
        titleConfig.y = 10;

        defaultConfig.x = 10;
        defaultConfig.y = titleConfig.y + titleConfig.height + 10;

        defaultConfig.screenCenter();
        defaultConfig.x -= defaultConfig.width;

        gehennaConfig.setPosition(defaultConfig.x + (defaultConfig.width * 2), defaultConfig.y);

		defaultConfig.onClick.add(function()
		{
			Constants.selectSfx();
			FlxG.switchState(() -> new Dreamland(DreamlandConfigs.DEFAULT));
		});

		gehennaConfig.onClick.add(function()
		{
			Constants.selectSfx();
			FlxG.switchState(() -> new Dreamland(DreamlandConfigs.GEHENNA));
		});	
        
        add(defaultConfig);
		add(gehennaConfig);
	}
}
