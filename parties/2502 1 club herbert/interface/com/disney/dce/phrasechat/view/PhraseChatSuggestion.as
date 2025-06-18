//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.disney.dce.phrasechat.view.PhraseChatSuggestion extends MovieClip
    {
        var __suggestionField, tfSuggestion, onRollOver, onRollOut, onRelease, __baseSuggestion, __baseTextWidth, __onX, _x, __offX, __selectionCallback, bg, _visible, gotoAndStop, __owner, __wordIndex;
        function PhraseChatSuggestion () {
            super();
            __suggestionField = tfSuggestion;
            onRollOver = onOver;
            onRollOut = onOut;
            onRelease = onSelected;
            if ((__baseSuggestion != null) && (__baseSuggestion != "")) {
                __suggestionField.text = __baseSuggestion;
                __suggestionField._width = (__baseTextWidth = __suggestionField.textWidth + (2 * TEXT_PADDING));
                __suggestionField.text = __suggestedString;
            } else {
                __suggestionField.text = __suggestedString;
                __suggestionField._width = __suggestionField.textWidth + (2 * TEXT_PADDING);
            }
            updateWidth();
            __onX = _x;
            __offX = -1000;
        }
        function get suggestedString() {
            return(__suggestedString);
        }
        function get suggestionText() {
            return(__suggestionField.text);
        }
        function set suggestionText(s) {
            __suggestionField.text = s;
            //return(suggestionText);
        }
        function get selectionCallback() {
            return(__selectionCallback);
        }
        function updateWidth() {
            bg._width = __suggestionField._width + (2 * NICESLICE_WIDTH);
        }
        function offScreen() {
            _visible = false;
            _x = __offX;
        }
        function onScreen() {
            _visible = true;
            _x = __onX;
        }
        function onOver() {
            this.gotoAndStop(2);
            updateWidth();
        }
        function onOut() {
            this.gotoAndStop(1);
            updateWidth();
        }
        function onSelected() {
            selectionCallback.call(__owner, suggestionText, __wordIndex, this);
        }
        function log(str) {
        }
        var __suggestedString = "";
        var TEXT_PADDING = 6;
        var NICESLICE_WIDTH = 8;
    }
