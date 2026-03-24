package states.menus.configs;

import flixel.FlxG;

class ConfigMenuState<T> extends BackMenuState
{
	public var titleConfig:ButtonText = new ButtonText('Config Menu', false, ButtonText.SCALE_MAIN);

	public var spacingMultiplier:Float = 1.5;

	private var i = 0;
	private var x = 0.0;
	private var y = 0.0;

	override function create()
	{
		super.create();

		add(titleConfig);
		titleConfig.y = 10;

		x = 10;
		y = titleConfig.y + titleConfig.height + 10;

		addConfigs();

		titleConfig.screenCenter(X);
	}

	public function addConfigs() {}

	public function makeConfigText(configName:String, configData:T)
	{
		var configText = new ButtonText(configName, true, ButtonText.SCALE_HALF, x, y);

		if ((x + configText.width * spacingMultiplier) > (FlxG.width - configText.width))
		{
			x = 10;
			y += configText.height * spacingMultiplier;

			configText.setPosition(x, y);
		}
		else
		{
			x += configText.width * spacingMultiplier;
		}

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
