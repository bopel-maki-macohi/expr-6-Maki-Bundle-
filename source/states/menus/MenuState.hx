package states.menus;

import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxState;

class MenuState extends FlxState
{
	override function create()
	{
		super.create();

		FlxG.camera.bgColor = FlxColor.WHITE;
		FlxG.mouse.visible = true;
	}
}
