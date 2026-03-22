package util.macros;

using StringTools;

class MacroUtil
{
	public static macro function getDefine(key:String, ?defaultValue:String):haxe.macro.Expr
	{
		var value:Null<String> = null;

		try
		{
			value = haxe.macro.Context.definedValue(key);
		}
		catch (_) {}

		if (value == null)
			value = defaultValue;

		trace('$key: $value');

		return macro $v{value};
	}

	public static macro function getDefines():haxe.macro.Expr
	{
		var ignores:Array<String> = [
			'FLX',
			'ANDROID',
			'HXCPP',
			'lime',
			'target',
			'haxe',
			'openfl',
			'JAVA',
			'flixel',
			'hl_',
			'hl-',
			'message',
			'no',
			'tools',
			'utf',
			'sys',
			'static',
			'dce',
			'hscript',
			'native',
			'true',
		];

		var defines:Map<String, String> = [];

		for (key => value in haxe.macro.Context.getDefines())
		{
			var s = false;

			for (ignore in ignores)
				if (!s && (key.startsWith(ignore) || key == ignore || key.endsWith(ignore)))
					s = true;

			if (s)
				continue;

			defines.set(key, value);
		}

		for (key => value in defines)
			trace('$key : $value');

		return macro $v{defines};
	}
}
