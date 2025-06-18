//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.JSONParser
    {
        function JSONParser () {
        }
        static function stringify(arg) {
            var _local_3;
            var _local_2;
            var _local_6;
            var _local_1 = "";
            var _local_4;
            switch (typeof(arg)) {
                case "object" : 
                    if (arg) {
                        if (arg instanceof Array) {
                            _local_2 = 0;
                            while (_local_2 < arg.length) {
                                _local_4 = stringify(arg[_local_2]);
                                if (_local_1) {
                                    _local_1 = _local_1 + ",";
                                }
                                _local_1 = _local_1 + _local_4;
                                _local_2++;
                            }
                            return(("[" + _local_1) + "]");
                        } else if (typeof(arg.toString) != "undefined") {
                            for (_local_2 in arg) {
                                _local_4 = arg[_local_2];
                                if ((typeof(_local_4) != "undefined") && (typeof(_local_4) != "function")) {
                                    _local_4 = stringify(_local_4);
                                    if (_local_1) {
                                        _local_1 = _local_1 + ",";
                                    }
                                    _local_1 = _local_1 + ((stringify(_local_2) + ":") + _local_4);
                                }
                            }
                            return(("{" + _local_1) + "}");
                        }
                    }
                    return("null");
                case "number" : 
                    return((isFinite(arg) ? (String(arg)) : "null"));
                case "string" : 
                    _local_6 = arg.length;
                    _local_1 = "\"";
                    _local_2 = 0;
                    while (_local_2 < _local_6) {
                        _local_3 = arg.charAt(_local_2);
                        if (_local_3 >= " ") {
                            if ((_local_3 == "\\") || (_local_3 == "\"")) {
                                _local_1 = _local_1 + "\\";
                            }
                            _local_1 = _local_1 + _local_3;
                        } else {
                            switch (_local_3) {
                                case "\b" : 
                                    _local_1 = _local_1 + "\\b";
                                    break;
                                case "\f" : 
                                    _local_1 = _local_1 + "\\f";
                                    break;
                                case newline : 
                                    _local_1 = _local_1 + "\\n";
                                    break;
                                case "\r" : 
                                    _local_1 = _local_1 + "\\r";
                                    break;
                                case "\t" : 
                                    _local_1 = _local_1 + "\\t";
                                    break;
                                default : 
                                    _local_3 = _local_3.charCodeAt();
                                    _local_1 = _local_1 + (("\\u00" + Math.floor(_local_3 / 16).toString(16)) + (_local_3 % 16).toString(16));
                            }
                        }
                        _local_2 = _local_2 + 1;
                    }
                    return(_local_1 + "\"");
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
                trace("JSONParser error about to throw.");
                throw {name:"JSONError", message:m, at:at - 1, text:(text.substr(at - 20, 40) + newline) + text};
            };
            var _local_11 = parseInt(text);
            if (!isNaN(_local_11)) {
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
                var _local_4;
                var _local_1 = "";
                var _local_3;
                var _local_2;
                var _local_5 = false;
                if (ch == "\"") {
                    while (_next()) {
                        if (ch == "\"") {
                            _next();
                            return(_local_1);
                        } else if (ch == "\\") {
                            switch (_next()) {
                                case "b" : 
                                    _local_1 = _local_1 + "\b";
                                    break;
                                case "f" : 
                                    _local_1 = _local_1 + "\f";
                                    break;
                                case "n" : 
                                    _local_1 = _local_1 + newline;
                                    break;
                                case "r" : 
                                    _local_1 = _local_1 + "\r";
                                    break;
                                case "t" : 
                                    _local_1 = _local_1 + "\t";
                                    break;
                                case "u" : 
                                    _local_2 = 0;
                                    _local_4 = 0;
                                    while (_local_4 < 4) {
                                        _local_3 = parseInt(_next(), 16);
                                        if (!isFinite(_local_3)) {
                                            _local_5 = true;
                                            break;
                                        }
                                        _local_2 = (_local_2 * 16) + _local_3;
                                        _local_4 = _local_4 + 1;
                                    }
                                    if (_local_5) {
                                        _local_5 = false;
                                        break;
                                    }
                                    _local_1 = _local_1 + String.fromCharCode(_local_2);
                                    break;
                                default : 
                                    _local_1 = _local_1 + ch;
                            }
                        } else {
                            _local_1 = _local_1 + ch;
                        }
                    }
                }
                _error("Bad string");
            };
            var _array = function () {
                var _local_1 = [];
                if (ch == "[") {
                    _next();
                    _white();
                    if (ch == "]") {
                        _next();
                        return(_local_1);
                    }
                    while (ch) {
                        _local_1.push(_value());
                        _white();
                        if (ch == "]") {
                            _next();
                            return(_local_1);
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
                var _local_2;
                var _local_1 = {};
                if (ch == "{") {
                    _next();
                    _white();
                    if (ch == "}") {
                        _next();
                        return(_local_1);
                    }
                    while (ch) {
                        _local_2 = _string();
                        _white();
                        if (ch != ":") {
                            break;
                        }
                        _next();
                        _local_1[_local_2] = _value();
                        _white();
                        if (ch == "}") {
                            _next();
                            return(_local_1);
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
                var _local_1 = "";
                var _local_2;
                if (ch == "-") {
                    _local_1 = "-";
                    _next();
                }
                while ((ch >= "0") && (ch <= "9")) {
                    _local_1 = _local_1 + ch;
                    _next();
                }
                if (ch == ".") {
                    _local_1 = _local_1 + ".";
                    while ((_next() && (ch >= "0")) && (ch <= "9")) {
                        _local_1 = _local_1 + ch;
                    }
                }
                _local_2 = 1 * _local_1;
                if (!isFinite(_local_2)) {
                    _error("Bad number");
                } else {
                    return(_local_2);
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
