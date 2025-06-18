//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.prehistoric.ui.dialogues.Character_Dialogue_Gary_Login extends com.clubpenguin.world.rooms2014.common.Character_Dialogue_Base
    {
        var dialogueScript, _SHELL, init, _dialogue, nextDialogueScreen, previousDialogueScreen, _ui, _INTERFACE;
        function Character_Dialogue_Gary_Login (ui) {
            super(ui);
            dialogueScript.push(_SHELL.getLocalizedString(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.CONSTANTS.CHARACTER_DIALOGUE_GARY_LOGIN_1));
            dialogueScript.push(_SHELL.getLocalizedString(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.CONSTANTS.CHARACTER_DIALOGUE_GARY_LOGIN_2));
            init();
        }
        function configureDialogueButtons() {
            _dialogue.cp_button_label.text = _SHELL.getLocalizedString(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.CONSTANTS.CHARACTER_DIALOGUE_TO_CP);
            _dialogue.backInTime_button_label.text = _SHELL.getLocalizedString(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.CONSTANTS.CHARACTER_DIALOGUE_BACK_IN_TIME);
            _dialogue.body_text.text = dialogueScript[_dialogue._currentframe - 1];
            _dialogue.next_Btn.onRelease = com.clubpenguin.util.Delegate.create(this, nextDialogueScreen);
            _dialogue.prev_Btn.onRelease = com.clubpenguin.util.Delegate.create(this, previousDialogueScreen);
            _dialogue.cp_Btn.onRelease = com.clubpenguin.util.Delegate.create(this, closeContent);
            _dialogue.prehistoric_Btn.onRelease = com.clubpenguin.util.Delegate.create(this, handleBackInTime);
        }
        function handleBackInTime() {
            com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.sendMessageViewed(LOGIN_MESSAGE_NUMBER);
            com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.playSound(_ui, SFX_TIME_WARP);
            setTimeout(com.clubpenguin.util.Delegate.create(this, timeWarpCloseInterface), 800);
        }
        function timeWarpCloseInterface() {
            com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.sendSpawnInPrehistoricRoom();
            _INTERFACE.closeContent();
        }
        function closeContent() {
            com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.sendMessageViewed(LOGIN_MESSAGE_NUMBER);
            _INTERFACE.closeContent();
        }
        static var LOGIN_MESSAGE_NUMBER = 0;
        static var SFX_TIME_WARP = "sfx_time_warp";
    }
