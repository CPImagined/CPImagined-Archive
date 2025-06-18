//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.ui.quests.AutomatedQuestInterface
    {
        var _view, _interface, _shell, _currentParty, _closeButton, _puffleAdoptionList, _transformationList, _panelContainer;
        function AutomatedQuestInterface (skin, state) {
            _view = skin;
            _interface = _global.getCurrentInterface();
            _shell = _global.getCurrentShell();
            _currentParty = _global.getCurrentParty().BaseParty.CURRENT_PARTY;
            _closeButton = _view.closeButton;
            _closeButton.onRelease = com.clubpenguin.util.Delegate.create(this, closeInterface);
            _puffleAdoptionList = _currentParty.getPuffleAdoptionVOs();
            if (_puffleAdoptionList.length) {
                configurePuffleAdoption();
            }
            _transformationList = _currentParty.getTransformationVOs();
            if (_transformationList.length) {
                configureTransformation();
            }
            localizeText();
            configurePanels();
        }
        function localizeText() {
            _view.header_txt.text = _shell.getLocalizedString("w.app.generic.questui.header");
            _view.subheader1_txt.text = _shell.getLocalizedString("w.app.generic.questui.subheader1");
            _view.subheader2_txt.text = _shell.getLocalizedString("w.app.questui.subheader2");
        }
        function configurePuffleAdoption() {
            var _local_2 = 0;
            while (_local_2 < _puffleAdoptionList.length) {
                _view.adoptionContainer_mc["adopt_btn" + String(_local_2 + 1)].onRelease = com.clubpenguin.util.Delegate.create(this, requestAdoption, _local_2);
                _view.adoptionContainer_mc["adopt_btn_text" + String(_local_2 + 1)].text = _shell.getLocalizedString("w.puffleadoption.rainbow.adopt");
                _local_2++;
            }
        }
        function requestAdoption(index) {
            _currentParty.sendPuffleAdoption(_puffleAdoptionList[index].puffleId);
        }
        function configureTransformation() {
            var _local_2 = 0;
            while (_local_2 < _transformationList.length) {
                if (String(_transformationList[_local_2].gothere).length) {
                    _view.transformContainer_mc["transform_btn" + String(_local_2 + 1)].onRelease = com.clubpenguin.util.Delegate.create(this, joinRoom, _transformationList[_local_2].gothere);
                    _view.transformContainer_mc["transform_text" + String(_local_2 + 1)].text = _shell.getLocalizedString("w.pufflegoldquestprogress.button.gothere");
                } else {
                    _view.transformContainer_mc["transform_btn" + String(_local_2 + 1)].onRelease = com.clubpenguin.util.Delegate.create(this, requestTransformation, _local_2);
                    _view.transformContainer_mc["transform_text" + String(_local_2 + 1)].text = _shell.getLocalizedString("w.app.generic.transform");
                }
                _local_2++;
            }
        }
        function requestTransformation(index) {
            _currentParty.sendTransformation(_transformationList[index].transformId);
        }
        function joinRoom(roomName) {
            var _local_2 = _shell.getRoomNameById(_shell.getCurrentRoomId());
            if (roomName != _local_2) {
                _shell.sendJoinRoom(roomName);
            } else {
                _interface.closeContent();
            }
        }
        function configurePanels() {
            var _local_2 = getPanelState();
            _panelContainer = new com.clubpenguin.ui.quests.QuestInterfaceContainer(_view.panelView, getPanelState());
            _view.adopt_text.text = _shell.getLocalizedString("w.puffleadoption.rainbow.adopt");
            _view.adopt_btn.onRelease = com.clubpenguin.util.Delegate.create(this, openPanel, _currentParty.CONSTANTS.PUFFLE_ADOPTION_UI_PATH);
            _view.transform_text.text = _shell.getLocalizedString("w.app.generic.transform");
            _view.transform_btn.onRelease = com.clubpenguin.util.Delegate.create(this, openPanel, _currentParty.CONSTANTS.TRANSFORMATION_UI_PATH);
        }
        function getPanelState() {
            var _local_2 = _currentParty.CONSTANTS.PARTY_DAY;
            if (_local_2 == 0) {
                return(1);
            } else if ((_local_2 > 0) && (_local_2 <= 2)) {
                return(2);
            } else if ((_local_2 > 2) && (_local_2 <= 4)) {
                return(3);
            } else if ((_local_2 > 4) && (_local_2 <= 6)) {
                return(4);
            } else if ((_local_2 > 6) && (_local_2 <= 8)) {
                return(5);
            } else if ((_local_2 > 8) && (_local_2 <= 10)) {
                return(6);
            } else if ((_local_2 > 10) && (_local_2 <= 11)) {
                return(7);
            } else {
                return(0);
            }
        }
        function openPanel(content) {
            _interface.showContent(content);
        }
        function closeInterface() {
            _interface.closeContent();
        }
    }
