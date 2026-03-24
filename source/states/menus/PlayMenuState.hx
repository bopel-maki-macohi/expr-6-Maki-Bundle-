package states.menus;

import flixel.FlxG;

class PlayMenuState extends BackMenuState
{
	override function create()
	{
		super.create();

		var dreamlandMinigame:ButtonText = new ButtonText('Dreamland', true, ButtonText.SCALE_MAIN, 50, 50);
		add(dreamlandMinigame);
		dreamlandMinigame.onClick.add(function()
		{
			Constants.selectSfx();
			FlxG.switchState(() -> new DreamlandConfigMenuState());
		});
		dreamlandMinigame.screenCenter();
	}
}
