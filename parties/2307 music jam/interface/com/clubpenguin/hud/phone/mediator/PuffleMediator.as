//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.hud.phone.mediator.PuffleMediator extends com.clubpenguin.hud.phone.mediator.AppMediator
    {
        var equipmentService, _puffleEquipped;
        function PuffleMediator (view, context) {
            super(view, context.appClosed, context.languageCode);
            equipmentService = context.equipmentService;
            _puffleEquipped = new org.osflash.signals.Signal();
            view.flare.onPress = com.clubpenguin.util.Delegate.create(this, equipPuffle);
        }
        function get puffleEquipped() {
            return(_puffleEquipped);
        }
        function equipPuffle() {
            equipmentService.equipHandItem(DEFAULT_FLARE_ID);
            _puffleEquipped.dispatch();
        }
        var DEFAULT_FLARE_ID = 5060;
    }
