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

		trace('$key: $value');

		return macro $v{value};
	}
}
