package util;

import flixel.sound.FlxSound;
import flixel.FlxG;

class Constants
{
	public static final LINK_GITHUB_ISSUES:String = 'https://github.com/bopel-maki-macohi/expr-6-Maki-Bundle-/issues';
	public static final LINK_GITHUB_RELEASES:String = 'https://github.com/bopel-maki-macohi/expr-6-Maki-Bundle-/releases/latest';
	public static final LINK_KOFI:String = 'https://ko-fi.com/bopel_maki_macohi/goal?g=0';

	public static var GENERATED_BY(get, never):String;

	static function get_GENERATED_BY():String
	{
		return 'Maki Bundle ${VersionUtil.getVersion()}';
	}

	public static var SOUND_MENUS_SELECT(get, never):FlxSound;

	static function get_SOUND_MENUS_SELECT():FlxSound
		return new FlxSound().loadEmbedded(AssetsUtil.sound('menus/select'));

	/**
		It's done the way it is because if I purely used
		`FlxG.sound.play` it would sometimes not play the sound.
	**/
	public static function selectSfx()
		SOUND_MENUS_SELECT.play();
}
