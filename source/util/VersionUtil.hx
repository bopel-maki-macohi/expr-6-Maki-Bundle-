package util;

import lime.app.Application;

using StringTools;

class VersionUtil
{
	public static function getRawVersion()
	{
		return Application.current.meta.get('version');
	}

	public static function getVersion(linebreakBetweenBits:Bool = false)
	{
		var v:String = 'v';
		v += getRawVersion();

		if (v.endsWith('.0'))
			v = v.substr(0, v.length - 2);

		if (Defines.PRE_RELEASE != null && Std.parseInt(Defines.PRE_RELEASE) > 0)
		{
			if (linebreakBetweenBits)
				v += '\n';
			else
				v += ' ';

			v += '(pre-release ${Defines.PRE_RELEASE})';
		}

		return v;
	}
}
