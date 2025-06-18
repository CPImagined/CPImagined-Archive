class com.clubpenguin.util.Delegate
{
	function Delegate()
	{
	}
	static function create(target, handler)
	{
		var callback = function()
		{
			var callee = arguments.callee;
			var calleeArgs = arguments.concat(callee.initArgs);
			return callee.handler.apply(callee.target, calleeArgs);
		};
		callback.target = target;
		callback.handler = handler;
		callback.initArgs = arguments.slice(2);
		return callback;
	}
}