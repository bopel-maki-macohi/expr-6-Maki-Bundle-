package states.menus;

import flixel.FlxG;

class BackMenuState extends MenuState
{
	public var back:ButtonText = new ButtonText('Back', true, ButtonText.SCALE_HALF);

	override function create()
	{
		super.create();

		add(back);
		back.onClick.add(onBack);
	}

	public function onBack()
	{
		FlxG.switchState(() -> new TitleMenuState());
	}
}
