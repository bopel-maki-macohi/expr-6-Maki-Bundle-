package states.menus.configs;

import flixel.FlxG;

class AliotowConfigMenuState extends ConfigMenuState<AliotowConfig>
{
	override function addConfigs()
	{
		super.addConfigs();

		titleConfig.text = 'Aliotow Config Menu';
		spacingMultiplier = 2;

		makeConfigText('Default', AliotowConfigs.DEFAULT);
	}

	override function moveState(data:AliotowConfig)
	{
		super.moveState(data);

		FlxG.switchState(() -> new Aliotow(data));
	}
}
