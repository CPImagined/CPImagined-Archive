package mx.utils
{
	public class DelegateAS3
	{
		private static var __globalDelegate;
		
		public static function get globalDelegate():DelegateAS3
		{
			if (__globalDelegate == undefined)
			{
				__globalDelegate = new DelegateAS3();
			}
			
			return __globalDelegate;
		}
		
		public function create(func:Function, args:Array=null):Function
		{
			var callback = function()
			{
				return func.apply(arguments.callee, args);
			}
			
			return callback;
		}
	}
}