//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.pirate.ui.questui.QuestInterface
    {
        var _view, _panelController, _closeButton;
        function QuestInterface (skin) {
            trace("QuestInterface: Entering");
            _view = skin;
            _panelController = new com.clubpenguin.world.rooms2014.pirate.ui.questui.QuestInterface_Panel(skin.panelView);
            configurePirateProgressionPanel();
            _closeButton = _view.closeButton;
            _closeButton.onRelease = com.clubpenguin.util.Delegate.create(this, closeButton_Click_Handler);
            _global.getCurrentParty().BaseParty.sendOpenQuestBI();
        }
        function configurePirateProgressionPanel() {
            var _local_2 = new com.clubpenguin.world.rooms2014.pirate.ui.questui.panels.QuestInterface_Panel_PirateProgression(_view.pirateProgressionView);
        }
        function closeButton_Click_Handler() {
            trace("QuestInterface.closeButton_Click_Handler");
            _global.getCurrentParty().BaseParty.soundButton(_closeButton, "sfx_close", com.clubpenguin.util.Delegate.create(this, closeInterface), 500);
        }
        function closeInterface() {
            if (_global.getCurrentShell().getRoomObject().room_id == com.clubpenguin.world.rooms2014.pirate.party.PirateParty.CONSTANTS.CRAB_BATTLE_ROOM_ID) {
                _global.getCurrentShell().sendJoinLastRoom();
            } else {
                _global.getCurrentInterface().closeContent();
            }
        }
    }
