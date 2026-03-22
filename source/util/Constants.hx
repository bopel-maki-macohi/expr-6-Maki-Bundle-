package util;

import haxe.macro.Compiler;

class Constants
{
	public static final LINK_GITHUB:String = 'https://github.com/bopel-maki-macohi/expr-6-Maki-Bundle-/issues';
	public static final LINK_KOFI:String = 'https://ko-fi.com/bopel_maki_macohi/goal?g=0';

	public static final DEFINE_PRERELEASE:String = Compiler.getDefine('PRE_RELEASE').split('=')[0];
}
