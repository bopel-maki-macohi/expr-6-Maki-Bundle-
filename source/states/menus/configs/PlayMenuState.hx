package states.menus.configs;

import flixel.FlxG;

class PlayMenuState extends ConfigMenuState<ConfigMenuState<Any>>
{
	override function addConfigs()
	{
		super.addConfigs();

		titleConfig.text = 'Play Menu';
		spacingMultiplier = 2;

		makeConfigText('Dreamland', new DreamlandConfigMenuState());
		makeConfigText('Aliotow', new AliotowConfigMenuState());
		makeConfigText('Seault', null);
		makeConfigText('Spedat', null);
		makeConfigText('Kiolets', null);
	}

	override function moveState(data:ConfigMenuState<Any>)
	{
		super.moveState(data);

		FlxG.switchState(() -> data);
	}

	override function onBack()
	{
		Constants.selectSfx();
		FlxG.switchState(() -> new TitleMenuState());
	}
}
