//Created by Action Script Viewer - https://www.buraks.com/asv
    class cinqetdemi.JSON
    {
        static var inst;
        var text;
        function JSON () {
        }
        static function getInstance() {
            if (inst == null) {
                inst = new cinqetdemi.JSON();
            }
            return(inst);
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
            if (!text.length) {
                throw new Error("JSONError: Text missing");
            }
            var _local_1 = getInstance();
            _local_1.at = 0;
            _local_1.ch = " ";
            _local_1.text = text;
            return(_local_1.value());
        }
        function error(m) {
            var _local_2 = ((("JSONError: " + m) + " at ") + (at - 1)) + newline;
            _local_2 = _local_2 + (text.substr(at - 10, 20) + newline);
            _local_2 = _local_2 + "        ^";
            throw new Error(_local_2);
        }
        function next() {
            ch = text.charAt(at);
            at = at + 1;
            return(ch);
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
                            while (true) {
                                if (ch) {
                                    if (ch == "*") {
                                        if (next() == "/") {
                                            next();
                                            break;
                                        }
                                    } else {
                                        next();
                                    }
                                } else {
                                    error("Unterminated comment");
                                }
                            }
                            break;
                        default : 
                            error("Syntax error");
                    }
                } else {
                    break;
                }
            }
        }
        function str() {
            var _local_5;
            var _local_2 = "";
            var _local_4;
            var _local_3;
            var _local_6 = false;
            if ((ch == "\"") || (ch == "'")) {
                var _local_7 = ch;
                while (next()) {
                    if (ch == _local_7) {
                        next();
                        return(_local_2);
                    } else if (ch == "\\") {
                        switch (next()) {
                            case "b" : 
                                _local_2 = _local_2 + "\b";
                                break;
                            case "f" : 
                                _local_2 = _local_2 + "\f";
                                break;
                            case "n" : 
                                _local_2 = _local_2 + newline;
                                break;
                            case "r" : 
                                _local_2 = _local_2 + "\r";
                                break;
                            case "t" : 
                                _local_2 = _local_2 + "\t";
                                break;
                            case "u" : 
                                _local_3 = 0;
                                _local_5 = 0;
                                while (_local_5 < 4) {
                                    _local_4 = parseInt(next(), 16);
                                    if (!isFinite(_local_4)) {
                                        _local_6 = true;
                                        break;
                                    }
                                    _local_3 = (_local_3 * 16) + _local_4;
                                    _local_5 = _local_5 + 1;
                                }
                                if (_local_6) {
                                    _local_6 = false;
                                    break;
                                }
                                _local_2 = _local_2 + String.fromCharCode(_local_3);
                                break;
                            default : 
                                _local_2 = _local_2 + ch;
                        }
                    } else {
                        _local_2 = _local_2 + ch;
                    }
                }
            }
            error("Bad string");
        }
        function key() {
            var _local_2 = ch;
            var _local_6 = false;
            var _local_3 = text.indexOf(":", at);
            var _local_4 = text.indexOf("\"", at);
            var _local_5 = text.indexOf("'", at);
            if (((_local_4 <= _local_3) && (_local_4 > -1)) || ((_local_5 <= _local_3) && (_local_5 > -1))) {
                _local_2 = str();
                white();
                if (ch == ":") {
                    return(_local_2);
                } else {
                    error("Bad key");
                }
            }
            while (next()) {
                if (ch == ":") {
                    return(_local_2);
                }
                if (ch <= " ") {
                } else {
                    _local_2 = _local_2 + ch;
                }
            }
            error("Bad key");
        }
        function arr() {
            var _local_2 = [];
            if (ch == "[") {
                next();
                white();
                if (ch == "]") {
                    next();
                    return(_local_2);
                }
                while (ch) {
                    if (ch == "]") {
                        next();
                        return(_local_2);
                    }
                    _local_2.push(value());
                    white();
                    if (ch == "]") {
                        next();
                        return(_local_2);
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
            var _local_3;
            var _local_2 = {};
            if (ch == "{") {
                next();
                white();
                if (ch == "}") {
                    next();
                    return(_local_2);
                }
                while (ch) {
                    if (ch == "}") {
                        next();
                        return(_local_2);
                    }
                    _local_3 = this.key();
                    if (ch != ":") {
                        break;
                    }
                    next();
                    _local_2[_local_3] = value();
                    white();
                    if (ch == "}") {
                        next();
                        return(_local_2);
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
            var _local_2 = "";
            var _local_3;
            if (ch == "-") {
                _local_2 = "-";
                next();
            }
            while (((((ch >= "0") && (ch <= "9")) || (ch == "x")) || ((ch >= "a") && (ch <= "f"))) || ((ch >= "A") && (ch <= "F"))) {
                _local_2 = _local_2 + ch;
                next();
            }
            if (ch == ".") {
                _local_2 = _local_2 + ".";
                next();
                while ((ch >= "0") && (ch <= "9")) {
                    _local_2 = _local_2 + ch;
                    next();
                }
            }
            if ((ch == "e") || (ch == "E")) {
                _local_2 = _local_2 + ch;
                next();
                if ((ch == "-") || (ch == "+")) {
                    _local_2 = _local_2 + ch;
                    next();
                }
                while ((ch >= "0") && (ch <= "9")) {
                    _local_2 = _local_2 + ch;
                    next();
                }
            }
            _local_3 = Number(_local_2);
            if (!isFinite(_local_3)) {
                error("Bad number");
            }
            return(_local_3);
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
                case "'" : 
                    return(str());
                case "-" : 
                    return(num());
            }
            return((((ch >= "0") && (ch <= "9")) ? (num()) : (word())));
        }
        var at = 0;
        var ch = " ";
    }
