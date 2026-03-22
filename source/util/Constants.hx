package util;

class Constants
{
	public static final LINK_GITHUB:String = 'https://github.com/bopel-maki-macohi/expr-6-Maki-Bundle-/issues';
	public static final LINK_KOFI:String = 'https://ko-fi.com/bopel_maki_macohi/goal?g=0';

	public static var GENERATED_BY(get, never):String;

	static function get_GENERATED_BY():String
	{
		return 'Maki Bundle ${VersionUtil.getVersion()}';
	}
}
