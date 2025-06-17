//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.stampbook.views.BaseView extends MovieClip
    {
        var _shell, _model;
        function BaseView () {
            super();
            _shell = com.clubpenguin.stamps.stampbook.util.ShellLookUp.shell;
            com.clubpenguin.util.EventDispatcher.initialize(this);
        }
        function onLoad() {
            configUI();
        }
        function reset() {
        }
        function cleanUp() {
        }
        function setModel(_model) {
            this._model = _model;
            if (_initialized) {
                populateUI();
            }
        }
        function configUI() {
            _initialized = true;
            if (_model != null) {
                populateUI();
            }
        }
        function populateUI() {
        }
        static var CLASS_REF = com.clubpenguin.stamps.stampbook.views.BaseView;
        static var LINKAGE_ID = "BaseView";
        var _initialized = false;
    }
