class com.clubpenguin.util.JSONParser
{
   function JSONParser()
   {
   }
   static function stringify(arg)
   {
      var _loc3_ = undefined;
      var _loc2_ = undefined;
      var _loc6_ = undefined;
      var _loc1_ = "";
      var _loc4_ = undefined;
      switch(typeof arg)
      {
         case "object":
            if(arg)
            {
               if(arg instanceof Array)
               {
                  _loc2_ = 0;
                  while(_loc2_ < arg.length)
                  {
                     _loc4_ = com.clubpenguin.util.JSONParser.stringify(arg[_loc2_]);
                     if(_loc1_)
                     {
                        _loc1_ += ",";
                     }
                     _loc1_ += _loc4_;
                     _loc2_ = _loc2_ + 1;
                  }
                  return "[" + _loc1_ + "]";
               }
               if(typeof arg.toString != "undefined")
               {
                  for(_loc2_ in arg)
                  {
                     _loc4_ = arg[_loc2_];
                     if(typeof _loc4_ != "undefined" && typeof _loc4_ != "function")
                     {
                        _loc4_ = com.clubpenguin.util.JSONParser.stringify(_loc4_);
                        if(_loc1_)
                        {
                           _loc1_ += ",";
                        }
                        _loc1_ += com.clubpenguin.util.JSONParser.stringify(_loc2_) + ":" + _loc4_;
                     }
                  }
                  return "{" + _loc1_ + "}";
               }
            }
            return "null";
         case "number":
            return !isFinite(arg) ? "null" : String(arg);
         case "string":
            _loc6_ = arg.length;
            _loc1_ = "\"";
            _loc2_ = 0;
            while(_loc2_ < _loc6_)
            {
               _loc3_ = arg.charAt(_loc2_);
               if(_loc3_ >= " ")
               {
                  if(_loc3_ == "\\" || _loc3_ == "\"")
                  {
                     _loc1_ += "\\";
                  }
                  _loc1_ += _loc3_;
               }
               else
               {
                  switch(_loc3_)
                  {
                     case "\b":
                        _loc1_ += "\\b";
                        break;
                     case "\f":
                        _loc1_ += "\\f";
                        break;
                     case "\n":
                        _loc1_ += "\\n";
                        break;
                     case "\r":
                        _loc1_ += "\\r";
                        break;
                     case "\t":
                        _loc1_ += "\\t";
                        break;
                     default:
                        _loc3_ = _loc3_.charCodeAt();
                        _loc1_ += "\\u00" + Math.floor(_loc3_ / 16).toString(16) + (_loc3_ % 16).toString(16);
                  }
               }
               _loc2_ += 1;
            }
            return _loc1_ + "\"";
         case "boolean":
            return String(arg);
         default:
            return "null";
      }
   }
   static function parse(text)
   {
      var at = 0;
      var ch = " ";
      var _value;
      var _error = function(m)
      {
         throw {name:"JSONError",message:m,at:at - 1,text:text.substr(at - 20,40) + "\n" + text};
      };
      var _loc11_ = parseInt(text);
      if(!isNaN(_loc11_))
      {
         _error("Cannot parse number string.");
      }
      var _next = function()
      {
         ch = text.charAt(at);
         at += 1;
         return ch;
      };
      var _white = function()
      {
         while(ch)
         {
            if(ch <= " ")
            {
               _next();
            }
            else
            {
               if(ch != "/")
               {
                  break;
               }
               switch(_next())
               {
                  case "/":
                     while(_next() && ch != "\n" && ch != "\r")
                     {
                     }
                     break;
                  case "*":
                     _next();
                     while(true)
                     {
                        if(ch)
                        {
                           if(ch == "*")
                           {
                              if(_next() == "/")
                              {
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
                     _next();
                     continue;
                  default:
                     _error("Syntax error");
               }
            }
         }
      };
      var _string = function()
      {
         var _loc4_ = undefined;
         var _loc1_ = "";
         var _loc3_ = undefined;
         var _loc2_ = undefined;
         var _loc5_ = false;
         if(ch == "\"")
         {
            while(_next())
            {
               if(ch == "\"")
               {
                  _next();
                  return _loc1_;
               }
               if(ch == "\\")
               {
                  switch(_next())
                  {
                     case "b":
                        _loc1_ += "\b";
                        break;
                     case "f":
                        _loc1_ += "\f";
                        break;
                     case "n":
                        _loc1_ += "\n";
                        break;
                     case "r":
                        _loc1_ += "\r";
                        break;
                     case "t":
                        _loc1_ += "\t";
                        break;
                     case "u":
                        _loc2_ = 0;
                        _loc4_ = 0;
                        while(_loc4_ < 4)
                        {
                           _loc3_ = parseInt(_next(),16);
                           if(!isFinite(_loc3_))
                           {
                              _loc5_ = true;
                              break;
                           }
                           _loc2_ = _loc2_ * 16 + _loc3_;
                           _loc4_ += 1;
                        }
                        if(_loc5_)
                        {
                           _loc5_ = false;
                           break;
                        }
                        _loc1_ += String.fromCharCode(_loc2_);
                        break;
                     default:
                        _loc1_ += ch;
                  }
               }
               else
               {
                  _loc1_ += ch;
               }
            }
         }
         _error("Bad string");
      };
      var _array = function()
      {
         var _loc1_ = [];
         if(ch == "[")
         {
            _next();
            _white();
            if(ch == "]")
            {
               _next();
               return _loc1_;
            }
            while(ch)
            {
               _loc1_.push(_value());
               _white();
               if(ch == "]")
               {
                  _next();
                  return _loc1_;
               }
               if(ch != ",")
               {
                  break;
               }
               _next();
               _white();
            }
         }
         _error("Bad array");
      };
      var _object = function()
      {
         var _loc2_ = undefined;
         var _loc1_ = {};
         if(ch == "{")
         {
            _next();
            _white();
            if(ch == "}")
            {
               _next();
               return _loc1_;
            }
            while(ch)
            {
               _loc2_ = _string();
               _white();
               if(ch != ":")
               {
                  break;
               }
               _next();
               _loc1_[_loc2_] = _value();
               _white();
               if(ch == "}")
               {
                  _next();
                  return _loc1_;
               }
               if(ch != ",")
               {
                  break;
               }
               _next();
               _white();
            }
         }
         _error("Bad object");
      };
      var _number = function()
      {
         var _loc1_ = "";
         var _loc2_ = undefined;
         if(ch == "-")
         {
            _loc1_ = "-";
            _next();
         }
         while(ch >= "0" && ch <= "9")
         {
            _loc1_ += ch;
            _next();
         }
         if(ch == ".")
         {
            _loc1_ += ".";
            while(_next() && ch >= "0" && ch <= "9")
            {
               _loc1_ += ch;
            }
         }
         _loc2_ = 1 * _loc1_;
         if(!isFinite(_loc2_))
         {
            _error("Bad number");
         }
         return _loc2_;
      };
      var _word = function()
      {
         switch(ch)
         {
            case "t":
               if(_next() == "r" && _next() == "u" && _next() == "e")
               {
                  _next();
                  return true;
               }
               break;
            case "f":
               if(_next() == "a" && _next() == "l" && _next() == "s" && _next() == "e")
               {
                  _next();
                  return false;
               }
               break;
            case "n":
               if(_next() == "u" && _next() == "l" && _next() == "l")
               {
                  _next();
                  return null;
               }
               break;
         }
         _error("Syntax error");
      };
      _value = function()
      {
         _white();
         switch(ch)
         {
            case "{":
               return _object();
            case "[":
               return _array();
            case "\"":
               return _string();
            case "-":
               return _number();
            default:
               return !(ch >= "0" && ch <= "9") ? _word() : _number();
         }
      };
      return _value();
   }
}
