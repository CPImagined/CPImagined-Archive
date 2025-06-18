//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.ui.quests.panels.PanelQuestProgression extends com.clubpenguin.ui.quests.panels.PanelBase implements com.clubpenguin.ui.quests.panels.IPanel
    {
        var _questVO, _currentParty, _view, _shell;
        function PanelQuestProgression (view, vo) {
            super(view, vo);
            configureQuestPanel();
        }
        function configureQuestPanel() {
            var _local_3 = _questVO.panelData.progressTaskIds;
            var _local_4 = [];
            var _local_5 = Boolean(_local_3.length > 0);
            var _local_6 = _questVO.unlockDay > _currentParty.CONSTANTS.PARTY_DAY;
            var _local_2 = 0;
            while (_local_2 < _local_3.length) {
                _local_4[_local_2] = _currentParty.partyCookie.hasPlayerCompletedTask(_local_3[_local_2]);
                _local_5 = _local_5 && (_local_4[_local_2]);
                _local_2++;
            }
            if (_local_6) {
                _view.questdisplay.gotoAndStop(1);
                _view.questdisplay.panel_txt.text = _shell.getLocalizedString(_questVO.unlockTextToken);
            } else if (!_local_5) {
                _view.questdisplay.gotoAndStop(2);
                _view.questdisplay.panel_txt.text = _shell.getLocalizedString(_questVO.displayToken);
                if ((_view.questdisplay.gothere_text != undefined) && (_view.questdisplay.gothere_text != null)) {
                    _view.questdisplay.gothere_text.text = _shell.getLocalizedString("w.generic.button.findme");
                }
            } else {
                _view.questdisplay.gotoAndStop(3);
                _view.questdisplay.panel_txt.text = _shell.getLocalizedString(_questVO.completeToken);
                if ((_view.questdisplay.gothere_text != undefined) && (_view.questdisplay.gothere_text != null)) {
                    _view.questdisplay.gothere_text.text = _shell.getLocalizedString("w.generic.button.findme");
                }
                configureItemCollection();
            }
            if ((_view.questdisplay.panel_consistent_txt != undefined) && (_view.questdisplay.panel_consistent_txt != null)) {
                _view.questdisplay.panel_consistent_txt.text = _shell.getLocalizedString(_questVO.consistentToken);
            }
            if (!_local_6) {
                configureTaskCompleteCheckmarks(_local_4);
            }
        }
        function configureTaskCompleteCheckmarks(completedTasks) {
            var _local_4 = _questVO.panelData.progressTaskIds;
            var _local_7 = Boolean(_local_4.length > 0);
            var _local_6 = _questVO.unlockDay > _currentParty.CONSTANTS.PARTY_DAY;
            var _local_2 = 0;
            while (_local_2 < _local_4.length) {
                var _local_3 = 1;
                if (completedTasks[_local_2]) {
                    _local_3 = 2;
                }
                _view.questdisplay["task" + _local_2].gotoAndStop(_local_3);
                _local_2++;
            }
        }
        function configureItemCollection() {
            var _local_5 = new com.clubpenguin.ui.itemcollection.ItemCollectionBase();
            var _local_4 = _questVO.memberItemVOs;
            var _local_2 = 0;
            while (_local_2 < _local_4.length) {
                _view.questdisplay["member_" + String(_local_2)].gotoAndStop(2);
                _local_5.createBuyButton(_local_4[_local_2], _view.questdisplay["member_" + String(_local_2)].collect_btn);
                _local_2++;
            }
            var _local_3 = _questVO.nonMemberItemVOs;
            _local_2 = 0;
            while (_local_2 < _local_3.length) {
                _view.questdisplay["non_member_" + String(_local_2)].gotoAndStop(2);
                _local_5.createBuyButton(_local_3[_local_2], _view.questdisplay["non_member_" + String(_local_2)].collect_btn);
                _local_2++;
            }
        }
        function getVO() {
            return(_questVO);
        }
        static var CLASS = "PanelQuestProgression";
    }
