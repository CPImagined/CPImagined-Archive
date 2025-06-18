//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.ui.PuffleAdoptChooseColor
    {
        static var _stage;
        var _INTERFACE, _SHELL;
        function PuffleAdoptChooseColor (stageReference) {
            _stage = stageReference;
            _INTERFACE = _global.getCurrentInterface();
            _SHELL = _global.getCurrentShell();
            stageReference.closeButton.onRelease = com.clubpenguin.util.Delegate.create(this, closeUI);
            stageReference.choose_text.text = _SHELL.getLocalizedString("adoptpuffle.choose_text");
            for (var _local_6 in stageReference) {
                var _local_5;
                var _local_4;
                if (stageReference[_local_6]._name != undefined) {
                    if (stageReference[_local_6]._name.indexOf(NON_MEMBER_PUFFLE_BTN_INSTANCE_NAME_PREFIX) != -1) {
                        _local_5 = false;
                        _local_4 = stageReference[_local_6]._name.substr(NON_MEMBER_PUFFLE_BTN_INSTANCE_NAME_PREFIX.length);
                    } else if (stageReference[_local_6]._name.indexOf(MEMBER_PUFFLE_BTN_INSTANCE_NAME_PREFIX) != -1) {
                        _local_5 = true;
                        _local_4 = stageReference[_local_6]._name.substr(MEMBER_PUFFLE_BTN_INSTANCE_NAME_PREFIX.length);
                    }
                    if ((_local_4 != undefined) && (_local_5 != undefined)) {
                        stageReference[_local_6].onRelease = com.clubpenguin.util.Delegate.create(this, adoptPuffleHandler, _local_4, _local_5);
                    }
                }
            }
        }
        function closeUI() {
            _INTERFACE.closeContent();
        }
        function adoptPuffleHandler(puffleId, isMemberOnly) {
            if (((!_SHELL.isMyPlayerMember()) && (_global.getCurrentParty().BaseParty.CURRENT_PARTY.CONSTANTS.MAX_PUFFLES_NON_MEMBER != undefined)) && (_SHELL.puffleManager.myPuffles.length >= _global.getCurrentParty().BaseParty.CURRENT_PARTY.CONSTANTS.MAX_PUFFLES_NON_MEMBER)) {
                _SHELL.$e("PUFFLE ADOPTION --> Max Puffles Reached for Non-Member Penguin", {error_code:_SHELL.MAX_PUFFLE_LIMIT});
                return(undefined);
            }
            if (_SHELL.puffleManager.myPuffles.length >= com.clubpenguin.shell.PuffleManager.MAX_PUFFLES) {
                _SHELL.$e("PuffleAdoptChooseColor -> Max Puffles Reached", {error_code:_SHELL.MAX_PUFFLE_LIMIT});
                return(undefined);
            }
            if (isMemberOnly && (!_SHELL.isMyPlayerMember())) {
                _INTERFACE.showContent(_global.getCurrentParty().BaseParty.CURRENT_PARTY.CONSTANTS.PUFFLE_ADOPT_OOPS_MESSAGE);
            } else {
                _INTERFACE.showContent(com.clubpenguin.modules.AS3ModuleConstants.PUFFLE_ADOPTION, null, null, {puffleAdoptionType:puffleId}, true);
            }
        }
        static var MEMBER_PUFFLE_BTN_INSTANCE_NAME_PREFIX = "btnPuffle";
        static var NON_MEMBER_PUFFLE_BTN_INSTANCE_NAME_PREFIX = "btnNonMemberPuffle";
    }
