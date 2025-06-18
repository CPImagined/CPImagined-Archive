//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.may.ui.dialogues.Character_Dialogue_Fair_Login extends com.clubpenguin.world.rooms2013.epfparty.ui.dialogues.Character_Dialogue_Base
    {
        var dialogueScript, _SHELL, init, _dialogue, _INTERFACE;
        function Character_Dialogue_Fair_Login (ui) {
            super(ui);
            trace("LOGIN PROMPT");
            dialogueScript.push(_SHELL.getLocalizedString(com.clubpenguin.world.rooms2015.may.party.MayParty.CONSTANTS.CHARACTER_DIALOGUE_ROOKIE_LOGIN));
            init();
        }
        function closeDialogue() {
            if (com.clubpenguin.world.rooms2015.may.party.MayParty.partyCookie.msgViewedArray[0] == 1) {
                closeContent();
            } else {
                com.clubpenguin.world.rooms2015.may.party.MayParty.sendMessageViewed(com.clubpenguin.world.rooms2015.may.party.MayParty.CONSTANTS.LOGIN_MESSAGE_NUMBER);
            }
            _dialogue.ok_Btn.onRelease = null;
            var _local_2 = com.clubpenguin.util.Delegate.create(this, closeContent);
            var _local_3 = new com.clubpenguin.world.rooms2013.common.CallbackAnimation(_dialogue.partyIcon, _local_2);
        }
        function closeContent() {
            _global.getCurrentParty().BaseParty.showPartyIcon();
            _INTERFACE.closeContent();
        }
    }
