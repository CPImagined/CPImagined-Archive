//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.ScavengerHuntItem
    {
        var _itemId, _itemButton, _onFoundHandler, _alreadyFoundHandler, _INTERFACE;
        function ScavengerHuntItem (itemId, itemButton, onFoundHandler, alreadyFoundHandler) {
            _itemId = itemId;
            _itemButton = itemButton;
            _onFoundHandler = onFoundHandler;
            _alreadyFoundHandler = alreadyFoundHandler;
            _INTERFACE = _global.getCurrentInterface();
            init();
        }
        function destroy() {
            for (var _local_2 in this) {
                var _local_2 = null;
            }
        }
        function init() {
            if (_INTERFACE.scavengerHunt.isItemFound(_itemId)) {
                _alreadyFoundHandler();
            } else {
                _itemButton.onRelease = com.clubpenguin.util.Delegate.create(this, itemClicked);
            }
        }
        function itemClicked() {
            _INTERFACE.scavengerHunt.itemFound(_itemId);
            _onFoundHandler();
            _INTERFACE.showContent("scavenger_hunt");
        }
        static var CLASS_NAME = "ScavengerHuntItem";
    }
