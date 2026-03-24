package states.menus.configs;

import flixel.FlxG;

class DreamlandConfigMenuState extends ConfigMenuState<DreamlandConfig>
{
	override function addConfigs()
	{
		super.addConfigs();

		titleConfig.text = 'Dreamland Config Menu';

		makeConfigText('Default', DreamlandConfigs.DEFAULT);
		makeConfigText('Gehenna', DreamlandConfigs.GEHENNA);
		makeConfigText('Lues', DreamlandConfigs.LUES);
		makeConfigText('Shadows', DreamlandConfigs.SHADOWS);
	}

	override function moveState(data:DreamlandConfig)
	{
		super.moveState(data);

		FlxG.switchState(() -> new Dreamland(data));
	}
}
