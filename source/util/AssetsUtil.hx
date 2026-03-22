package util;

class AssetsUtil
{
	public static function path(asset:String)
		return 'assets/$asset';

	public static function image(image:String)
		return path('$image.png');

	public static function sound(sound:String)
		return path('$sound.wav');
}
