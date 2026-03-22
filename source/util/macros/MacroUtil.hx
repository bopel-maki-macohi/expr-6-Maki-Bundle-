package util.macros;

class MacroUtil
{
	public static macro function getDefine(key:String, ?defaultValue:String):haxe.macro.Expr
	{
		var pos = haxe.macro.Context.currentPos();

		var value:Null<String> = null;

		try
		{
			value = haxe.macro.Context.definedValue(key);
		}
		catch (_) {}

		if (value == null)
			value = defaultValue;

		haxe.macro.Context.info('Define($key): $value', pos);
		return macro $v{value};
	}
}
