package states.menus;

class PlayMenuState extends BackMenuState
{
	override function create()
	{
		super.create();

		var dreamlandMinigame:ButtonText = new ButtonText('Dreamland', true, ButtonText.SCALE_MAIN, 50, 50);
		add(dreamlandMinigame);
	}
}
