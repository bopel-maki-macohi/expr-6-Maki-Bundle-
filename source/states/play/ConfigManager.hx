package states.play;

class ConfigManager<T>
{
	public var type:String = null;

	public var DEFAULT:T;

	public function new(?type:String, ?DEFAULT:T)
	{
		this.type = type ?? '[[UNKNOWN TYPE]]';
		this.DEFAULT = DEFAULT;
	}

	public function makeConfig(changes:Map<String, Map<String, Dynamic>>):T
	{
		var config:T = Reflect.copy(DEFAULT);

		trace('Making $type config');

		for (field => fieldChanges in changes)
		{
			if (!Reflect.fields(config).contains(field))
				continue;

			if (Reflect.fields(Reflect.field(config, field)) == null)
				continue;

			trace(' * field: $field');

			for (subField => subFieldChange in fieldChanges)
			{
				var ididit = true;

				try
				{
					Reflect.setField(Reflect.field(config, field), subField, subFieldChange);
				}
				catch (e)
				{
					trace(' * * Error changing subfield($subField) : $e');

					ididit = false;
				}

				if (ididit)
					trace(' * * Changed subfield($subField) : $subFieldChange');
			}
		}

		return config;
	}
}
