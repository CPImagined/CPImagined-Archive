package com.clubpenguin.lib.util.xml
{
	public class XMLUtil
	{
		public static function getArrayFromConfig(_contentSchema:XML, _ident:String, _default:Array):Array
		{
			var arr:Array;
			var assetList:XML;

			if (_contentSchema.child(_ident).length() != 0)
			{
				arr = new Array();
				
				var contents = _contentSchema[_ident];
				
				for each (var item in contents.children())
				{
					arr.push(item);
				}
			}
			else
			{
				arr = _default;
			}

			return arr;
		}

		public static function getStringFromConfig(_contentSchema:XML, _ident:String, _default:String):String
		{
			var str:String;

			if (_contentSchema.child(_ident).length() != 0)
			{
				str = _contentSchema[_ident];
			}
			else
			{
				str = _default;
			}

			return str;
		}

		public static function getIntFromConfig(_contentSchema:XML, _ident:String, _default:int):int
		{
			var val:int = 0;
			var identChild:XMLList = _contentSchema.child(_ident);

			if (identChild != null && identChild.length() != 0)
			{
				val = parseInt(_contentSchema[_ident]);
			}
			else
			{
				val = _default;
			}

			return val;
		}

		public static function getFloatFromConfig(_contentSchema:XML, _ident:String, _default:Number):Number
		{
			var val:Number = 0.0;
			var identChild:XMLList = _contentSchema.child(_ident);

			if (identChild != null && identChild.length() != 0)
			{
				val = parseFloat(_contentSchema[_ident]);
			}
			else
			{
				val = _default;
			}

			return val;
		}
	}
}