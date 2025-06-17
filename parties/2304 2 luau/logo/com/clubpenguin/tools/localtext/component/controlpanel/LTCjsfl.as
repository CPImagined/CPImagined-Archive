package com.clubpenguin.tools.localtext.component.controlpanel
{
    import adobe.utils.*;
    import fl.controls.*;
    import flash.text.*;

    public class LTCjsfl extends Object
    {
        private static const HANDLE_CS6_BUG:Boolean = true;
        private static const CS6_BUG_FL_DOC_LTC_PARAM_NAME:String = "localTextComponentOrderedParamterNames";

        public function LTCjsfl()
        {
            return;
        }// end function

        public static function getOrderedParameterIndicesFromSelection() : String
        {
            if (HANDLE_CS6_BUG)
            {
                return handleCS6MissingParameterNameBug();
            }
            return getOrderedParamString();
        }// end function

        private static function getOrderedParamString() : String
        {
            var _loc_1:* = "function getParamNames() {" + "var selection = fl.getDocumentDOM().selection[0];" + "if (selection != undefined) {" + "var paramNames = new Array();" + "for (var i = 0; i < selection.parameters.length; i++) {" + "\tparamNames[i] = selection.parameters[i].name;" + "}" + "return paramNames;" + "} else {" + "\tfl.outputPanel.trace(\'ERROR: Valid LocalTextComponent Live Preview is not selected!\');" + "}" + "return [];" + "} getParamNames();";
            return MMExecute(_loc_1);
        }// end function

        public static function getValueJSFLForParamIndex(param1:uint, param2:String) : String
        {
            var _loc_3:* = "fl.getDocumentDOM().selection[0].parameters[" + param1 + "]." + param2;
            return _loc_3;
        }// end function

        public static function getAssignmentJSFLForParamIndex(param1:uint, param2:String, param3, param4:Boolean = false) : String
        {
            var _loc_5:* = !param4 && (param3 is Number || param3 is int || param3 is uint) ? ("") : ("\"");
            var _loc_6:* = getValueJSFLForParamIndex(param1, param2) + " = " + _loc_5 + param3 + _loc_5 + ";" + "fl.getDocumentDOM().livePreview = true;";
            return getValueJSFLForParamIndex(param1, param2) + " = " + _loc_5 + param3 + _loc_5 + ";" + "fl.getDocumentDOM().livePreview = true;";
        }// end function

        public static function comboBoxFromJSFL(param1:uint, param2:ComboBox) : void
        {
            var _loc_3:* = listFromJSFL(param1);
            param2.removeAll();
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3.length)
            {
                
                param2.addItem({label:_loc_3[_loc_4], data:_loc_3[_loc_4]});
                _loc_4 = _loc_4 + 1;
            }
            return;
        }// end function

        public static function listFromJSFL(param1:uint) : Array
        {
            var _loc_2:* = "function getListItemNames() {" + "var listItemParameters = fl.getDocumentDOM().selection[0].parameters[" + param1 + "].value;" + "var listItemNames = new Array();" + "for (var i = 0; i < listItemParameters.length; i++) {" + "\tlistItemNames[i] = listItemParameters[i].value;" + "}" + "return listItemNames;" + "} getListItemNames();";
            var _loc_3:* = MMExecute(_loc_2).split(",");
            return _loc_3;
        }// end function

        public static function getParameterColorInt(param1:String) : int
        {
            var _loc_2:* = param1;
            var _loc_3:* = _loc_2.indexOf("#");
            if (_loc_3 > -1)
            {
                _loc_2 = _loc_2.substr((_loc_3 + 1));
                return parseInt(_loc_2, 16);
            }
            return int(_loc_2);
        }// end function

        public static function rgbAndAlphaToHexRGBA(param1:uint, param2:Number) : String
        {
            var _loc_3:* = param1 >> 16 & 255;
            var _loc_4:* = _loc_3.toString(16);
            if (_loc_3 < 16)
            {
                _loc_4 = "0" + _loc_4;
            }
            var _loc_5:* = param1 >> 8 & 255;
            var _loc_6:* = (_loc_5).toString(16);
            if (_loc_5 < 16)
            {
                _loc_6 = "0" + _loc_6;
            }
            var _loc_7:* = param1 & 255;
            var _loc_8:* = (_loc_7).toString(16);
            if (_loc_7 < 16)
            {
                _loc_8 = "0" + _loc_8;
            }
            var _loc_9:* = param2 * 255;
            var _loc_10:* = (_loc_9).toString(16);
            if (_loc_9 < 16)
            {
                _loc_10 = "0" + _loc_10;
            }
            return "#" + _loc_4 + _loc_6 + _loc_8 + _loc_10;
        }// end function

        public static function hexRGBAToUInt(param1:String) : uint
        {
            if (param1.indexOf("#") != 0)
            {
                throw new Error("Not a valid hex string. Must begin with #.");
            }
            var _loc_2:* = param1.substr(1);
            if (_loc_2.length == 6)
            {
                _loc_2 = _loc_2 + "ff";
            }
            return uint("0x" + _loc_2);
        }// end function

        public static function showAlert(param1:String) : void
        {
            MMExecute("alert(\'" + param1 + "\');");
            return;
        }// end function

        public static function limitInputTextToRange(param1:Number, param2:Number, param3:Number, param4:TextField) : Number
        {
            var _loc_5:* = param1;
            if (param1 > param3)
            {
                _loc_5 = param3;
            }
            else if (param1 < param2)
            {
                _loc_5 = param2;
            }
            if (_loc_5 != param1)
            {
                param4.text = "" + _loc_5;
            }
            return _loc_5;
        }// end function

        private static function handleCS6MissingParameterNameBug() : String
        {
            var _loc_1:* = MMExecute("fl.getDocumentDOM().selection[0].parameters[0].name;") == "";
            var _loc_2:* = MMExecute("fl.getDocumentDOM().getDataFromDocument(\'" + CS6_BUG_FL_DOC_LTC_PARAM_NAME + "\');");
            var _loc_3:* = parseInt(_loc_2) != 0;
            if (!_loc_1)
            {
                _loc_2 = getOrderedParamString();
                if (!_loc_3)
                {
                    MMExecute("fl.getDocumentDOM().addDataToDocument(\'" + CS6_BUG_FL_DOC_LTC_PARAM_NAME + "\', \'string\', \'" + _loc_2 + "\')");
                }
            }
            return _loc_2;
        }// end function

    }
}
