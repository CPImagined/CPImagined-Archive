//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.disney.dce.phrasechat.view.PhraseChatSelection extends MovieClip
    {
        var __selectionField, tfSelected, __selectedString, onRollOver, onRollOut, onRelease, __baseSuggestion, __baseTextWidth, __onX, _x, __offX, __phraseID, __selectionCallback, __wordIndex, bg, _visible, gotoAndStop, __owner, __phraseObj;
        function PhraseChatSelection () {
            super();
            __selectionField = tfSelected;
            __selectionField.width = 0;
            selectionString = (__selectedString);
            onRollOver = onOver;
            onRollOut = onOut;
            onRelease = onSelected;
            if ((__baseSuggestion != null) && (__baseSuggestion != "")) {
                __selectionField.text = __baseSuggestion;
                __selectionField._width = (__baseTextWidth = __selectionField.textWidth + (2 * TEXT_PADDING));
                __selectionField.text = __selectedString;
            } else {
                __selectionField.text = __selectedString;
                __selectionField._width = __selectionField.textWidth + (2 * TEXT_PADDING);
            }
            updateWidth();
            __onX = _x;
            __offX = -1000;
        }
        function get phraseID() {
            return(__phraseID);
        }
        function get selectionCallback() {
            return(__selectionCallback);
        }
        function get selectionString() {
            return(__selectionField.text);
        }
        function set selectionString(s) {
            __selectionField.text = s;
            //return(selectionString);
        }
        function get wordIndex() {
            return(__wordIndex);
        }
        function updateWidth() {
            bg._width = __selectionField._width + (2 * NICESLICE_WIDTH);
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
            selectionCallback.call(__owner, this);
        }
        function log(str) {
        }
        function set phraseObj(obj) {
            __phraseObj = obj;
            //return(phraseObj);
        }
        function get phraseObj() {
            return(__phraseObj);
        }
        var TEXT_PADDING = 6;
        var NICESLICE_WIDTH = 8;
    }
