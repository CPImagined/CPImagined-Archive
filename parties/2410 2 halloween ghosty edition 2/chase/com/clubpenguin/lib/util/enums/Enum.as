package com.clubpenguin.lib.enums
{
	import flash.utils.*;

	public class Enum
	{
		private static const EMPTY_VALUE:int = -1;

		private static var _classNameToEnumCount:Dictionary = new Dictionary();

		protected var _value:int;

		public function Enum(val:int = -1)
		{
			super();
			
			var clsName:String = getQualifiedClassName(this);
			
			/*
			This block of logic allows lazy instance definitions.
			
			If no value is defined, this instance will have a value
			of 0, then the next instance will have a value of 1,
			then 2, etc. etc.
			*/
			var numVals:int = _classNameToEnumCount[clsName] == undefined ? EMPTY_VALUE : int(_classNameToEnumCount[clsName]);
			
			if (val == EMPTY_VALUE)
			{
				this._value = numVals == EMPTY_VALUE ? 0 : numVals + 1;
				_classNameToEnumCount[clsName] = this._value;
			}
			else
			{
				this._value = val;
				
				/*
				If this is the first instance, the next instance
				will have this value + 1 if it's a lazy definition.
				*/
				if (numVals == EMPTY_VALUE || val > numVals)
				{
					_classNameToEnumCount[clsName] = val;
				}
			}
		}

		public static function createList(enumClass:Class):Array
		{
			// Creates a list of all values of a given Enum class.
			
			var valList:Array = [];
			var constantsList:XMLList = describeType(enumClass).constant.(@type == getQualifiedClassName(enumClass));
			
			for each (var cnst in constantsList)
			{
				valList.push(enumClass[cnst.@name]);
			}
			return valList;
		}

		public static function getEnum(valList:Array, val:int):Enum
		{
			/*
			Get an instance with a certain value from a list
			containing multiple value instances.
			*/
			
			var i:uint = 0;
			
			while (i < valList.length)
			{
				var inst:Enum = valList[i] as Enum;
				
				if (inst.value == val)
				{
					return inst;
				}
				
				i++;
			}
			return null;
		}

		public function get value():int
		{
			return this._value;
		}
	}
}