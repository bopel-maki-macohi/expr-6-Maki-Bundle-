package states.play.dreamland;

class DreamlandConfigs
{
	public static var DEFAULT:DreamlandConfig = {
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
}
