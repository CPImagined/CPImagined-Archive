//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.stampbook.controls.RecentlyEarnedRenderer extends com.clubpenguin.stamps.stampbook.controls.BaseItemRenderer
    {
        var _stampLookUp, _filePath, _shell, _data, _initialized, configUI, load;
        function RecentlyEarnedRenderer () {
            super();
            _stampLookUp = com.clubpenguin.stamps.stampbook.util.StampLookUp.getInstance();
            _filePath = _shell.getPath("stampbook_stamps");
        }
        function setModel(data) {
            _data = data;
            if (!_initialized) {
                configUI();
            }
            this.load();
        }
        static var CLASS_REF = com.clubpenguin.stamps.stampbook.controls.RecentlyEarnedRenderer;
        static var LINKAGE_ID = "RecentlyEarnedRenderer";
    }
