//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.stampbook.controls.PenguinStamps extends MovieClip
    {
        var _label, __get__label, penguinName1, field2, field3, field7, __get__colorValue, field4, field5;
        function PenguinStamps () {
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
            field7.penguinName.text = _label;
            penguinName1.autoSize = "right";
            field2.penguinName.autoSize = "right";
            field3.penguinName.autoSize = "right";
            field4.penguinName.autoSize = "right";
            field5.penguinName.autoSize = "right";
            field7.penguinName.autoSize = "right";
        }
        static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.PenguinStamps;
        static var LINKAGE_ID = "PenguinStamps";
    }
