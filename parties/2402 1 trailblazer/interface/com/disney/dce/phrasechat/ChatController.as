//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.disney.dce.phrasechat.ChatController extends MovieClip
    {
        var sendMessage, __shell, __mainTimeline, __interfaceMC, __dock, __chat, __inputChat, __btnRemove, __btnSend;
        function ChatController (sm, s, mc, mt) {
            super();
            sendMessage = sm;
            __shell = s;
            __mainTimeline = mt;
            __interfaceMC = mc;
            __dock = __interfaceMC.dock_mc;
            __chat = __dock.chat_mc;
            __inputChat = __chat.chat_input;
            __btnRemove = __dock.btnRemove;
            __btnRemove._visible = false;
            __btnSend = __chat.send_btn;
            __btnSend.onRelease = mx.utils.Delegate.create(this, onSend);
        }
        function updateDockUIReferences() {
            __chat = __dock.chat_mc;
            __inputChat = __chat.chat_input;
            __btnRemove = __dock.btnRemove;
            __btnRemove._visible = false;
            __btnSend = __chat.send_btn;
            __btnSend.onRelease = mx.utils.Delegate.create(this, onSend);
        }
        function handleKeyDown(keyCode) {
            if (keyCode == 13) {
                sendPhrase();
            }
        }
        function handleInputUpdate() {
        }
        function handleFocus() {
        }
        function handleBlur() {
        }
        function resetChatInput() {
            __inputChat.text = "";
            setInputChatFocus();
        }
        function setInputChatFocus() {
            Selection.setFocus(__inputChat);
            Selection.setSelection(__inputChat.text.length, __inputChat.text.length);
        }
        function sendPhrase(queued) {
            if (__inputChat.text.length > 0) {
                sendMessage(__inputChat.text);
            }
            resetChatInput();
        }
        function onSend() {
            sendPhrase(false);
            __mainTimeline.closeHint();
        }
        function log(str) {
        }
    }
