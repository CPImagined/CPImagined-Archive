//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.future.ui.components.FuturePartyItem
    {
        var _shell, _interface, _engine, _view, _callback, _itemButton;
        function FuturePartyItem (view, itemButtonName, partyItemVO, callback) {
            _shell = _global.getCurrentShell();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _view = view;
            _callback = callback;
            setupButton(_view[itemButtonName], partyItemVO);
            _view.onUnload = com.clubpenguin.util.Delegate.create(this, destroy);
        }
        function setupButton(itemButton, partyItemVO) {
            _itemButton = new com.clubpenguin.ui.itembuttons.BuyPaperItemButton(partyItemVO, itemButton, false, null, _callback, null, com.clubpenguin.world.rooms2014.future.FutureParty.CONSTANTS.OOPS_MEMBER_ITEM_MESSAGE, "sfx_collect");
            _itemButton.create();
        }
        function destroy() {
            _itemButton.destroy();
        }
    }
