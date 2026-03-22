package util.macros;

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

		var pos = haxe.macro.Context.currentPos();
		haxe.macro.Context.info('$key: $value', pos);

		return macro $v{value};
	}
}
