package states.play.aliotow;

class AliotowConfigs
{
	static var CONFIG_MANAGER(get, never):ConfigManager<AliotowConfig>;

	static function get_CONFIG_MANAGER():ConfigManager<AliotowConfig>
	{
		return new ConfigManager<AliotowConfig>('aliotow');
	}

	public static var DEFAULT(get, never):AliotowConfig;

	static function get_DEFAULT()
		return CONFIG_MANAGER.getFile('default');
}
