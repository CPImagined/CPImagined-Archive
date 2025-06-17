//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.disney.dlearning.serialization.JSON
    {
        var text;
        function JSON () {
        }
        function stringify(_arg_6) {
            var _local_4;
            var _local_3;
            var _local_7;
            var _local_2 = "";
            var _local_5;
            switch (typeof(_arg_6)) {
                case "object" : 
                    if (_arg_6) {
                        if (_arg_6 instanceof Array) {
                            _local_3 = 0;
                            while (_local_3 < _arg_6.length) {
                                _local_5 = stringify(_arg_6[_local_3]);
                                if (_local_2) {
                                    _local_2 = _local_2 + ",";
                                }
                                _local_2 = _local_2 + _local_5;
                                _local_3++;
                            }
                            return(("[" + _local_2) + "]");
                        }
                        if (typeof(_arg_6.toString) != "undefined") {
                            for (_local_3 in _arg_6) {
                                _local_5 = _arg_6[_local_3];
                                if ((typeof(_local_5) != "undefined") && (typeof(_local_5) != "function")) {
                                    _local_5 = stringify(_local_5);
                                    if (_local_2) {
                                        _local_2 = _local_2 + ",";
                                    }
                                    _local_2 = _local_2 + ((stringify(_local_3) + ":") + _local_5);
                                }
                            }
                            return(("{" + _local_2) + "}");
                        }
                    }
                    return("null");
                case "number" : 
                    return((isFinite(_arg_6) ? (String(_arg_6)) : "null"));
                case "string" : 
                    _local_7 = _arg_6.length;
                    _local_2 = "\"";
                    _local_3 = 0;
                    while (_local_3 < _local_7) {
                        _local_4 = _arg_6.charAt(_local_3);
                        if (_local_4 >= " ") {
                            if ((_local_4 == "\\") || (_local_4 == "\"")) {
                                _local_2 = _local_2 + "\\";
                            }
                            _local_2 = _local_2 + _local_4;
                        } else {
                            switch (_local_4) {
                                case "\b" : 
                                    _local_2 = _local_2 + "\\b";
                                    break;
                                case "\f" : 
                                    _local_2 = _local_2 + "\\f";
                                    break;
                                case newline : 
                                    _local_2 = _local_2 + "\\n";
                                    break;
                                case "\r" : 
                                    _local_2 = _local_2 + "\\r";
                                    break;
                                case "\t" : 
                                    _local_2 = _local_2 + "\\t";
                                    break;
                                default : 
                                    _local_4 = _local_4.charCodeAt();
                                    _local_2 = _local_2 + (("\\u00" + Math.floor(_local_4 / 16).toString(16)) + (_local_4 % 16).toString(16));
                            }
                        }
                        _local_3 = _local_3 + 1;
                    }
                    return(_local_2 + "\"");
                case "boolean" : 
                    return(String(_arg_6));
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
                                            break;
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
        function error(_arg_6) {
            throw {name:"JSONError", message:_arg_6, at:at - 1, text:text};
        }
        function next() {
            ch = text.charAt(at);
            at = at + 1;
            return(ch);
        }
        function str() {
            var _local_5;
            var _local_2 = "";
            var _local_4;
            var _local_3;
            var _local_6 = false;
            if (ch == "\"") {
                while (next()) {
                    if (ch == "\"") {
                        next();
                        return(_local_2);
                    }
                    if (ch == "\\") {
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
                    _local_2.push(value());
                    white();
                    if (ch == "]") {
                        next();
                        return(_local_2);
                    }
                    if (ch != ",") {
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
                    _local_3 = str();
                    white();
                    if (ch != ":") {
                        break;
                    }
                    next();
                    _local_2[_local_3] = value();
                    white();
                    if (ch == "}") {
                        next();
                        return(_local_2);
                    }
                    if (ch != ",") {
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
            while ((ch >= "0") && (ch <= "9")) {
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
                    if (!(((next() == "u") && (next() == "l")) && (next() == "l"))) { 
                        break;
                    }
                    next();
                    return(null);
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
        function parse(_arg_2) {
            text = _arg_2;
            at = 0;
            ch = " ";
            return(value());
        }
        var ch = "";
        var at = 0;
    }
