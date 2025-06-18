
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.disney.dlearning.serialization.JSON
    {
        var text;
        function JSON () {
        }
        function stringify(arg) {
            var _local4;
            var _local3;
            var _local7;
            var _local2 = "";
            var _local5;
            switch (typeof(arg)) {
                case "object" : 
                    if (arg) {
                        if (arg instanceof Array) {
                            _local3 = 0;
                            while (_local3 < arg.length) {
                                _local5 = stringify(arg[_local3]);
                                if (_local2) {
                                    _local2 = _local2 + ",";
                                }
                                _local2 = _local2 + _local5;
                                _local3++;
                            }
                            return(("[" + _local2) + "]");
                        } else if (typeof(arg.toString) != "undefined") {
                            for (_local3 in arg) {
                                _local5 = arg[_local3];
                                if ((typeof(_local5) != "undefined") && (typeof(_local5) != "function")) {
                                    _local5 = stringify(_local5);
                                    if (_local2) {
                                        _local2 = _local2 + ",";
                                    }
                                    _local2 = _local2 + ((stringify(_local3) + ":") + _local5);
                                }
                            }
                            return(("{" + _local2) + "}");
                        }
                    }
                    return("null");
                case "number" : 
                    return((isFinite(arg) ? (String(arg)) : "null"));
                case "string" : 
                    _local7 = arg.length;
                    _local2 = "\"";
                    _local3 = 0;
                    while (_local3 < _local7) {
                        _local4 = arg.charAt(_local3);
                        if (_local4 >= " ") {
                            if ((_local4 == "\\") || (_local4 == "\"")) {
                                _local2 = _local2 + "\\";
                            }
                            _local2 = _local2 + _local4;
                        } else {
                            switch (_local4) {
                                case "\b" : 
                                    _local2 = _local2 + "\\b";
                                    break;
                                case "\f" : 
                                    _local2 = _local2 + "\\f";
                                    break;
                                case newline : 
                                    _local2 = _local2 + "\\n";
                                    break;
                                case "\r" : 
                                    _local2 = _local2 + "\\r";
                                    break;
                                case "\t" : 
                                    _local2 = _local2 + "\\t";
                                    break;
                                default : 
                                    _local4 = _local4.charCodeAt();
                                    _local2 = _local2 + (("\\u00" + Math.floor(_local4 / 16).toString(16)) + (_local4 % 16).toString(16));
                            }
                        }
                        _local3 = _local3 + 1;
                    }
                    return(_local2 + "\"");
                case "boolean" : 
                    return(String(arg));
            }
            return("null");
        }
        function white() {
            while (ch) {
                if (ch <= " ") {
                    next();
                } else if (ch == "/") {
                    switch (next()) {
                        case "/" : 
                            while ((next() && (ch != newline)) && (ch != "\r")) {
                            }
                            break;
                        case "*" : 
                            next();
                            for(;;){
                                if (ch) {
                                    if (ch == "*") {
                                        if (next() == "/") {
                                            next();
                                            // unexpected jump
                                        }
                                    } else {
                                        next();
                                    }
                                } else {
                                    error("Unterminated comment");
                                }
                            };
                            break;
                        default : 
                            error("Syntax error");
                    }
                } else {
                    break;
                }
            }
        }
        function error(m) {
            throw {name:"JSONError", message:m, at:at - 1, text:text};
        }
        function next() {
            ch = text.charAt(at);
            at = at + 1;
            return(ch);
        }
        function str() {
            var _local5;
            var _local2 = "";
            var _local4;
            var _local3;
            var _local6 = false;
            if (ch == "\"") {
                while (next()) {
                    if (ch == "\"") {
                        next();
                        return(_local2);
                    } else if (ch == "\\") {
                        switch (next()) {
                            case "b" : 
                                _local2 = _local2 + "\b";
                                break;
                            case "f" : 
                                _local2 = _local2 + "\f";
                                break;
                            case "n" : 
                                _local2 = _local2 + newline;
                                break;
                            case "r" : 
                                _local2 = _local2 + "\r";
                                break;
                            case "t" : 
                                _local2 = _local2 + "\t";
                                break;
                            case "u" : 
                                _local3 = 0;
                                _local5 = 0;
                                while (_local5 < 4) {
                                    _local4 = parseInt(next(), 16);
                                    if (!isFinite(_local4)) {
                                        _local6 = true;
                                        break;
                                    }
                                    _local3 = (_local3 * 16) + _local4;
                                    _local5 = _local5 + 1;
                                }
                                if (_local6) {
                                    _local6 = false;
                                    break;
                                }
                                _local2 = _local2 + String.fromCharCode(_local3);
                                break;
                            default : 
                                _local2 = _local2 + ch;
                        }
                    } else {
                        _local2 = _local2 + ch;
                    }
                }
            }
            error("Bad string");
        }
        function arr() {
            var _local2 = [];
            if (ch == "[") {
                next();
                white();
                if (ch == "]") {
                    next();
                    return(_local2);
                }
                while (ch) {
                    _local2.push(value());
                    white();
                    if (ch == "]") {
                        next();
                        return(_local2);
                    } else if (ch != ",") {
                        break;
                    }
                    next();
                    white();
                }
            }
            error("Bad array");
        }
        function obj() {
            var _local3;
            var _local2 = {};
            if (ch == "{") {
                next();
                white();
                if (ch == "}") {
                    next();
                    return(_local2);
                }
                while (ch) {
                    _local3 = str();
                    white();
                    if (ch != ":") {
                        break;
                    }
                    next();
                    _local2[_local3] = value();
                    white();
                    if (ch == "}") {
                        next();
                        return(_local2);
                    } else if (ch != ",") {
                        break;
                    }
                    next();
                    white();
                }
            }
            error("Bad object");
        }
        function num() {
            var _local2 = "";
            var _local3;
            if (ch == "-") {
                _local2 = "-";
                next();
            }
            while ((ch >= "0") && (ch <= "9")) {
                _local2 = _local2 + ch;
                next();
            }
            if (ch == ".") {
                _local2 = _local2 + ".";
                next();
                while ((ch >= "0") && (ch <= "9")) {
                    _local2 = _local2 + ch;
                    next();
                }
            }
            if ((ch == "e") || (ch == "E")) {
                _local2 = _local2 + ch;
                next();
                if ((ch == "-") || (ch == "+")) {
                    _local2 = _local2 + ch;
                    next();
                }
                while ((ch >= "0") && (ch <= "9")) {
                    _local2 = _local2 + ch;
                    next();
                }
            }
            _local3 = Number(_local2);
            if (!isFinite(_local3)) {
                error("Bad number");
            }
            return(_local3);
        }
        function word() {
            switch (ch) {
                case "t" : 
                    if (((next() == "r") && (next() == "u")) && (next() == "e")) {
                        next();
                        return(true);
                    }
                    break;
                case "f" : 
                    if ((((next() == "a") && (next() == "l")) && (next() == "s")) && (next() == "e")) {
                        next();
                        return(false);
                    }
                    break;
                case "n" : 
                    if (((next() == "u") && (next() == "l")) && (next() == "l")) {
                        next();
                        return(null);
                    }
                    break;
            }
            error("Syntax error");
        }
        function value() {
            white();
            switch (ch) {
                case "{" : 
                    return(obj());
                case "[" : 
                    return(arr());
                case "\"" : 
                    return(str());
                case "-" : 
                    return(num());
            }
            return((((ch >= "0") && (ch <= "9")) ? (num()) : (word())));
        }
        function parse(_text) {
            text = _text;
            at = 0;
            ch = " ";
            return(value());
        }
        var ch = "";
        var at = 0;
    }
