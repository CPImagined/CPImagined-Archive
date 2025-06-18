//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.stampbook.controls.BaseButton extends MovieClip
    {
        var useHandCursor, gotoAndStop, dispatchEvent;
        function BaseButton () {
            super();
            com.clubpenguin.util.EventDispatcher.initialize(this);
        }
        function onLoad() {
            configUI();
        }
        function get enabled() {
            return(_enabled);
        }
        function set enabled(value) {
            _enabled = value;
            useHandCursor = value;
            this.gotoAndStop((_selected ? "selected_up" : "up"));
            //return(enabled);
        }
        function get toggle() {
            return(_toggle);
        }
        function set toggle(value) {
            _toggle = value;
            //return(toggle);
        }
        function get selected() {
            return(_selected);
        }
        function set selected(value) {
            _selected = value;
            this.gotoAndStop((_selected ? "selected_up" : "up"));
            //return(selected);
        }
        function onPress() {
            if (!_enabled) {
                return(undefined);
            }
            this.gotoAndStop((_toggle ? (((!_selected) ? "down" : "selected_down")) : "down"));
            dispatchEvent({type:"press"});
        }
        function onRelease() {
            if (!_enabled) {
                return(undefined);
            }
            this.gotoAndStop((_toggle ? (((!_selected) ? "over" : "selected_over")) : "over"));
            dispatchEvent({type:"release"});
        }
        function onRollOver() {
            if (!_enabled) {
                return(undefined);
            }
            this.gotoAndStop((_toggle ? (((!_selected) ? "over" : "selected_over")) : "over"));
            dispatchEvent({type:"over"});
        }
        function onRollOut() {
            if (!_enabled) {
                return(undefined);
            }
            this.gotoAndStop((_toggle ? (((!_selected) ? "up" : "selected_up")) : "up"));
            dispatchEvent({type:"out"});
        }
        function configUI() {
        }
        static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.BaseButton;
        static var LINKAGE_ID = "BaseButton";
        var _enabled = true;
        var _toggle = false;
        var _selected = false;
    }
