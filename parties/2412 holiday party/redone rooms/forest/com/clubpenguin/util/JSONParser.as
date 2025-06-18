//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.JSONParser
    {
        function JSONParser () {
        }
        static function stringify(arg) {
            var c;
            var i;
            var l;
            var s = "";
            var v;
            switch (typeof(arg)) {
                case "object" : 
                    if (arg) {
                        if (arg instanceof Array) {
                            i = 0;
                            while (i < arg.length) {
                                v = stringify(arg[i]);
                                if (s) {
                                    s = s + ",";
                                }
                                s = s + v;
                                i++;
                            }
                            return(("[" + s) + "]");
                        } else if (typeof(arg.toString) != "undefined") {
                            for (i in arg) {
                                v = arg[i];
                                if ((typeof(v) != "undefined") && (typeof(v) != "function")) {
                                    v = stringify(v);
                                    if (s) {
                                        s = s + ",";
                                    }
                                    s = s + ((stringify(i) + ":") + v);
                                }
                            }
                            return(("{" + s) + "}");
                        }
                    }
                    return("null");
                case "number" : 
                    return((isFinite(arg) ? (String(arg)) : "null"));
                case "string" : 
                    l = arg.length;
                    s = "\"";
                    i = 0;
                    while (i < l) {
                        c = arg.charAt(i);
                        if (c >= " ") {
                            if ((c == "\\") || (c == "\"")) {
                                s = s + "\\";
                            }
                            s = s + c;
                        } else {
                            switch (c) {
                                case "\b" : 
                                    s = s + "\\b";
                                    break;
                                case "\f" : 
                                    s = s + "\\f";
                                    break;
                                case newline : 
                                    s = s + "\\n";
                                    break;
                                case "\r" : 
                                    s = s + "\\r";
                                    break;
                                case "\t" : 
                                    s = s + "\\t";
                                    break;
                                default : 
                                    c = c.charCodeAt();
                                    s = s + (("\\u00" + Math.floor(c / 16).toString(16)) + (c % 16).toString(16));
                            }
                        }
                        i = i + 1;
                    }
                    return(s + "\"");
                case "boolean" : 
                    return(String(arg));
            }
            return("null");
        }
        static function parse(text) {
            var at = 0;
            var ch = " ";
            var _value;
            var _error = function (m) {
                throw {name:"JSONError", message:m, at:at - 1, text:(text.substr(at - 20, 40) + newline) + text};
            };
            var parsedInt = parseInt(text);
            if (!isNaN(parsedInt)) {
                _error("Cannot parse number string.");
            }
            var _next = function () {
                ch = text.charAt(at);
                at = at + 1;
                return(ch);
            };
            var _white = function () {
                while (ch) {
                    if (ch <= " ") {
                        _next();
                    } else if (ch == "/") {
                        switch (_next()) {
                            case "/" : 
                                while ((_next() && (ch != newline)) && (ch != "\r")) {
                                }
                                break;
                            case "*" : 
                                _next();
                                for(;;){
                                    if (ch) {
                                        if (ch == "*") {
                                            if (_next() == "/") {
                                                _next();
                                                break;
                                            }
                                        } else {
                                            _next();
                                        }
                                    } else {
                                        _error("Unterminated comment");
                                    }
                                };
                                break;
                            default : 
                                _error("Syntax error");
                        }
                    } else {
                        return;
                    }
                }
            };
            var _string = function () {
                var i;
                var s = "";
                var t;
                var u;
                var outer = false;
                if (ch == "\"") {
                    while (_next()) {
                        if (ch == "\"") {
                            _next();
                            return(s);
                        } else if (ch == "\\") {
                            switch (_next()) {
                                case "b" : 
                                    s = s + "\b";
                                    break;
                                case "f" : 
                                    s = s + "\f";
                                    break;
                                case "n" : 
                                    s = s + newline;
                                    break;
                                case "r" : 
                                    s = s + "\r";
                                    break;
                                case "t" : 
                                    s = s + "\t";
                                    break;
                                case "u" : 
                                    u = 0;
                                    i = 0;
                                    while (i < 4) {
                                        t = parseInt(_next(), 16);
                                        if (!isFinite(t)) {
                                            outer = true;
                                            break;
                                        }
                                        u = (u * 16) + t;
                                        i = i + 1;
                                    }
                                    if (outer) {
                                        outer = false;
                                        break;
                                    }
                                    s = s + String.fromCharCode(u);
                                    break;
                                default : 
                                    s = s + ch;
                            }
                        } else {
                            s = s + ch;
                        }
                    }
                }
                _error("Bad string");
            };
            var _array = function () {
                var a = [];
                if (ch == "[") {
                    _next();
                    _white();
                    if (ch == "]") {
                        _next();
                        return(a);
                    }
                    while (ch) {
                        a.push(_value());
                        _white();
                        if (ch == "]") {
                            _next();
                            return(a);
                        } else if (ch != ",") {
                            break;
                        }
                        _next();
                        _white();
                    }
                }
                _error("Bad array");
            };
            var _object = function () {
                var k;
                var o = {};
                if (ch == "{") {
                    _next();
                    _white();
                    if (ch == "}") {
                        _next();
                        return(o);
                    }
                    while (ch) {
                        k = _string();
                        _white();
                        if (ch != ":") {
                            break;
                        }
                        _next();
                        o[k] = _value();
                        _white();
                        if (ch == "}") {
                            _next();
                            return(o);
                        } else if (ch != ",") {
                            break;
                        }
                        _next();
                        _white();
                    }
                }
                _error("Bad object");
            };
            var _number = function () {
                var n = "";
                var v;
                if (ch == "-") {
                    n = "-";
                    _next();
                }
                while ((ch >= "0") && (ch <= "9")) {
                    n = n + ch;
                    _next();
                }
                if (ch == ".") {
                    n = n + ".";
                    while ((_next() && (ch >= "0")) && (ch <= "9")) {
                        n = n + ch;
                    }
                }
                v = 1 * n;
                if (!isFinite(v)) {
                    _error("Bad number");
                } else {
                    return(v);
                }
            };
            var _word = function () {
                switch (ch) {
                    case "t" : 
                        if (((_next() == "r") && (_next() == "u")) && (_next() == "e")) {
                            _next();
                            return(true);
                        }
                        break;
                    case "f" : 
                        if ((((_next() == "a") && (_next() == "l")) && (_next() == "s")) && (_next() == "e")) {
                            _next();
                            return(false);
                        }
                        break;
                    case "n" : 
                        if (((_next() == "u") && (_next() == "l")) && (_next() == "l")) {
                            _next();
                            return(null);
                        }
                        break;
                }
                _error("Syntax error");
            };
            _value = function () {
                _white();
                switch (ch) {
                    case "{" : 
                        return(_object());
                    case "[" : 
                        return(_array());
                    case "\"" : 
                        return(_string());
                    case "-" : 
                        return(_number());
                }
                return((((ch >= "0") && (ch <= "9")) ? (_number()) : (_word())));
            };
            return(_value());
        }
    }
