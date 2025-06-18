//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.puffles.uiwidget.PuffleUIWidgetController
    {
        static var _SHELL;
        function PuffleUIWidgetController (shell) {
            _SHELL = shell;
        }
        function displayPuffleWidget(puffleId, puffleBeingWalked, location, puffleType, widgetType, puffleItemId) {
            var _local_2 = new Object();
            _local_2.puffleId = puffleId;
            _local_2.puffleBeingWalked = puffleBeingWalked;
            _local_2.inMyIgloo = _SHELL.isMyIgloo() && (_SHELL.getIsRoomIgloo());
            _local_2.inMyBackyard = _global.getCurrentEngine().isRoomMyBackyard();
            _local_2.puffleClipPosition = location;
            _local_2.widgetType = widgetType;
            _local_2.puffleItemId = puffleItemId;
            _local_2.puffleSubTypeId = String(_SHELL.puffleManager.getMyPuffleById(puffleId).subTypeID);
            com.clubpenguin.util.Log.info("Opening AS3 module Puffle UI Widget: " + widgetType, com.clubpenguin.util.Log.DEFAULT);
            _SHELL.sendOpenAS3Module(com.clubpenguin.modules.AS3ModuleConstants.PUFFLE_UI_WIDGET, _local_2, {modalBackgroundEnabled:false, hideLoadingDialog:true, blockPuffleNotifications:false});
        }
        static var WIDGET_STATS_BAR = "statsBarWidget";
        static var WIDGET_RADIAL_MENU = "radialMenuWidget";
    }
