package org.osflash.signals
{
	import flash.errors.IllegalOperationError;
	import flash.utils.Dictionary;

	public class Signal implements ISignal,IDispatcher
	{
		protected var listenersNeedCloning:Boolean = false;

		protected var onceListeners:Dictionary;

		protected var _valueClasses:Array;

		protected var listeners:Array;

		public function Signal(... valueClasses)
		{
			super();
		
			listeners = [];
			onceListeners = new Dictionary();
			if (valueClasses.length == 1 && valueClasses[0] is Array)
			{
				valueClasses = valueClasses[0];
			}
			setValueClasses(valueClasses);
		}

		public function add(listener:Function):Function
		{
			registerListener(listener);
			return listener;
		}

		public function addOnce(listener:Function):Function
		{
			registerListener(listener,true);
			return listener;
		}

		public function remove(listener:Function):Function
		{
			var index:int = listeners.indexOf(listener);
			if (index == -1)
			{
				return listener;
			}
			if (listenersNeedCloning)
			{
				listeners = listeners.slice();
				listenersNeedCloning = false;
			}
			listeners.splice(index,1);
			delete onceListeners[listener];
			return listener;
		}

		protected function registerListener(listener:Function, once:Boolean = false):void
		{
			var argumentString:String = null;
			if (listener.length < _valueClasses.length)
			{
				argumentString = listener.length == 1 ? "argument":"arguments";
				throw new ArgumentError((((((("Listener has " + listener.length) + " ") + argumentString) + " but it needs at least ") + _valueClasses.length) + " to match the given value classes."));
			}
			if (! listeners.length)
			{
				listeners[0] = listener;
				if (once)
				{
					onceListeners[listener] = true;
				}
				return;
			}
			if (listeners.indexOf(listener) >= 0)
			{
				if (Boolean(onceListeners[listener]) && !once)
				{
					throw new IllegalOperationError("You cannot addOnce() then add() the same listener without removing the relationship first.");
				}
				if (! onceListeners[listener] && once)
				{
					throw new IllegalOperationError("You cannot add() then addOnce() the same listener without removing the relationship first.");
				}
				return;
			}
			if (listenersNeedCloning)
			{
				listeners = listeners.slice();
				listenersNeedCloning = false;
			}
			listeners[listeners.length] = listener;
			if (once)
			{
				onceListeners[listener] = true;
			}
		}

		protected function setValueClasses(valueClasses:Array):void
		{
			_valueClasses = valueClasses || [];
			var i:int = int(_valueClasses.length);
			while (i--)
			{
				if (!(_valueClasses[i] is Class))
				{
					throw new ArgumentError((((("Invalid valueClasses argument: item at index " + i) + " should be a Class but was:<") + _valueClasses[i]) + ">."));
				}
			}
		}

		public function get numListeners():uint
		{
			return listeners.length;
		}

		public function dispatch(... valueObjects):void
		{
			var valueObject:Object = null;
			var valueClass:Class = null;
			var listener:Function = null;
			var numValueClasses:int = int(_valueClasses.length);
			if (valueObjects.length < numValueClasses)
			{
				throw new ArgumentError((((("Incorrect number of arguments. Expected at least " + numValueClasses) + " but received ") + valueObjects.length) + "."));
			}
			for (var i:int = 0; i < numValueClasses; i++)
			{
				if (!((valueObject = valueObjects[i]) === null || valueObject is (valueClass = _valueClasses[i])))
				{
					throw new ArgumentError((((("Value object <" + valueObject) + "> is not an instance of <") + valueClass) + ">."));
				}
			}
			if (! listeners.length)
			{
				return;
			}
			listenersNeedCloning = true;
			switch (valueObjects.length)
			{
				case 0 :
					for each (listener in listeners)
					{
						if (onceListeners[listener])
						{
							remove(listener);
						}
						listener();
					}
					break;
				case 1 :
					for each (listener in listeners)
					{
						if (onceListeners[listener])
						{
							remove(listener);
						}
						listener(valueObjects[0]);
					}
					break;
				default :
					for each (listener in listeners)
					{
						if (onceListeners[listener])
						{
							remove(listener);
						}
						listener.apply(null,valueObjects);
					}
			}
			listenersNeedCloning = false;
		}

		public function get valueClasses():Array
		{
			return _valueClasses;
		}

		public function removeAll():void
		{
			var i:uint = listeners.length;
			while (i--)
			{
				remove(listeners[i] as Function);
			}
		}
	}
}