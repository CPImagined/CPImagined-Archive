//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.epfparty.ui.dialogues.Character_Dialogue_Base extends MovieClip
    {
        var _INTERFACE, _SHELL, _ENGINE, _ui, getNextHighestDepth, _dialogue;
        function Character_Dialogue_Base (ui) {
            super();
            _INTERFACE = _global.getCurrentInterface();
            _SHELL = _global.getCurrentShell();
            _ENGINE = _global.getCurrentEngine();
            _ui = ui;
            _ui.gotoAndStop(1);
            _ui.attachMovie("Dialogue", "dialogue", getNextHighestDepth());
            _dialogue = _ui.dialogue;
            _dialogue.gotoAndStop(1);
            dialogueScript = new Array();
        }
        function init() {
            configureDialogueButtons();
        }
        function configureDialogueButtons() {
            _dialogue.ok_button_label.text = _SHELL.getLocalizedString(com.clubpenguin.world.rooms2013.epfparty.EPFPartyConstants.CHARACTER_DIALOGUE_OK);
            _dialogue.body_text.text = dialogueScript[_dialogue._currentframe - 1];
            _dialogue.ok_Btn.onRelease = com.clubpenguin.util.Delegate.create(this, closeDialogue);
            _dialogue.next_Btn.onRelease = com.clubpenguin.util.Delegate.create(this, nextDialogueScreen);
            _dialogue.prev_Btn.onRelease = com.clubpenguin.util.Delegate.create(this, previousDialogueScreen);
        }
        function closeDialogue() {
            _INTERFACE.closeContent();
        }
        function nextDialogueScreen() {
            if (_dialogue._currentframe < _dialogue._totalframes) {
                _dialogue.nextFrame();
            }
            configureDialogueButtons();
        }
        function previousDialogueScreen() {
            if (_dialogue._currentframe > 1) {
                _dialogue.prevFrame();
            }
            configureDialogueButtons();
        }
        var dialogueScript = new Array();
    }
