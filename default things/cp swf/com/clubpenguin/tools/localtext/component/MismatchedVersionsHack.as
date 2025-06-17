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

        public function MismatchedVersionsHack(wordWrapDataPropIndex:uint=0, wordWrapValueID:String="")
        {
            this.wordWrapDataPropertyIndex = wordWrapDataPropIndex;
            this.wordWrapValueID = wordWrapValueID;
        }

        private function getControlValuesFromWordWrapData():void
        {
            var combined:String = MMExecute(this.getValueJSFLForParamIndex(this.wordWrapDataPropertyIndex, this.wordWrapValueID));
            var splitValues:Array = combined.split(DELIMITER);
            if (splitValues.length == 0)
            {
                return;
            };
            this._wordWrapData = ((splitValues[WORD_WRAP_INDEX]) ? splitValues[WORD_WRAP_INDEX] : "");
            this._letterSpacingData = ((splitValues[LET_SPACING_DATA_INDEX]) ? splitValues[LET_SPACING_DATA_INDEX] : "");
            this._leadingData = ((splitValues[LEADING_DATA_INDEX]) ? splitValues[LEADING_DATA_INDEX] : "");
            var gLetSp:String = splitValues[GLOBAL_LET_SPACING_INDEX];
            this._globalLetterSpacing = (((!(gLetSp == "")) && (!(isNaN(Number(gLetSp))))) ? Number(gLetSp) : 0);
            var gLed:String = splitValues[GLOBAL_LEADING_INDEX];
            this._globalLeading = (((!(gLed == "")) && (!(isNaN(Number(gLed))))) ? Number(gLed) : 0);
        }

        public function getComponentWordWrapData():String
        {
            this.getControlValuesFromWordWrapData();
            return (this._wordWrapData);
        }

        public function setComponentWordWrapData(wordWrapData:String):void
        {
            this._wordWrapData = wordWrapData;
            this.combineAndSendThroughWordWrapData();
        }

        public function getComponentGlobalLetterSpacing():Number
        {
            this.getControlValuesFromWordWrapData();
            return (this._globalLetterSpacing);
        }

        public function setComponentGlobalLetterSpacing(globalLetterSpacing:Number):void
        {
            this._globalLetterSpacing = globalLetterSpacing;
            this.combineAndSendThroughWordWrapData();
        }

        public function getComponentLetterSpacingData():String
        {
            this.getControlValuesFromWordWrapData();
            return (this._letterSpacingData);
        }

        public function setComponentLetterSpacingData(letterSpacingData:String):void
        {
            this._letterSpacingData = letterSpacingData;
            this.combineAndSendThroughWordWrapData();
        }

        public function getComponentGlobalLeading():Number
        {
            this.getControlValuesFromWordWrapData();
            return (this._globalLeading);
        }

        public function setComponentGlobalLeading(globalLeading:Number):void
        {
            this._globalLeading = globalLeading;
            this.combineAndSendThroughWordWrapData();
        }

        public function getComponentLeadingData():String
        {
            this.getControlValuesFromWordWrapData();
            return (this._leadingData);
        }

        public function setComponentLeadingData(leadingData:String):void
        {
            this._leadingData = leadingData;
            this.combineAndSendThroughWordWrapData();
        }

        private function combineAndSendThroughWordWrapData():void
        {
            var data:String = ((((((((this._wordWrapData + DELIMITER) + this._globalLetterSpacing) + DELIMITER) + this._letterSpacingData) + DELIMITER) + this._globalLeading) + DELIMITER) + this._leadingData);
            MMExecute(this.getAssignmentJSFLForParamIndex(this.wordWrapDataPropertyIndex, this.wordWrapValueID, data));
        }

        public function parseWWPropsToLTC(combinedProperties:String):Array
        {
            var propsArray:Array = combinedProperties.split(DELIMITER);
            var wordWrapData:String = ((propsArray[WORD_WRAP_INDEX]) ? propsArray[WORD_WRAP_INDEX] : "");
            var letterSpacingData:String = ((propsArray[LET_SPACING_DATA_INDEX]) ? propsArray[LET_SPACING_DATA_INDEX] : "");
            var leadingData:String = ((propsArray[LEADING_DATA_INDEX]) ? propsArray[LEADING_DATA_INDEX] : "");
            var gLetSp:String = propsArray[GLOBAL_LET_SPACING_INDEX];
            var globalLetterSpacing:Number = (((!(gLetSp == "")) && (!(isNaN(Number(gLetSp))))) ? Number(gLetSp) : 0);
            var gLed:String = propsArray[GLOBAL_LEADING_INDEX];
            var globalLeading:Number = (((!(gLed == "")) && (!(isNaN(Number(gLed))))) ? Number(gLed) : 0);
            return ([wordWrapData, globalLetterSpacing, letterSpacingData, globalLeading, leadingData]);
        }

        public function parseWWPropsToLTF(combinedProperties:String, ltf:ILocalTextField):void
        {
            var propsArray:Array = combinedProperties.split(DELIMITER);
            var wordWrapData:String = ((propsArray[WORD_WRAP_INDEX]) ? propsArray[WORD_WRAP_INDEX] : "");
            var letterSpacingData:String = ((propsArray[LET_SPACING_DATA_INDEX]) ? propsArray[LET_SPACING_DATA_INDEX] : "");
            var leadingData:String = ((propsArray[LEADING_DATA_INDEX]) ? propsArray[LEADING_DATA_INDEX] : "");
            var gLetSp:String = propsArray[GLOBAL_LET_SPACING_INDEX];
            var globalLetterSpacing:Number = (((!(gLetSp == "")) && (!(isNaN(Number(gLetSp))))) ? Number(gLetSp) : 0);
            var gLed:String = propsArray[GLOBAL_LEADING_INDEX];
            var globalLeading:Number = (((!(gLed == "")) && (!(isNaN(Number(gLed))))) ? Number(gLed) : 0);
            ltf.setProperty("wordWrapData", wordWrapData);
            ltf.setProperty("letterSpacingData", letterSpacingData);
            ltf.setProperty("leadingData", leadingData);
            ltf.setProperty("globalLetterSpacing", globalLetterSpacing);
            ltf.setProperty("globalLeading", globalLeading);
        }

        private function getAssignmentJSFLForParamIndex(paramNameIndex:uint, valueID:String, value:*, forceString:Boolean=false):String
        {
            var quote:String = (((!(forceString)) && (((value is Number) || (value is int)) || (value is uint))) ? "" : '"');
            var assignJSFL:String = ((((((this.getValueJSFLForParamIndex(paramNameIndex, valueID) + " = ") + quote) + value) + quote) + ";") + "fl.getDocumentDOM().livePreview = true;");
            return (assignJSFL);
        }

        private function getValueJSFLForParamIndex(paramNameIndex:uint, valueID:String):String
        {
            var jsfl:String = ((("fl.getDocumentDOM().selection[0].parameters[" + paramNameIndex) + "].") + valueID);
            return (jsfl);
        }


    }
}//package com.clubpenguin.tools.localtext.component
