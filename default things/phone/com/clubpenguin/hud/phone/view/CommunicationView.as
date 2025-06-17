//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.hud.phone.view.CommunicationView extends com.clubpenguin.hud.phone.view.AppView
    {
        var viewOpened, attachedMessages, localizedAssets, shell, title, _visible, messageList;
        function CommunicationView () {
            super();
            viewOpened = new org.osflash.signals.Signal();
            attachedMessages = [];
            localizedAssets = [];
        }
        function setDependancies(shell) {
            this.shell = shell;
            title.tf.text = shell.getLocalizedString("communication").toUpperCase();
        }
        function open() {
            viewOpened.dispatch();
            _visible = true;
        }
        function close() {
            clearMessages();
            _visible = false;
        }
        function clearMessages() {
            removeAttachedMessages();
        }
        function displayMessages(comMessages) {
            var _local_4 = 0;
            var _local_3 = 0;
            while (_local_3 < comMessages.length) {
                var _local_2 = messageList.content.attachMovie(com.clubpenguin.hud.phone.view.ComMessageView.LINKAGE_ID, "ComMessageView_" + _local_3, messageList.content.getNextHighestDepth());
                attachedMessages.push(_local_2);
                _local_2.setDependancies(shell);
                _local_2.displayMessage(comMessages[_local_3]);
                _local_2._y = _local_4 + com.clubpenguin.hud.phone.view.ComMessageView.DIVIDER_PADDING;
                _local_4 = _local_4 + (_local_2._height + com.clubpenguin.hud.phone.view.ComMessageView.DIVIDER_PADDING);
                _local_3++;
            }
            attachedMessages[attachedMessages.length - 1].hideDivider();
        }
        function removeAttachedMessages() {
            var _local_2 = 0;
            while (_local_2 < attachedMessages.length) {
                attachedMessages[_local_2].removeMovieClip();
                _local_2++;
            }
            attachedMessages = [];
        }
    }
