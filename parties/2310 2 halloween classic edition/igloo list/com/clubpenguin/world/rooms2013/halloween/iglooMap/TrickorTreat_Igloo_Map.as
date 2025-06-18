//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.halloween.iglooMap.TrickorTreat_Igloo_Map extends com.clubpenguin.util.collection.OperatorCollection
    {
        var _ui, iglooMapContext;
        function TrickorTreat_Igloo_Map (ui) {
            super();
            _ui = ui;
            var _local_5 = _global.getCurrentShell();
            var _local_7 = _global.getCurrentEngine();
            var _local_4 = _global.getCurrentInterface();
            var _local_6 = _global.getCurrentAirtower();
            _ui.help_btn.onRelease = com.clubpenguin.util.Delegate.create(this, handlePopup);
            init(_local_5, _local_4, _local_7, _local_6);
        }
        function handlePopup() {
            _ui.popupMC.gotoAndStop(2);
        }
        function init(SHELL, INTERFACE, ENGINE, AIRTOWER) {
            iglooMapContext = new com.clubpenguin.world.rooms2013.halloween.iglooMap.TrickorTreat_IglooMapContext(SHELL, INTERFACE, ENGINE, AIRTOWER, _ui, SHELL.getClientPath(), SHELL.getContentPath());
        }
        function destroy() {
            trace("[Igloo::igloo_map.as] destroying trick or treat igloo map context");
            iglooMapContext.destroy();
        }
    }
