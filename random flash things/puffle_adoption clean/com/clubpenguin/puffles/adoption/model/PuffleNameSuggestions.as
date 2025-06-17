//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.puffles.adoption.model
{
    public class PuffleNameSuggestions 
    {

        private var _puffleNameSuggestions:Array;

        public function PuffleNameSuggestions()
        {
            this._puffleNameSuggestions = new Array();
        }

        public function parseAndAddSuggestions(suggestionList:String):void
        {
            var suggestionPairs:Array;
            var pair:Object;
            var pairArray:Array = new Array();
            suggestionPairs = suggestionList.split(",");
            var i:uint;
            while (i < suggestionPairs.length)
            {
                if (suggestionPairs[i])
                {
                    pairArray = String(suggestionPairs[i]).split("|");
                    pair = new Object();
                    pair.name = pairArray[0];
                    pair.rating = pairArray[1];
                    this._puffleNameSuggestions.push(pair);
                };
                i++;
            };
        }

        public function spliceAndReturnNextSuggestion():String
        {
            var suggestion:String = this._puffleNameSuggestions[0].name;
            this._puffleNameSuggestions.splice(0, 1);
            return (suggestion);
        }

        public function get length():uint
        {
            return (this._puffleNameSuggestions.length);
        }

        public function resetSuggestionList():void
        {
            this._puffleNameSuggestions = new Array();
        }


    }
}//package com.clubpenguin.puffles.adoption.model
