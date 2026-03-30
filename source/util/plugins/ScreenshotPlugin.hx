package util.plugins;

import flixel.FlxG;
import flixel.FlxBasic;
import flixel.util.FlxTimer;
import openfl.display.BitmapData;
import openfl.display.PNGEncoderOptions;
import openfl.utils.ByteArray;
import sys.io.File;

/**
	A plugin that allows the player to take screenshots.
    
	Base Code yoinked from WTFEngine: https://github.com/VirtuGuy/WTF-Engine/blob/main/source/funkin/util/plugins/ScreenshotPlugin.hx
 */
class ScreenshotPlugin extends FlxBasic
{
	var tookScreenshot:Bool = false;

	public static function init()
		FlxG.plugins.addPlugin(new ScreenshotPlugin());

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.F3 && !tookScreenshot)
		{
			tookScreenshot = true;

			var data:BitmapData = BitmapData.fromImage(FlxG.stage.window.readPixels());
			var bytes:ByteArray = data.encode(data.rect, new PNGEncoderOptions());

			File.saveBytes('screenshot.png', bytes);

			FlxTimer.wait(1, () ->
			{
				tookScreenshot = false;
			});
		}
	}
}
