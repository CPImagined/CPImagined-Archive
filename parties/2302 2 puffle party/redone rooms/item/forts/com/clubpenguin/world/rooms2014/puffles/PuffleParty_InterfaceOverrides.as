//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.puffles.PuffleParty_InterfaceOverrides
    {
        function PuffleParty_InterfaceOverrides () {
        }
        function revertAvatar() {
            var _local_3 = this;
            _local_3.hideAvatarCardElements();
            _local_3.PLAYER_WIDGET.art_mc.close_btn.onRelease();
            _local_3.ENGINE.avatarManager.transformationManager.sendTransformPlayer(0);
            _global.getCurrentParty().PuffleParty.sendPuffleUnTransformBI();
        }
        function closeContent(biString) {
            var _local_2 = this;
            if (_local_2.SHELL.getRoomObject().room_id == 340) {
                trace("this is the stage room, don't close content");
                return(undefined);
            }
            trace("INTERFACE: closeContent() PARTY");
            if (_local_2.is_news_open) {
                trace("\tPARTY closed book in content.as. biString: " + biString);
                _local_2.is_news_open = false;
                _local_2.ENGINE.sendCloseBook(biString);
            }
            _local_2.checkCloseCatalog();
            _local_2.currentCatalog = null;
            _local_2.CONTENT.load_mc.removeMovieClip();
            _local_2.CONTENT.gotoAndStop(1);
            _local_2.SHELL.updateListeners(_local_2.SHELL.CONTENT_CLOSED);
            _local_2.startQuickKeys();
            if (_local_2.contentBlockPuffleNotifications) {
                _local_2.contentBlockPuffleNotifications = false;
                _local_2.SHELL.sendAS3StartNotificationServices();
            }
        }
    }
