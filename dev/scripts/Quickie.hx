package dev.scripts;

import haxe.Json;
import sys.io.File;

/**
	haxe --interp -m dev.scripts.Quickie

**/
class Quickie
{
	static function main()
	{
		trace('d' + Json.stringify(DEFAULT));
		trace('g' + Json.stringify(GEHENNA));
		trace('l' + Json.stringify(LUES));
		trace('s' + Json.stringify(SHADOWS));
	}

	public static var DEFAULT(get, never):Dynamic;

	static function get_DEFAULT()
	{
		var c:Dynamic = getFile('default');

		// c.methods.hitEnemy = (enemy, bullet) -> return true;
		// c.methods.spawnEnemy = (enemy, player) -> {};

		return c;
	}

	public static var GEHENNA:Dynamic = makeConfig(DEFAULT, 'gehenna', [
		'enemyScores' => ['easy' => 25, 'normal' => 54, 'hard' => 70],
		'enemySpeedDividers' => ['easy' => 5, 'normal' => 4, 'hard' => 2.5],
		'enemySkins' => ['easy' => 'easy-gehenna', 'normal' => 'normal-gehenna', 'hard' => 'hard-gehenna'],
		'visuals' => ['enemySkinScale' => 1, 'background' => 'gehenna'],
		'tweaks' => ['id' => 'gehenna',]
	]);

	public static var LUES:Dynamic = makeConfig(DEFAULT, 'lues', [
		'enemyScores' => ['easy' => 34, 'normal' => 65, 'hard' => 75],
		'enemySpeedDividers' => ['easy' => 4, 'normal' => 3.5, 'hard' => 4],
		'enemySkins' => ['easy' => 'easy-lues', 'normal' => 'normal-lues', 'hard' => 'hard-lues'],
		'enemyChances' => ['easy' => 25, 'hard' => 2.5],
		'visuals' => ['enemySkinScale' => 1, 'background' => 'lues', 'player' => 'four_bullets'],
		'tweaks' => ['bullets' => 4, 'id' => 'lues',]
	]);

	public static var SHADOWS:Dynamic = makeConfig(DEFAULT, 'shadows', [
		'enemyScores' => ['easy' => 45, 'normal' => 75, 'hard' => 90],
		'enemySpeedDividers' => ['easy' => 8, 'normal' => 5, 'hard' => 3],
		'enemySkins' => ['easy' => 'easy-shadows', 'normal' => 'normal-shadows', 'hard' => 'hard-shadows'],
		'enemyChances' => ['easy' => 36, 'hard' => 3],
		'visuals' => ['background' => 'shadows', 'player' => 'four_bullets'],
		'tweaks' => ['bullets' => 4, 'id' => 'shadows',]
	]);

	public static function getFile(s:String):Dynamic
	{
		try
		{
			return Json.parse(File.getContent('assets/play/dreamland/configs/$s.json'));
		}
		catch (e)
		{
			trace(e);
		}

		return null;
	}

	public static function makeConfig(DEFAULT:Dynamic, name:String, changes:Map<String, Map<String, Dynamic>>):Dynamic
	{
		var config:Dynamic = DEFAULT;

		trace('Making config: $name');

		for (field => fieldChanges in changes)
		{
			trace(' | field: $field');

			for (subField => subFieldChange in fieldChanges)
			{
				var ididit = true;

				try
				{
					Reflect.setField(Reflect.field(config, field), subField, subFieldChange);
				}
				catch (e)
				{
					trace(' | | Error changing subfield($subField) : $e');

					ididit = false;
				}

				// if (ididit)
				// trace(' | * Changed subfield($subField) : $subFieldChange');
			}
		}

		return config;
	}
}
