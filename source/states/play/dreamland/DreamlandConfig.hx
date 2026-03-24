package states.play.dreamland;

typedef DreamlandConfig =
{
	enemySpeedDividers:DreamlandEnemyDifficultys<Float>,
	enemyScores:DreamlandEnemyDifficultys<Int>,
	enemySkins:DreamlandEnemyDifficultys<String>,
	enemyChances:DreamlandEnemyDifficultys<Float>,

	visuals:
	{
		enemySkinScale:Float, background:String, player:String,
	},

	methods:DreamlandConfigMethods,
	tweaks:
	{
		bullets:Int,
	},
}

typedef DreamlandConfigMethods =
{
	spawnEnemy:(enemy:DreamlandEnemy, player:DreamlandPlayer) -> Void,
	hitEnemy:(enemy:DreamlandEnemy, bullet:DreamlandBullet) -> Bool,
}

typedef DreamlandEnemyDifficultys<T> =
{
	easy:T,
	normal:T,
	hard:T,
}
