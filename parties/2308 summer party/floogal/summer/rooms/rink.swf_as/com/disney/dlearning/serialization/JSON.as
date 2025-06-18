dynamic class com.disney.dlearning.serialization.JSON
{
    var ch: String = "";
    var at: Number = 0;
    var text;

    function JSON()
    {
    }

    function stringify(arg)
    {
        var __reg4 = undefined;
        var __reg3 = undefined;
        var __reg7 = undefined;
        var __reg2 = "";
        var __reg5 = undefined;
        if ((__reg0 = typeof arg) === "object") 
        {
            if (arg) 
            {
                if (arg instanceof Array) 
                {
                    __reg3 = 0;
                    while (__reg3 < arg.length) 
                    {
                        __reg5 = this.stringify(arg[__reg3]);
                        if (__reg2) 
                        {
                            __reg2 = __reg2 + ",";
                        }
                        __reg2 = __reg2 + __reg5;
                        ++__reg3;
                    }
                    return "[" + __reg2 + "]";
                }
                else if (typeof arg.toString != "undefined") 
                {
                    for (__reg3 in arg) 
                    {
                        __reg5 = arg[__reg3];
                        if (typeof __reg5 != "undefined" && typeof __reg5 != "function") 
                        {
                            __reg5 = this.stringify(__reg5);
                            if (__reg2) 
                            {
                                __reg2 = __reg2 + ",";
                            }
                            __reg2 = __reg2 + (this.stringify(__reg3) + ":" + __reg5);
                        }
                    }
                    return "{" + __reg2 + "}";
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
            __reg7 = arg.length;
            __reg2 = "\"";
            __reg3 = 0;
            while (__reg3 < __reg7) 
            {
                __reg4 = arg.charAt(__reg3);
                if (__reg4 >= " ") 
                {
                    if (__reg4 == "\\" || __reg4 == "\"") 
                    {
                        __reg2 = __reg2 + "\\";
                    }
                    __reg2 = __reg2 + __reg4;
                }
                else if ((__reg0 = __reg4) === "") 
                {
                    __reg2 = __reg2 + "\\b";
                }
                else if (__reg0 === "") 
                {
                    __reg2 = __reg2 + "\\f";
                }
                else if (__reg0 === "\n") 
                {
                    __reg2 = __reg2 + "\\n";
                }
                else if (__reg0 === "\r") 
                {
                    __reg2 = __reg2 + "\\r";
                }
                else if (__reg0 === "\t") 
                {
                    __reg2 = __reg2 + "\\t";
                }
                else 
                {
                    __reg4 = __reg4.charCodeAt();
                    __reg2 = __reg2 + ("\\u00" + Math.floor(__reg4 / 16).toString(16) + (__reg4 % 16).toString(16));
                }
                __reg3 = __reg3 + 1;
            }
            return __reg2 + "\"";
        }
        else if (__reg0 === "boolean") 
        {
            return String(arg);
        }
        return "null";
    }

    function white()
    {
        for (;;) 
        {
            if (!this.ch) 
            {
                return;
            }
            if (this.ch <= " ") 
            {
                this.next();
            }
            else if (this.ch == "/") 
            {
                if ((__reg0 = this.next()) === "/") 
                {
                    for (;;) 
                    {
                        if (!(this.next() && this.ch != "\n" && this.ch != "\r")) 
                        {
                            break;
                        }
                    }
                }
                else if (__reg0 === "*") 
                {
                    this.next();
                    for (;;) 
                    {
                        if (this.ch) 
                        {
                            if (this.ch == "*") 
                            {
                                if (this.next() == "/") 
                                {
                                    this.next();
                                    break;
                                }
                            }
                            else 
                            {
                                this.next();
                            }
                        }
                        else 
                        {
                            this.error("Unterminated comment");
                        }
                    }
                }
                else 
                {
                    this.error("Syntax error");
                }
            }
            else 
            {
                return;
            }
        }
    }

    function error(m)
    {
    }

    function next()
    {
        this.ch = this.text.charAt(this.at);
        this.at = this.at + 1;
        return this.ch;
    }

    function str()
    {
        var __reg5 = undefined;
        var __reg2 = "";
        var __reg4 = undefined;
        var __reg3 = undefined;
        var __reg6 = false;
        if (this.ch == "\"") 
        {
            while (this.next()) 
            {
                if (this.ch == "\"") 
                {
                    this.next();
                    return __reg2;
                }
                else if (this.ch == "\\") 
                {
                    if ((__reg0 = this.next()) === "b") 
                    {
                        __reg2 = __reg2 + "";
                    }
                    else if (__reg0 === "f") 
                    {
                        __reg2 = __reg2 + "";
                    }
                    else if (__reg0 === "n") 
                    {
                        __reg2 = __reg2 + "\n";
                    }
                    else if (__reg0 === "r") 
                    {
                        __reg2 = __reg2 + "\r";
                    }
                    else if (__reg0 === "t") 
                    {
                        __reg2 = __reg2 + "\t";
                    }
                    else if (__reg0 === "u") 
                    {
                        __reg3 = 0;
                        __reg5 = 0;
                        while (__reg5 < 4) 
                        {
                            __reg4 = parseInt(this.next(), 16);
                            if (!isFinite(__reg4)) 
                            {
                                __reg6 = true;
                                break;
                            }
                            __reg3 = __reg3 * 16 + __reg4;
                            __reg5 = __reg5 + 1;
                        }
                        if (__reg6) 
                        {
                            __reg6 = false;
                        }
                        else 
                        {
                            __reg2 = __reg2 + String.fromCharCode(__reg3);
                        }
                    }
                    else 
                    {
                        __reg2 = __reg2 + this.ch;
                    }
                }
                else 
                {
                    __reg2 = __reg2 + this.ch;
                }
            }
        }
        this.error("Bad string");
    }

    function arr()
    {
        var __reg2 = [];
        if (this.ch == "[") 
        {
            this.next();
            this.white();
            if (this.ch == "]") 
            {
                this.next();
                return __reg2;
            }
            while (this.ch) 
            {
                __reg2.push(this.value());
                this.white();
                if (this.ch == "]") 
                {
                    this.next();
                    return __reg2;
                }
                else if (this.ch != ",") 
                {
                    break;
                }
                this.next();
                this.white();
            }
        }
        this.error("Bad array");
    }

    function obj()
    {
        var __reg3 = undefined;
        var __reg2 = {};
        if (this.ch == "{") 
        {
            this.next();
            this.white();
            if (this.ch == "}") 
            {
                this.next();
                return __reg2;
            }
            while (this.ch) 
            {
                __reg3 = this.str();
                this.white();
                if (this.ch != ":") 
                {
                    break;
                }
                this.next();
                __reg2[__reg3] = this.value();
                this.white();
                if (this.ch == "}") 
                {
                    this.next();
                    return __reg2;
                }
                else if (this.ch != ",") 
                {
                    break;
                }
                this.next();
                this.white();
            }
        }
        this.error("Bad object");
    }

    function num()
    {
        var __reg2 = "";
        var __reg3 = undefined;
        if (this.ch == "-") 
        {
            __reg2 = "-";
            this.next();
        }
        while (this.ch >= "0" && this.ch <= "9") 
        {
            __reg2 = __reg2 + this.ch;
            this.next();
        }
        if (this.ch == ".") 
        {
            __reg2 = __reg2 + ".";
            this.next();
            while (this.ch >= "0" && this.ch <= "9") 
            {
                __reg2 = __reg2 + this.ch;
                this.next();
            }
        }
        if (this.ch == "e" || this.ch == "E") 
        {
            __reg2 = __reg2 + this.ch;
            this.next();
            if (this.ch == "-" || this.ch == "+") 
            {
                __reg2 = __reg2 + this.ch;
                this.next();
            }
            while (this.ch >= "0" && this.ch <= "9") 
            {
                __reg2 = __reg2 + this.ch;
                this.next();
            }
        }
        __reg3 = Number(__reg2);
        if (!isFinite(__reg3)) 
        {
            this.error("Bad number");
        }
        return __reg3;
    }

    function word()
    {
        if ((__reg0 = this.ch) === "t") 
        {
            if (this.next() == "r" && this.next() == "u" && this.next() == "e") 
            {
                this.next();
                return true;
            }
        }
        else if (__reg0 === "f") 
        {
            if (this.next() == "a" && this.next() == "l" && this.next() == "s" && this.next() == "e") 
            {
                this.next();
                return false;
            }
        }
        else if (__reg0 === "n") 
        {
            if (this.next() == "u" && this.next() == "l" && this.next() == "l") 
            {
                this.next();
                return null;
            }
        }
        this.error("Syntax error");
    }

    function value()
    {
        this.white();
        if ((__reg0 = this.ch) === "{") 
        {
            return this.obj();
        }
        else if (__reg0 === "[") 
        {
            return this.arr();
        }
        else if (__reg0 === "\"") 
        {
            return this.str();
        }
        else if (__reg0 === "-") 
        {
            return this.num();
        }
        return this.ch >= "0" && this.ch <= "9" ? this.num() : this.word();
    }

    function parse(_text)
    {
        this.text = _text;
        this.at = 0;
        this.ch = " ";
        return this.value();
    }

}
