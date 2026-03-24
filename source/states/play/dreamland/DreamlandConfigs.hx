package states.play.dreamland;

import flixel.FlxG;

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
		},
		methods: {
			spawnEnemy: (enemy, player) -> {}
		}
	};

	public static final GEHENNA:DreamlandConfig = CONFIG_MANAGER.makeConfig('gehenna', [
		'enemyScores' => ['easy' => 25, 'normal' => 54, 'hard' => 97],
		'enemySpeedDividers' => ['easy' => 5, 'normal' => 4, 'hard' => 3],
		'enemySkins' => ['easy' => 'easy-gehenna', 'normal' => 'normal-gehenna', 'hard' => 'hard-gehenna'],
		'visuals' => ['enemySkinScale' => 1, 'background' => 'gehenna'],
	]);

	public static final LUES:DreamlandConfig = CONFIG_MANAGER.makeConfig('lues', [
		'enemyScores' => ['easy' => 17, 'normal' => 75, 'hard' => 130],
		'enemySpeedDividers' => ['easy' => 6, 'normal' => 3, 'hard' => 2],
		'enemySkins' => ['easy' => 'easy-lues', 'normal' => 'normal-lues', 'hard' => 'hard-lues'],
		'enemyChances' => ['easy' => 25, 'hard' => 2.5],
		'visuals' => ['enemySkinScale' => 1, 'background' => 'gehenna'],
		'methods' => [
			'spawnEnemy' => (enemy, player) ->
			{
				if (enemy.enemySkin == 'hard-lues')
					enemy.y = player.y * FlxG.random.float(0.99, 1.01);
			}
		]
	]);
}
