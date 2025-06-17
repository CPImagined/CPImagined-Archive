class com.clubpenguin.engine.puffles.uiwidget.PuffleUIWidgetController
{
    static var _SHELL;
    function PuffleUIWidgetController(shell)
    {
        _SHELL = shell;
    } // End of the function
    function displayPuffleWidget(puffleId, puffleBeingWalked, location, puffleType, widgetType, puffleItemId)
    {
        var _loc2 = new Object();
        _loc2.puffleId = puffleId;
        _loc2.puffleBeingWalked = puffleBeingWalked;
        _loc2.inMyIgloo = com.clubpenguin.engine.puffles.uiwidget.PuffleUIWidgetController._SHELL.isMyIgloo() && com.clubpenguin.engine.puffles.uiwidget.PuffleUIWidgetController._SHELL.getIsRoomIgloo();
        _loc2.inMyBackyard = _global.getCurrentEngine().isRoomMyBackyard();
        _loc2.puffleClipPosition = location;
        _loc2.widgetType = widgetType;
        _loc2.puffleItemId = puffleItemId;
        _loc2.puffleSubTypeId = String(com.clubpenguin.engine.puffles.uiwidget.PuffleUIWidgetController._SHELL.puffleManager.getMyPuffleById(puffleId).subTypeID);
        com.clubpenguin.util.Log.info("Opening AS3 module Puffle UI Widget: " + widgetType, com.clubpenguin.util.Log.DEFAULT);
        com.clubpenguin.engine.puffles.uiwidget.PuffleUIWidgetController._SHELL.sendOpenAS3Module(com.clubpenguin.modules.AS3ModuleConstants.PUFFLE_UI_WIDGET, _loc2, {modalBackgroundEnabled: false, hideLoadingDialog: true, blockPuffleNotifications: false});
    } // End of the function
    static var WIDGET_STATS_BAR = "statsBarWidget";
    static var WIDGET_RADIAL_MENU = "radialMenuWidget";
} // End of Class
