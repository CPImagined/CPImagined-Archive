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
            configureQuestUiButtons();
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
        }
        function configureQuestUiButtons() {
            var _local_4 = _currentParty.CONSTANTS.PARTY_FEATURES.featureSettings.questUiButtonsList;
            var _local_3 = 0;
            while (_local_3 < _local_4.length) {
                var _local_2 = _local_4[_local_3];
                _view[_local_2.name.split("_")[0] + "_text"].text = _shell.getLocalizedString(_local_2.labelToken);
                _view[_local_2.name].onRelease = handleQuestUiButtonClick(_local_2.type, _local_2.params);
                _local_3++;
            }
        }
        function handleQuestUiButtonClick(action, params) {
            switch (action) {
                case "catalog" : 
                    return(com.clubpenguin.util.Delegate.create(this, _currentParty.openPigfarmCatalog, params));
                case "adopt" : 
                    return(com.clubpenguin.util.Delegate.create(this, _currentParty.sendPuffleAdoption, params));
                case "goto" : 
                    return(com.clubpenguin.util.Delegate.create(this, _shell.sendJoinRoom, params));
            }
            return(undefined);
        }
        function getPanelState() {
            var _local_2 = _currentParty.CONSTANTS.PARTY_DAY;
            return(1);
        }
        function openPanel(content) {
            _interface.showContent(content);
        }
        function closeInterface() {
            _interface.closeContent();
        }
    }
