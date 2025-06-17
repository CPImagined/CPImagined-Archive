//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.tools.localtext.component.controlpanel
{
    import adobe.utils.MMExecute;
    import fl.controls.ComboBox;
    import flash.text.TextField;

    public class LTCjsfl 
    {

        private static const HANDLE_CS6_BUG:Boolean = true;
        private static const CS6_BUG_FL_DOC_LTC_PARAM_NAME:String = "localTextComponentOrderedParamterNames";


        public static function getOrderedParameterIndicesFromSelection():String
        {
            if (HANDLE_CS6_BUG)
            {
                return (handleCS6MissingParameterNameBug());
            };
            return (getOrderedParamString());
        }

        private static function getOrderedParamString():String
        {
            var _local_1:String = (((((((((((("function getParamNames() {" + "var selection = fl.getDocumentDOM().selection[0];") + "if (selection != undefined) {") + "var paramNames = new Array();") + "for (var i = 0; i < selection.parameters.length; i++) {") + "\tparamNames[i] = selection.parameters[i].name;") + "}") + "return paramNames;") + "} else {") + "\tfl.outputPanel.trace('ERROR: Valid LocalTextComponent Live Preview is not selected!');") + "}") + "return [];") + "} getParamNames();");
            return (MMExecute(_local_1));
        }

        public static function getValueJSFLForParamIndex(_arg_1:uint, _arg_2:String):String
        {
            return ((("fl.getDocumentDOM().selection[0].parameters[" + _arg_1) + "].") + _arg_2);
        }

        public static function getAssignmentJSFLForParamIndex(_arg_1:uint, _arg_2:String, _arg_3:*, _arg_4:Boolean=false):String
        {
            var _local_5:String = (((!(_arg_4)) && (((_arg_3 is Number) || (_arg_3 is int)) || (_arg_3 is uint))) ? "" : '"');
            return ((((((getValueJSFLForParamIndex(_arg_1, _arg_2) + " = ") + _local_5) + _arg_3) + _local_5) + ";") + "fl.getDocumentDOM().livePreview = true;");
        }

        public static function comboBoxFromJSFL(_arg_1:uint, _arg_2:ComboBox):void
        {
            var _local_3:Array = listFromJSFL(_arg_1);
            _arg_2.removeAll();
            var _local_4:uint;
            while (_local_4 < _local_3.length)
            {
                _arg_2.addItem({
                    "label":_local_3[_local_4],
                    "data":_local_3[_local_4]
                });
                _local_4++;
            };
        }

        public static function listFromJSFL(_arg_1:uint):Array
        {
            var _local_2:String = ((((((((("function getListItemNames() {" + "var listItemParameters = fl.getDocumentDOM().selection[0].parameters[") + _arg_1) + "].value;") + "var listItemNames = new Array();") + "for (var i = 0; i < listItemParameters.length; i++) {") + "\tlistItemNames[i] = listItemParameters[i].value;") + "}") + "return listItemNames;") + "} getListItemNames();");
            return (MMExecute(_local_2).split(","));
        }

        public static function getParameterColorInt(_arg_1:String):int
        {
            var _local_2:String = _arg_1;
            var _local_3:int = _local_2.indexOf("#");
            if (_local_3 > -1)
            {
                _local_2 = _local_2.substr((_local_3 + 1));
                return (parseInt(_local_2, 16));
            };
            return (int(_local_2));
        }

        public static function rgbAndAlphaToHexRGBA(_arg_1:uint, _arg_2:Number):String
        {
            var _local_3:uint = ((_arg_1 >> 16) & 0xFF);
            var _local_4:String = _local_3.toString(16);
            if (_local_3 < 16)
            {
                _local_4 = ("0" + _local_4);
            };
            var _local_5:uint = ((_arg_1 >> 8) & 0xFF);
            var _local_6:String = _local_5.toString(16);
            if (_local_5 < 16)
            {
                _local_6 = ("0" + _local_6);
            };
            var _local_7:uint = (_arg_1 & 0xFF);
            var _local_8:String = _local_7.toString(16);
            if (_local_7 < 16)
            {
                _local_8 = ("0" + _local_8);
            };
            var _local_9:uint = (_arg_2 * 0xFF);
            var _local_10:String = _local_9.toString(16);
            if (_local_9 < 16)
            {
                _local_10 = ("0" + _local_10);
            };
            return (((("#" + _local_4) + _local_6) + _local_8) + _local_10);
        }

        public static function hexRGBAToUInt(_arg_1:String):uint
        {
            if (_arg_1.indexOf("#") != 0)
            {
                throw (new Error("Not a valid hex string. Must begin with #."));
            };
            var _local_2:String = _arg_1.substr(1);
            if (_local_2.length == 6)
            {
                _local_2 = (_local_2 + "ff");
            };
            return (uint(("0x" + _local_2)));
        }

        public static function showAlert(_arg_1:String):void
        {
            MMExecute((("alert('" + _arg_1) + "');"));
        }

        public static function limitInputTextToRange(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:TextField):Number
        {
            var _local_5:Number = _arg_1;
            if (_arg_1 > _arg_3)
            {
                _local_5 = _arg_3;
            }
            else
            {
                if (_arg_1 < _arg_2)
                {
                    _local_5 = _arg_2;
                };
            };
            if (_local_5 != _arg_1)
            {
                _arg_4.text = ("" + _local_5);
            };
            return (_local_5);
        }

        private static function handleCS6MissingParameterNameBug():String
        {
            var _local_1:Boolean = (MMExecute("fl.getDocumentDOM().selection[0].parameters[0].name;") == "");
            var _local_2:String = MMExecute((("fl.getDocumentDOM().getDataFromDocument('" + CS6_BUG_FL_DOC_LTC_PARAM_NAME) + "');"));
            var _local_3:Boolean = (!(parseInt(_local_2) == 0));
            if ((!(_local_1)))
            {
                _local_2 = getOrderedParamString();
                if ((!(_local_3)))
                {
                    MMExecute((((("fl.getDocumentDOM().addDataToDocument('" + CS6_BUG_FL_DOC_LTC_PARAM_NAME) + "', 'string', '") + _local_2) + "')"));
                };
            };
            return (_local_2);
        }


    }
}//package com.clubpenguin.tools.localtext.component.controlpanel
