//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.stampbook.controls.ColourToolRenderer extends com.clubpenguin.stamps.stampbook.controls.AbstractControl
    {
        var dispatchEvent;
        function ColourToolRenderer () {
            super();
        }
        function onPress() {
            dispatchEvent({type:"press"});
        }
        static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.ColourToolRenderer;
        static var LINKAGE_ID = "ColourToolRenderer";
    }
