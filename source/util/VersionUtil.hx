package util;

import haxe.macro.Compiler;
import lime.app.Application;

using StringTools;

class VersionUtil
{
	public static function getVersion(linebreakBetweenBits:Bool = false)
	{
		var v:String = 'v';
		v += Application.current.meta.get('version');

		if (v.endsWith('.0'))
			v = v.substr(0, v.length - 2);

		if (Constants.DEFINE_PRERELEASE != null)
		{
			if (linebreakBetweenBits)
				v += '\n';
			else
				v += ' ';

			v += '(pre-release ${Constants.DEFINE_PRERELEASE})';
		}

		return v;
	}
}
