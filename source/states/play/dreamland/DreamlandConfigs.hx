package states.play.dreamland;

class DreamlandConfigs
{
	static var CONFIG_MANAGER(get, never):ConfigManager<DreamlandConfig>;

	static function get_CONFIG_MANAGER():ConfigManager<DreamlandConfig>
	{
		return new ConfigManager<DreamlandConfig>('dreamland', DEFAULT);
	}

	public static final DEFAULT:DreamlandConfig = {
		enemySpeedDividers: {
			easy: 7,
			normal: 5,
			hard: 3,
		},
		enemyScores: {
			easy: 10,
			normal: 30,
			hard: 60,
		},
		enemySkins: {
			easy: 'easy',
			normal: 'normal',
			hard: 'hard',
		},
		enemyChances: {
			easy: 30,
			hard: 7.5,
		},
		visuals: {
			enemySkinScale: 2,
			background: 'default'
		}
	};

	public static var GEHENNA(get, never):DreamlandConfig;

	static function get_GEHENNA()
		return CONFIG_MANAGER.makeConfig('gehenna', [
			'enemyScores' => ['easy' => 25, 'normal' => 54, 'hard' => 97],
			'enemySpeedDividers' => ['easy' => 5, 'normal' => 4, 'hard' => 3],
			'enemySkins' => ['easy' => 'easy-gehenna', 'normal' => 'normal-gehenna', 'hard' => 'hard-gehenna'],
			'visuals' => ['enemySkinScale' => 1, 'background' => 'gehenna'],
		]);
}
