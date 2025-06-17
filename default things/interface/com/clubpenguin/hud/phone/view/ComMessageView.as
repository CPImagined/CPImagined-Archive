//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.hud.phone.view.ComMessageView extends MovieClip
    {
        var message_txt, shell, avatar, sender_txt, date_txt, divider;
        function ComMessageView () {
            super();
            message_txt.autoSize = true;
        }
        function setDependancies(shell) {
            this.shell = shell;
        }
        function displayMessage(comMessage) {
            avatar.gotoAndStop("id_" + comMessage.mascotID);
            sender_txt.text = comMessage.mascotName;
            date_txt.text = (shell.getLocalizedString(com.clubpenguin.util.DateUtils.getMonthLangKey(comMessage["date"].getMonth())) + " ") + comMessage["date"].getDate();
            message_txt.text = comMessage.message;
            while (comMessage.message.indexOf("\\u0025") != -1) {
                comMessage.message = com.clubpenguin.util.StringUtils.replaceString("\\u0025", "%", comMessage.message);
            }
            divider._y = (message_txt._y + message_txt._height) + DIVIDER_PADDING;
        }
        function hideDivider() {
            divider._visible = false;
        }
        static var LINKAGE_ID = "com.clubpenguin.hud.phone.view.ComMessageView";
        static var DIVIDER_PADDING = 6;
    }
