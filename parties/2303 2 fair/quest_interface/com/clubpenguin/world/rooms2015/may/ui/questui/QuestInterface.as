//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.may.ui.questui.QuestInterface
    {
        var _view, _panelController, _closeButton, _rewardsPanel;
        function QuestInterface (skin) {
            trace("QuestInterface: Entering");
            _view = skin;
            _panelController = new com.clubpenguin.world.rooms2015.may.ui.questui.QuestInterface_Panel(_view.panel_container);
            _closeButton = _view.closeButton;
            configureRewardsPanel();
            _closeButton.onRelease = com.clubpenguin.util.Delegate.create(this, closeButton_Click_Handler);
            _global.getCurrentParty().BaseParty.sendOpenQuestBI();
        }
        function configureRewardsPanel() {
            _rewardsPanel = new com.clubpenguin.world.rooms2015.may.ui.questui.panels.QuestInterface_Panel_Rewards(_view);
        }
        function closeButton_Click_Handler() {
            trace("QuestInterface.closeButton_Click_Handler");
            _global.getCurrentParty().BaseParty.soundButton(_closeButton, "sfx_close", com.clubpenguin.util.Delegate.create(this, closeInterface), 500);
        }
        function closeInterface() {
            _rewardsPanel.clean();
            _global.getCurrentInterface().closeContent();
        }
    }
