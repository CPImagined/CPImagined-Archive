//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.stampbook.controls.LabeledButton extends com.clubpenguin.stamps.stampbook.controls.BaseButton
    {
        var _label, label_field;
        function LabeledButton () {
            super();
        }
        function get label() {
            return(_label);
        }
        function set label(value) {
            if (_label == value) {
                return;
            }
            _label = value;
            setTextLabel();
            //return(label);
        }
        function setTextLabel() {
            label_field.text = _label;
        }
        static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.LabeledButton;
        static var LINKAGE_ID = "LabeledButton";
    }
