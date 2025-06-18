//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.stampbook.controls.AbstractControl extends MovieClip
    {
        var _shell, _data;
        function AbstractControl () {
            super();
            com.clubpenguin.util.EventDispatcher.initialize(this);
            _shell = com.clubpenguin.stamps.stampbook.util.ShellLookUp.shell;
        }
        function onLoad() {
            configUI();
        }
        function setModel(data) {
            _data = data;
            if (_initialized) {
                populateUI();
            }
        }
        function configUI() {
            _initialized = true;
            if (_data != null) {
                populateUI();
            }
        }
        function populateUI() {
        }
        static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.AbstractControl;
        static var LINKAGE_ID = "AbstractControl";
        static var BLANK_CLIP_LINKAGE_ID = "Blank";
        var _initialized = false;
    }
