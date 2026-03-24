package dev.scripts;

import haxe.Template;
import sys.io.File;
import haxe.xml.Access;

// **Full Changelog**: https://github.com/bopel-maki-macohi/expr-6-Maki-Bundle-/compare/0.1.0...0.1.1

/**
	haxe --interp -m dev.scripts.ChangesGenerator
**/
class ChangesGenerator
{
	static var curVersion:String = null;
	static var gitVersion:String = null;

	static final httpLoc = 'https://raw.githubusercontent.com/bopel-maki-macohi/expr-6-Maki-Bundle-/refs/heads/master/Project.xml';

	static function main()
	{

		getGithubVersion();
		getCurVersion();

		final aboutTxt:String = File.getContent('assets/menus/about.txt');
		trace(aboutTxt);

		final fullChangelogLink = '**Full Changelog**: https://github.com/bopel-maki-macohi/expr-6-Maki-Bundle-/compare/$gitVersion...$curVersion';
		trace(fullChangelogLink);

		var changes:Template = new Template(File.getContent('CHANGES.md'));

		File.saveContent('CHANGES-final.md', changes.execute({
			aboutTxt: aboutTxt,
			fullChangelogLink: fullChangelogLink,
		}));
	}

	static function getGithubVersion()
	{
		var http = new haxe.Http(httpLoc);

		http.onData = function(data:String)
		{
			var root:Access = new Access(Xml.parse(data));

			for (rootElm in root.elements)
				if (rootElm.name == 'project')
					for (subElm in rootElm.elements)
						if (subElm.name == 'app')
						{
							if (gitVersion == '' || gitVersion == null)
								gitVersion = subElm.x.get('version');
						}

			trace('gitVersion : $gitVersion');
		}

		http.onError = function(error)
		{
			trace('error: $error');
		}

		http.request();
	}

	static function getCurVersion()
	{
		var root:Access = new Access(Xml.parse(File.getContent('Project.xml')));

		for (rootElm in root.elements)
			if (rootElm.name == 'project')
				for (subElm in rootElm.elements)
					if (subElm.name == 'app')
					{
						if (curVersion == '' || curVersion == null)
							curVersion = subElm.x.get('version');
					}

		trace('curVersion : $curVersion');
	}
}
