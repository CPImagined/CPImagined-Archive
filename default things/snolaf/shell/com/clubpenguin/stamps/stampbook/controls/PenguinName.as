//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.stampbook.controls.PenguinName extends MovieClip
    {
        var _label, __get__label, penguinName1, field2, field3, field7, __get__colorValue, field4, field5, field6;
        function PenguinName () {
            super();
        }
        function onLoad() {
            configUI();
        }
        function set label(value) {
            _label = value;
            setTextLabel();
            //return(__get__label());
        }
        function set colorValue(value) {
            penguinName1.textColor = value;
            field2.penguinName.textColor = value;
            field3.penguinName.textColor = value;
            field7.penguinName.textColor = value;
            //return(__get__colorValue());
        }
        function configUI() {
        }
        function setTextLabel() {
            penguinName1.text = _label;
            field2.penguinName.text = _label;
            field3.penguinName.text = _label;
            field4.penguinName.text = _label;
            field5.penguinName.text = _label;
            field6.penguinName.text = _label;
            field7.penguinName.text = _label;
            penguinName1.autoSize = "left";
            field2.penguinName.autoSize = "left";
            field3.penguinName.autoSize = "left";
            field4.penguinName.autoSize = "left";
            field5.penguinName.autoSize = "left";
            field6.penguinName.autoSize = "left";
            field7.penguinName.autoSize = "left";
        }
        static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.PenguinName;
        static var LINKAGE_ID = "PenguinName";
    }
