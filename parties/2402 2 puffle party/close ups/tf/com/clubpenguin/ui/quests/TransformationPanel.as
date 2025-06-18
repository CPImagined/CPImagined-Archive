//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.ui.quests.TransformationPanel
    {
        var _view, _interface, _currentParty, _transformationList;
        function TransformationPanel (skin) {
            _view = skin;
            _interface = _global.getCurrentInterface();
            _currentParty = _global.getCurrentParty().BaseParty.CURRENT_PARTY;
        }
        function init() {
            _view.header_text.text = _global.getCurrentShell().getLocalizedString("w.app.generic.transform.header");
            _view.closeButton.onRelease = com.clubpenguin.util.Delegate.create(this, closeThis);
            _view.back_btn.onRelease = com.clubpenguin.util.Delegate.create(this, openQuestUI);
            _transformationList = _currentParty.getTransformationVOs();
            var _local_3 = 0;
            while (_local_3 < _transformationList.length) {
                _view["transform_" + String(_local_3)].transform_btn.onRelease = com.clubpenguin.util.Delegate.create(this, requestTransformation, _local_3);
                _view["transform_" + String(_local_3)].name_text.text = _global.getCurrentShell().getLocalizedString(_transformationList[_local_3].transformName);
                _local_3++;
            }
        }
        function requestTransformation(index) {
            _currentParty.sendTransformation(_transformationList[index].transformId);
        }
        function openQuestUI() {
            _interface.showContent(_global.getCurrentParty().BaseParty.CURRENT_PARTY.CONSTANTS.QUEST_UI_PATH);
        }
        function closeThis() {
            _global.getCurrentInterface().closeContent();
        }
    }
