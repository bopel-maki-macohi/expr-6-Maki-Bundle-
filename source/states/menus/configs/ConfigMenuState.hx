package states.menus.configs;

import flixel.FlxG;

class ConfigMenuState<T> extends BackMenuState
{
	public var titleConfig:ButtonText = new ButtonText('Config Menu', false, ButtonText.SCALE_MAIN);

	public var spacing:Float = 256;

	private var i = 0;

	override function create()
	{
		super.create();

		add(titleConfig);
		titleConfig.y = 10;

		addConfigs();
		
		titleConfig.screenCenter(X);
	}

	public function addConfigs() {}

	public function makeConfigText(configName:String, configData:T)
	{
		var configText = new ButtonText(configName, true, ButtonText.SCALE_HALF, 10, titleConfig.y + titleConfig.height + 10);
		configText.x += spacing * i;
		add(configText);
		configText.onClick.add(function()
		{
			Constants.selectSfx();
			moveState(configData);
		});

		i++;
	}

	public function moveState(data:T) {}
}
