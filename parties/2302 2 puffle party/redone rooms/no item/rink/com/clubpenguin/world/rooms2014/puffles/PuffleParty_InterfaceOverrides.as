//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.puffles.PuffleParty_InterfaceOverrides
    {
        function PuffleParty_InterfaceOverrides () {
        }
        function revertAvatar() {
            var _local_3 = this;
            _local_3.hideAvatarCardElements();
            _local_3.PLAYER_WIDGET.art_mc.close_btn.onRelease();
            _local_3.disableSpecialDance();
            _local_3.disableSpecialWave();
            _local_3.ENGINE.avatarManager.transformationManager.sendTransformPlayer(0);
            _global.getCurrentParty().PuffleParty.sendPuffleUnTransformBI();
        }
        function closeContent(biString) {
            var _local_3 = this;
            var _local_4 = _global.getCurrentParty().PuffleParty;
            if ((_local_3.SHELL.getRoomObject().room_id == 340) && (_local_4.CONSTANTS.PARTY_DAY < _local_4.CONSTANTS.GALA_UNLOCKED_DAY)) {
                return(undefined);
            }
            if (_local_3.is_news_open) {
                _local_3.is_news_open = false;
                _local_3.ENGINE.sendCloseBook(biString);
            }
            _local_3.checkCloseCatalog();
            _local_3.currentCatalog = null;
            _local_3.CONTENT.load_mc.removeMovieClip();
            _local_3.CONTENT.gotoAndStop(1);
            _local_3.SHELL.updateListeners(_local_3.SHELL.CONTENT_CLOSED);
            _local_3.startQuickKeys();
            if (_local_3.contentBlockPuffleNotifications) {
                _local_3.contentBlockPuffleNotifications = false;
                _local_3.SHELL.sendAS3StartNotificationServices();
            }
        }
    }
