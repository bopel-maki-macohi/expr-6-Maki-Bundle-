package states.play;

import haxe.Json;

class ConfigManager<T>
{
	public var type:String = null;

	public function new(?type:String)
	{
		this.type = type ?? '[[UNKNOWN TYPE]]';
	}

	public function makeConfig(DEFAULT:T, name:String, changes:Map<String, Map<String, Dynamic>>):T
	{
		var config:T = DEFAULT;

		trace('Making $type config: $name');

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

	public function getFile(s:String):T
	{
		try
		{
			return Json.parse(AssetsUtil.getText('play/$type/configs/$s.json'));
		}
		catch (e)
		{
			trace(e);
		}

		return null;
	}
}
