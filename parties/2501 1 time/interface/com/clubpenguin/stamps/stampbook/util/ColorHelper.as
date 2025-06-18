//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.stampbook.util.ColorHelper extends com.clubpenguin.util.EventDispatcher
    {
        static var _instance;
        var _colourIndex, dispatchEvent, _highlightIndex, _patternIndex, _iconIndex;
        function ColorHelper () {
            super();
        }
        static function getInstance() {
            if (_instance == null) {
                _instance = new com.clubpenguin.stamps.stampbook.util.ColorHelper();
            }
            return(_instance);
        }
        function getColourIndex() {
            return(_colourIndex);
        }
        function setColourIndex(colour) {
            _colourIndex = colour;
            dispatchEvent({type:"colorChange", colour:_colourIndex});
        }
        function getHighlightIndex() {
            return(_highlightIndex);
        }
        function setHighlightIndex(highlightIndex) {
            _highlightIndex = highlightIndex;
            dispatchEvent({type:"highlightChange", highlight:_highlightIndex});
        }
        function getPatternIndex() {
            return(_patternIndex);
        }
        function setPatternIndex(patternIndex) {
            _patternIndex = patternIndex;
        }
        function getIconIndex() {
            return(_iconIndex);
        }
        function setIconIndex(iconIndex) {
            _iconIndex = iconIndex;
        }
        static var CLASS_REF = com.clubpenguin.stamps.stampbook.util.ColorHelper;
        static var LINKAGE_ID = "ColorHelper";
    }
