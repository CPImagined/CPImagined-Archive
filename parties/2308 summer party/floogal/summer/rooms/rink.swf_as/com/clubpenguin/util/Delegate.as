dynamic class com.clubpenguin.util.Delegate
{

    function Delegate()
    {
    }

    static function create(target, handler)
    {
        var __reg2 = function ()
        {
            var __reg2 = arguments.callee;
            var __reg3 = arguments.concat(__reg2.initArgs);
            return __reg2.handler.apply(__reg2.target, __reg3);
        }
        ;
        __reg2.target = target;
        __reg2.handler = handler;
        __reg2.initArgs = arguments.slice(2);
        return __reg2;
    }

}
