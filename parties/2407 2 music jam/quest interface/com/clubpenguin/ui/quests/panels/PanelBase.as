//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.ui.quests.panels.PanelBase extends MovieClip
    {
        var _view, _questVO, _shell, _currentParty;
        function PanelBase (view, vo) {
            super();
            _view = view;
            _questVO = vo;
            _shell = _global.getCurrentShell();
            _currentParty = _global.getCurrentParty().BaseParty.CURRENT_PARTY;
            localizeText();
            configurePanel();
        }
        function localizeText() {
            if (_questVO.unlockDay > _currentParty.CONSTANTS.PARTY_DAY) {
                _view.questdisplay.gotoAndStop(1);
                _view.questdisplay.panel_txt.text = _shell.getLocalizedString(_questVO.unlockTextToken);
            } else if ((_questVO.taskLockNumber >= 0) && (!_currentParty.partyCookie.hasPlayerCompletedTask(_questVO.taskLockNumber))) {
                _view.questdisplay.gotoAndStop(2);
                _view.questdisplay.panel_txt.text = _shell.getLocalizedString(_questVO.displayToken);
            } else {
                _view.questdisplay.gotoAndStop(3);
                _view.questdisplay.panel_txt.text = _shell.getLocalizedString(_questVO.completeToken);
            }
            if ((_view.questdisplay.panel_consistent_txt != undefined) && (_view.questdisplay.panel_consistent_txt != null)) {
                _view.questdisplay.panel_consistent_txt.text = _shell.getLocalizedString(_questVO.consistentToken);
            }
        }
        function configurePanel() {
            if (_questVO.gothere.length > 0) {
                _view.questdisplay.gothere_text.text = _shell.getLocalizedString("w.generic.button.findme");
                _view.questdisplay.gothere_btn.onRelease = com.clubpenguin.util.Delegate.create(this, goThereClickHanlder);
            }
        }
        function goThereClickHanlder() {
            var _local_3 = _global.getCurrentShell().getRoomNameById(_global.getCurrentShell().getCurrentRoomId());
            if (_local_3 == _questVO.gothere) {
                _global.getCurrentInterface().closeContent();
            } else {
                _global.getCurrentShell().sendJoinRoom(_questVO.gothere);
            }
        }
        static var CLASS = "PanelBase";
    }
