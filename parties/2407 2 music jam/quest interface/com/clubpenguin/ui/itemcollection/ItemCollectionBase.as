//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.ui.itemcollection.ItemCollectionBase
    {
        var _shell, _currentParty, buyMultipleItemsButton, _vendingMachine;
        function ItemCollectionBase () {
            _shell = _global.getCurrentShell();
            _currentParty = _global.getCurrentParty().BaseParty.CURRENT_PARTY;
        }
        function createMultipleBuyButton(partyItemList, movieClip) {
            buyMultipleItemsButton = new com.clubpenguin.ui.itembuttons.BuyMultipleItemsButton(movieClip, true);
            var _local_6 = [];
            var _local_2 = 0;
            while (_local_2 < partyItemList.length) {
                if (!_shell.isItemInMyInventory(partyItemList[_local_2]._id)) {
                    var _local_4 = com.clubpenguin.ui.itembuttons.BuyButtonFactory.getBuyButton(partyItemList[_local_2], movieClip);
                    _local_4.prompt = false;
                    _local_4.purchaseSound = "sfx_collect";
                    _local_4.create();
                    buyMultipleItemsButton.add(_local_4);
                } else {
                    _local_6.push(_local_2);
                }
                _local_2++;
            }
            if (_local_6.length == partyItemList.length) {
                movieClip.gotoAndStop(2);
            }
            buyMultipleItemsButton.oopsMsgPath = _currentParty.CONSTANTS.OOPS_MEMBER_ITEM_MESSAGE;
            buyMultipleItemsButton.create();
        }
        function createBuyButton(partyItem, movieClip) {
            var _local_2 = com.clubpenguin.ui.itembuttons.BuyButtonFactory.getBuyButton(partyItem, movieClip);
            _local_2.prompt = false;
            _local_2.purchaseSound = "sfx_collect";
            _local_2.setIsEquipable(false);
            _local_2.create();
            _vendingMachine.add(_local_2);
        }
    }
