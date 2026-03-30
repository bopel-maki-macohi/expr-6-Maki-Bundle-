package states.play.dreamland;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxG;

class DreamlandConfigs
{
	static var CONFIG_MANAGER(get, never):ConfigManager<DreamlandConfig>;

	static function get_CONFIG_MANAGER():ConfigManager<DreamlandConfig>
	{
		return new ConfigManager<DreamlandConfig>('dreamland');
	}

	public static var DEFAULT(get, never):DreamlandConfig;

	static function get_DEFAULT()
		return CONFIG_MANAGER.getFile('default');

	public static var GEHENNA(get, never):DreamlandConfig;

	static function get_GEHENNA()
		return CONFIG_MANAGER.getFile('gehenna');

	public static var LUES(get, never):DreamlandConfig;

	static function get_LUES()
	{
		var c:DreamlandConfig = CONFIG_MANAGER.getFile('lues');

		c.methods = {
			spawnEnemy: (enemy:DreamlandEnemy, player:DreamlandPlayer) ->
			{
				if (enemy.enemySkin != 'hard-lues')
					return;
				enemy.y = player.y * FlxG.random.float(0.99, 1.01);
				enemy.data.hits = 2;
			},
			hitEnemy: (enemy:DreamlandEnemy, bullet:DreamlandBullet) ->
			{
				if (enemy.enemySkin != 'hard-lues')
					return true;
				return multipleHitEnemy(enemy, bullet);
			},
		}

		return c;
	}

	public static var SHADOWS(get, never):DreamlandConfig;

	static function get_SHADOWS()
	{
		var c:DreamlandConfig = CONFIG_MANAGER.getFile('shadows');

		c.methods = {
			hitEnemy: multipleHitEnemy,
			spawnEnemy: (enemy:DreamlandEnemy, player:DreamlandPlayer) ->
			{
				enemy.data.hits = 3;
			}
		}

		return c;
	}

	static function multipleHitEnemy(enemy:DreamlandEnemy, bullet:DreamlandBullet):Bool
	{
		Constants.flashSprite(enemy, .1 * enemy.data.hits);

		enemy.data.hits--;
		if (enemy.data.hits > 0)
			return false;

		return true;
	}
}
