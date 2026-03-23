package states.play.dreamland;

class DreamlandConfigs
{
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
	};

	public static var GEHENNA(get, never):DreamlandConfig;

	static function get_GEHENNA():DreamlandConfig
	{
		var c = DEFAULT;

		c.enemyScores = {
			easy: 25,
			normal: 54,
			hard: 97,
		}
		
		c.enemySpeedDividers = {
			easy: 5,
			normal: 4,
			hard: 3,
		}

		c.enemySkins = {
			easy: 'easy-gehenna',
			normal: 'normal-gehenna',
			hard: 'hard-gehenna',
		}

		c.background = 'default';

		c.enemySkinScale = 1;

		return c;
	}
}
