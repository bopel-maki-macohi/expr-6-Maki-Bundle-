package states.play.dreamland;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
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
			normal: 0, // doesnt matter
		},
		visuals: {
			enemySkinScale: 2,
			background: 'default',
			player: 'default',
		},
		methods: {
			spawnEnemy: (enemy, player) -> {},
			hitEnemy: (enemy, bullet) ->
			{
				return true;
			},
		},
		tweaks: {
			bullets: 2,
			id: 'default',
		},
	};

	public static final GEHENNA:DreamlandConfig = CONFIG_MANAGER.makeConfig('gehenna', [
		'enemyScores' => ['easy' => 25, 'normal' => 54, 'hard' => 70],
		'enemySpeedDividers' => ['easy' => 5, 'normal' => 4, 'hard' => 2.5],
		'enemySkins' => ['easy' => 'easy-gehenna', 'normal' => 'normal-gehenna', 'hard' => 'hard-gehenna'],
		'visuals' => ['enemySkinScale' => 1, 'background' => 'gehenna'],
		'tweaks' => ['id' => 'gehenna',]
	]);

	public static final LUES:DreamlandConfig = CONFIG_MANAGER.makeConfig('lues', [
		'enemyScores' => ['easy' => 34, 'normal' => 65, 'hard' => 75],
		'enemySpeedDividers' => ['easy' => 4, 'normal' => 3.5, 'hard' => 4],
		'enemySkins' => ['easy' => 'easy-lues', 'normal' => 'normal-lues', 'hard' => 'hard-lues'],
		'enemyChances' => ['easy' => 25, 'hard' => 2.5],
		'visuals' => ['enemySkinScale' => 1, 'background' => 'lues', 'player' => 'four_bullets'],
		'methods' => [
			'spawnEnemy' => (enemy:DreamlandEnemy, player:DreamlandPlayer) ->
			{
				if (enemy.enemySkin != 'hard-lues')
					return;
				enemy.y = player.y * FlxG.random.float(0.99, 1.01);
				enemy.data.hits = 2;
			},
			'hitEnemy' => (enemy:DreamlandEnemy, bullet:DreamlandBullet) ->
			{
				if (enemy.enemySkin != 'hard-lues')
					return true;
				return multipleHitEnemy(enemy, bullet);
			}
		],
		'tweaks' => ['bullets' => 4, 'id' => 'lues',]
	]);

	public static final SHADOWS:DreamlandConfig = CONFIG_MANAGER.makeConfig('shadows', [
		'enemyScores' => ['easy' => 45, 'normal' => 75, 'hard' => 90],
		'enemySpeedDividers' => ['easy' => 8, 'normal' => 5, 'hard' => 3],
		'enemySkins' => ['easy' => 'easy-shadows', 'normal' => 'normal-shadows', 'hard' => 'hard-shadows'],
		'enemyChances' => ['easy' => 36, 'hard' => 3],
		'visuals' => ['background' => 'shadows', 'player' => 'four_bullets'],
		'methods' => [
			'spawnEnemy' => (enemy:DreamlandEnemy, player:DreamlandPlayer) ->
			{
				enemy.data.hits = 3;
			},
			'hitEnemy' => multipleHitEnemy,
		],
		'tweaks' => ['bullets' => 4, 'id' => 'shadows',]
	]);

	static function multipleHitEnemy(enemy:DreamlandEnemy, bullet:DreamlandBullet):Bool
	{
		enemy.setColorTransform(2, 2, 2);

		FlxTween.tween(enemy.colorTransform, {
			redMultiplier: 1,
			greenMultiplier: 1,
			blueMultiplier: 1,
		}, .1 * enemy.data.hits, {
			ease: FlxEase.sineInOut
		});

		enemy.data.hits--;
		if (enemy.data.hits > 0)
			return false;

		return true;
	}
}
