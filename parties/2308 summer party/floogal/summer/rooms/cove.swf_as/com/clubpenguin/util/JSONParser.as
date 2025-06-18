dynamic class com.clubpenguin.util.JSONParser
{

    function JSONParser()
    {
    }

    static function stringify(arg)
    {
        var __reg3 = undefined;
        var __reg2 = undefined;
        var __reg6 = undefined;
        var __reg1 = "";
        var __reg4 = undefined;
        if ((__reg0 = typeof arg) === "object") 
        {
            if (arg) 
            {
                if (arg instanceof Array) 
                {
                    __reg2 = 0;
                    while (__reg2 < arg.length) 
                    {
                        __reg4 = com.clubpenguin.util.JSONParser.stringify(arg[__reg2]);
                        if (__reg1) 
                        {
                            __reg1 = __reg1 + ",";
                        }
                        __reg1 = __reg1 + __reg4;
                        ++__reg2;
                    }
                    return "[" + __reg1 + "]";
                }
                else if (typeof arg.toString != "undefined") 
                {
                    for (__reg2 in arg) 
                    {
                        __reg4 = arg[__reg2];
                        if (typeof __reg4 != "undefined" && typeof __reg4 != "function") 
                        {
                            __reg4 = com.clubpenguin.util.JSONParser.stringify(__reg4);
                            if (__reg1) 
                            {
                                __reg1 = __reg1 + ",";
                            }
                            __reg1 = __reg1 + (com.clubpenguin.util.JSONParser.stringify(__reg2) + ":" + __reg4);
                        }
                    }
                    return "{" + __reg1 + "}";
                }
            }
            return "null";
        }
        else if (__reg0 === "number") 
        {
            return isFinite(arg) ? String(arg) : "null";
        }
        else if (__reg0 === "string") 
        {
            __reg6 = arg.length;
            __reg1 = "\"";
            __reg2 = 0;
            while (__reg2 < __reg6) 
            {
                __reg3 = arg.charAt(__reg2);
                if (__reg3 >= " ") 
                {
                    if (__reg3 == "\\" || __reg3 == "\"") 
                    {
                        __reg1 = __reg1 + "\\";
                    }
                    __reg1 = __reg1 + __reg3;
                }
                else if ((__reg0 = __reg3) === "") 
                {
                    __reg1 = __reg1 + "\\b";
                }
                else if (__reg0 === "") 
                {
                    __reg1 = __reg1 + "\\f";
                }
                else if (__reg0 === "\n") 
                {
                    __reg1 = __reg1 + "\\n";
                }
                else if (__reg0 === "\r") 
                {
                    __reg1 = __reg1 + "\\r";
                }
                else if (__reg0 === "\t") 
                {
                    __reg1 = __reg1 + "\\t";
                }
                else 
                {
                    __reg3 = __reg3.charCodeAt();
                    __reg1 = __reg1 + ("\\u00" + Math.floor(__reg3 / 16).toString(16) + (__reg3 % 16).toString(16));
                }
                __reg2 = __reg2 + 1;
            }
            return __reg1 + "\"";
        }
        else if (__reg0 === "boolean") 
        {
            return String(arg);
        }
        return "null";
    }

    static function parse(text)
    {
        var at = 0;
        var ch = " ";
        var _value;
        var _error = function (m)
        {
        }
        ;
        var __reg11 = parseInt(text);
        if (!isNaN(__reg11)) 
        {
            _error("Cannot parse number string.");
        }
        var _next = function ()
        {
            ch = text.charAt(at);
            at = at + 1;
            return ch;
        }
        ;
        var _white = function ()
        {
            for (;;) 
            {
                if (!ch) 
                {
                    return;
                }
                if (ch <= " ") 
                {
                    _next();
                }
                else if (ch == "/") 
                {
                    if ((__reg0 = _next()) === "/") 
                    {
                        for (;;) 
                        {
                            if (!(_next() && ch != "\n" && ch != "\r")) 
                            {
                                break;
                            }
                        }
                    }
                    else if (__reg0 === "*") 
                    {
                        _next();
                        for (;;) 
                        {
                            if (ch) 
                            {
                                if (ch == "*") 
                                {
                                    if (_next() == "/") 
                                    {
                                        _next();
                                        break;
                                    }
                                }
                                else 
                                {
                                    _next();
                                }
                            }
                            else 
                            {
                                _error("Unterminated comment");
                            }
                        }
                    }
                    else 
                    {
                        _error("Syntax error");
                    }
                }
                else 
                {
                    return;
                }
            }
        }
        ;
        var _string = function ()
        {
            var __reg4 = undefined;
            var __reg1 = "";
            var __reg3 = undefined;
            var __reg2 = undefined;
            var __reg5 = false;
            if (ch == "\"") 
            {
                while (_next()) 
                {
                    if (ch == "\"") 
                    {
                        _next();
                        return __reg1;
                    }
                    else if (ch == "\\") 
                    {
                        if ((__reg0 = _next()) === "b") 
                        {
                            __reg1 = __reg1 + "";
                        }
                        else if (__reg0 === "f") 
                        {
                            __reg1 = __reg1 + "";
                        }
                        else if (__reg0 === "n") 
                        {
                            __reg1 = __reg1 + "\n";
                        }
                        else if (__reg0 === "r") 
                        {
                            __reg1 = __reg1 + "\r";
                        }
                        else if (__reg0 === "t") 
                        {
                            __reg1 = __reg1 + "\t";
                        }
                        else if (__reg0 === "u") 
                        {
                            __reg2 = 0;
                            __reg4 = 0;
                            while (__reg4 < 4) 
                            {
                                __reg3 = parseInt(_next(), 16);
                                if (!isFinite(__reg3)) 
                                {
                                    __reg5 = true;
                                    break;
                                }
                                __reg2 = __reg2 * 16 + __reg3;
                                __reg4 = __reg4 + 1;
                            }
                            if (__reg5) 
                            {
                                __reg5 = false;
                            }
                            else 
                            {
                                __reg1 = __reg1 + String.fromCharCode(__reg2);
                            }
                        }
                        else 
                        {
                            __reg1 = __reg1 + ch;
                        }
                    }
                    else 
                    {
                        __reg1 = __reg1 + ch;
                    }
                }
            }
            _error("Bad string");
        }
        ;
        var _array = function ()
        {
            var __reg1 = [];
            if (ch == "[") 
            {
                _next();
                _white();
                if (ch == "]") 
                {
                    _next();
                    return __reg1;
                }
                while (ch) 
                {
                    __reg1.push(_value());
                    _white();
                    if (ch == "]") 
                    {
                        _next();
                        return __reg1;
                    }
                    else if (ch != ",") 
                    {
                        break;
                    }
                    _next();
                    _white();
                }
            }
            _error("Bad array");
        }
        ;
        var _object = function ()
        {
            var __reg2 = undefined;
            var __reg1 = {};
            if (ch == "{") 
            {
                _next();
                _white();
                if (ch == "}") 
                {
                    _next();
                    return __reg1;
                }
                while (ch) 
                {
                    __reg2 = _string();
                    _white();
                    if (ch != ":") 
                    {
                        break;
                    }
                    _next();
                    __reg1[__reg2] = _value();
                    _white();
                    if (ch == "}") 
                    {
                        _next();
                        return __reg1;
                    }
                    else if (ch != ",") 
                    {
                        break;
                    }
                    _next();
                    _white();
                }
            }
            _error("Bad object");
        }
        ;
        var _number = function ()
        {
            var __reg1 = "";
            var __reg2 = undefined;
            if (ch == "-") 
            {
                __reg1 = "-";
                _next();
            }
            while (ch >= "0" && ch <= "9") 
            {
                __reg1 = __reg1 + ch;
                _next();
            }
            if (ch == ".") 
            {
                __reg1 = __reg1 + ".";
                while (_next() && ch >= "0" && ch <= "9") 
                {
                    __reg1 = __reg1 + ch;
                }
            }
            __reg2 = 1 * __reg1;
            if (!isFinite(__reg2)) 
            {
                _error("Bad number");
                return;
            }
            return __reg2;
        }
        ;
        var _word = function ()
        {
            if ((__reg0 = ch) === "t") 
            {
                if (_next() == "r" && _next() == "u" && _next() == "e") 
                {
                    _next();
                    return true;
                }
            }
            else if (__reg0 === "f") 
            {
                if (_next() == "a" && _next() == "l" && _next() == "s" && _next() == "e") 
                {
                    _next();
                    return false;
                }
            }
            else if (__reg0 === "n") 
            {
                if (_next() == "u" && _next() == "l" && _next() == "l") 
                {
                    _next();
                    return null;
                }
            }
            _error("Syntax error");
        }
        ;
        _value = function ()
        {
            _white();
            if ((__reg0 = ch) === "{") 
            {
                return _object();
            }
            else if (__reg0 === "[") 
            {
                return _array();
            }
            else if (__reg0 === "\"") 
            {
                return _string();
            }
            else if (__reg0 === "-") 
            {
                return _number();
            }
            return ch >= "0" && ch <= "9" ? _number() : _word();
        }
        ;
        return _value();
    }

}
