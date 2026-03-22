package util;

import lime.app.Application;

using StringTools;

class VersionUtil
{
	public static function getVersion()
	{
		var v:String = Application.current.meta.get('version');

		if (v.endsWith('.0'))
			v = v.substr(0, v.length - 2);

		return v;
	}
}
