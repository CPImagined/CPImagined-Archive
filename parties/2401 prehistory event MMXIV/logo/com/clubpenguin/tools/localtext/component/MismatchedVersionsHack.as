//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.tools.localtext.component
{
    import adobe.utils.MMExecute;
    import com.clubpenguin.tools.localtext.core.ILocalTextField;

    public class MismatchedVersionsHack 
    {

        public static const DELIMITER:String = "||";
        public static const WORD_WRAP_INDEX:uint = 0;
        public static const GLOBAL_LET_SPACING_INDEX:uint = 1;
        public static const LET_SPACING_DATA_INDEX:uint = 2;
        public static const GLOBAL_LEADING_INDEX:uint = 3;
        public static const LEADING_DATA_INDEX:uint = 4;

        private var wordWrapDataPropertyIndex:uint = 0;
        private var wordWrapValueID:String = "";
        private var _wordWrapData:String = "";
        private var _globalLetterSpacing:Number = 0;
        private var _letterSpacingData:String = "";
        private var _globalLeading:Number = 0;
        private var _leadingData:String = "";

        public function MismatchedVersionsHack(_arg_1:uint=0, _arg_2:String="")
        {
            this.wordWrapDataPropertyIndex = _arg_1;
            this.wordWrapValueID = _arg_2;
        }

        private function getControlValuesFromWordWrapData():void
        {
            var _local_1:String = MMExecute(this.getValueJSFLForParamIndex(this.wordWrapDataPropertyIndex, this.wordWrapValueID));
            var _local_2:Array = _local_1.split(DELIMITER);
            if (_local_2.length == 0)
            {
                return;
            };
            this._wordWrapData = ((_local_2[WORD_WRAP_INDEX]) ? _local_2[WORD_WRAP_INDEX] : "");
            this._letterSpacingData = ((_local_2[LET_SPACING_DATA_INDEX]) ? _local_2[LET_SPACING_DATA_INDEX] : "");
            this._leadingData = ((_local_2[LEADING_DATA_INDEX]) ? _local_2[LEADING_DATA_INDEX] : "");
            var _local_3:String = _local_2[GLOBAL_LET_SPACING_INDEX];
            this._globalLetterSpacing = (((!(_local_3 == "")) && (!(isNaN(Number(_local_3))))) ? Number(_local_3) : 0);
            var _local_4:String = _local_2[GLOBAL_LEADING_INDEX];
            this._globalLeading = (((!(_local_4 == "")) && (!(isNaN(Number(_local_4))))) ? Number(_local_4) : 0);
        }

        public function getComponentWordWrapData():String
        {
            this.getControlValuesFromWordWrapData();
            return (this._wordWrapData);
        }

        public function setComponentWordWrapData(_arg_1:String):void
        {
            this._wordWrapData = _arg_1;
            this.combineAndSendThroughWordWrapData();
        }

        public function getComponentGlobalLetterSpacing():Number
        {
            this.getControlValuesFromWordWrapData();
            return (this._globalLetterSpacing);
        }

        public function setComponentGlobalLetterSpacing(_arg_1:Number):void
        {
            this._globalLetterSpacing = _arg_1;
            this.combineAndSendThroughWordWrapData();
        }

        public function getComponentLetterSpacingData():String
        {
            this.getControlValuesFromWordWrapData();
            return (this._letterSpacingData);
        }

        public function setComponentLetterSpacingData(_arg_1:String):void
        {
            this._letterSpacingData = _arg_1;
            this.combineAndSendThroughWordWrapData();
        }

        public function getComponentGlobalLeading():Number
        {
            this.getControlValuesFromWordWrapData();
            return (this._globalLeading);
        }

        public function setComponentGlobalLeading(_arg_1:Number):void
        {
            this._globalLeading = _arg_1;
            this.combineAndSendThroughWordWrapData();
        }

        public function getComponentLeadingData():String
        {
            this.getControlValuesFromWordWrapData();
            return (this._leadingData);
        }

        public function setComponentLeadingData(_arg_1:String):void
        {
            this._leadingData = _arg_1;
            this.combineAndSendThroughWordWrapData();
        }

        private function combineAndSendThroughWordWrapData():void
        {
            var _local_1:String = ((((((((this._wordWrapData + DELIMITER) + this._globalLetterSpacing) + DELIMITER) + this._letterSpacingData) + DELIMITER) + this._globalLeading) + DELIMITER) + this._leadingData);
            MMExecute(this.getAssignmentJSFLForParamIndex(this.wordWrapDataPropertyIndex, this.wordWrapValueID, _local_1));
        }

        public function parseWWPropsToLTC(_arg_1:String):Array
        {
            var _local_2:Array = _arg_1.split(DELIMITER);
            var _local_3:String = ((_local_2[WORD_WRAP_INDEX]) ? _local_2[WORD_WRAP_INDEX] : "");
            var _local_4:String = ((_local_2[LET_SPACING_DATA_INDEX]) ? _local_2[LET_SPACING_DATA_INDEX] : "");
            var _local_5:String = ((_local_2[LEADING_DATA_INDEX]) ? _local_2[LEADING_DATA_INDEX] : "");
            var _local_6:String = _local_2[GLOBAL_LET_SPACING_INDEX];
            var _local_7:Number = (((!(_local_6 == "")) && (!(isNaN(Number(_local_6))))) ? Number(_local_6) : 0);
            var _local_8:String = _local_2[GLOBAL_LEADING_INDEX];
            var _local_9:Number = (((!(_local_8 == "")) && (!(isNaN(Number(_local_8))))) ? Number(_local_8) : 0);
            return ([_local_3, _local_7, _local_4, _local_9, _local_5]);
        }

        public function parseWWPropsToLTF(_arg_1:String, _arg_2:ILocalTextField):void
        {
            var _local_3:Array = _arg_1.split(DELIMITER);
            var _local_4:String = ((_local_3[WORD_WRAP_INDEX]) ? _local_3[WORD_WRAP_INDEX] : "");
            var _local_5:String = ((_local_3[LET_SPACING_DATA_INDEX]) ? _local_3[LET_SPACING_DATA_INDEX] : "");
            var _local_6:String = ((_local_3[LEADING_DATA_INDEX]) ? _local_3[LEADING_DATA_INDEX] : "");
            var _local_7:String = _local_3[GLOBAL_LET_SPACING_INDEX];
            var _local_8:Number = (((!(_local_7 == "")) && (!(isNaN(Number(_local_7))))) ? Number(_local_7) : 0);
            var _local_9:String = _local_3[GLOBAL_LEADING_INDEX];
            var _local_10:Number = (((!(_local_9 == "")) && (!(isNaN(Number(_local_9))))) ? Number(_local_9) : 0);
            _arg_2.setProperty("wordWrapData", _local_4);
            _arg_2.setProperty("letterSpacingData", _local_5);
            _arg_2.setProperty("leadingData", _local_6);
            _arg_2.setProperty("globalLetterSpacing", _local_8);
            _arg_2.setProperty("globalLeading", _local_10);
        }

        private function getAssignmentJSFLForParamIndex(_arg_1:uint, _arg_2:String, _arg_3:*, _arg_4:Boolean=false):String
        {
            var _local_5:String = (((!(_arg_4)) && (((_arg_3 is Number) || (_arg_3 is int)) || (_arg_3 is uint))) ? "" : '"');
            var _local_6:* = ((((((this.getValueJSFLForParamIndex(_arg_1, _arg_2) + " = ") + _local_5) + _arg_3) + _local_5) + ";") + "fl.getDocumentDOM().livePreview = true;");
            return (_local_6);
        }

        private function getValueJSFLForParamIndex(_arg_1:uint, _arg_2:String):String
        {
            return ((("fl.getDocumentDOM().selection[0].parameters[" + _arg_1) + "].") + _arg_2);
        }


    }
}//package com.clubpenguin.tools.localtext.component
