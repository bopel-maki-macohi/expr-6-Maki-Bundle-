package util;

class Defines
{
	public static final hashlink:Bool = MacroUtil.getDefine('hl') == '1';

	public static final debug:Bool = MacroUtil.getDefine('debug') == '1';
	public static final indev:Bool = MacroUtil.getDefine('indev') == '1';

	public static final CLEAR_SAVE:Bool = MacroUtil.getDefine('CLEAR_SAVE') == '1';
	public static final FORCE_FUNDING_POPUP:Bool = MacroUtil.getDefine('FORCE_FUNDING_POPUP') == '1';
	public static final PRE_RELEASE:String = MacroUtil.getDefine('PRE_RELEASE');
}
