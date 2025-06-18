//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.future.ui.MechPaintInterface
    {
        var _view, _INTERFACE, _SHELL, _ENGINE, _selectedMechID, _baseMechID, _selectedColorId;
        function MechPaintInterface (view) {
            _view = view;
            _INTERFACE = _global.getCurrentInterface();
            _SHELL = _global.getCurrentShell();
            _ENGINE = _global.getCurrentEngine();
        }
        function init() {
            trace("MechPaintInterface.init: " + com.clubpenguin.world.rooms2014.future.mech.MechController.isPlayerMech(_SHELL.getMyPlayerId()));
            if (com.clubpenguin.world.rooms2014.future.mech.MechController.isPlayerMech(_SHELL.getMyPlayerId())) {
                configureMech();
                configureButtons();
            } else {
                showPromptGetMech();
            }
        }
        function configureMech() {
            _selectedMechID = _SHELL.getPlayerObjectById(_SHELL.getMyPlayerId()).avatarVO.avatar_id;
            _baseMechID = com.clubpenguin.world.rooms2014.future.mech.MechController.getRobotType(_SHELL.getMyPlayerId());
            _view.promptGetMech._visible = false;
            hideAllMechs();
            _view["robo" + _baseMechID]._visible = true;
            trace("MechPaintInterface._baseMechID " + _baseMechID);
            var _local_2 = com.clubpenguin.world.rooms2014.future.FutureParty.partyCookie.getRoboPaint(_baseMechID);
            trace("MechPaintInterface.paintId " + _local_2);
            setColorAsSelected(_local_2);
            configurePaintButtons();
        }
        function setColorAsSelected(colorId) {
            var _local_2 = 0;
            while (_local_2 < 5) {
                _view["paint_" + _local_2].gotoAndStop("unselected");
                _local_2++;
            }
            _view["paint_" + colorId].gotoAndStop("selected");
            _view["robo" + _baseMechID].gotoAndStop(colorId + 1);
            _selectedColorId = colorId;
        }
        function hideAllMechs() {
            var _local_2 = 0;
            while (_local_2 < 3) {
                _view["robo" + _local_2]._visible = false;
                _view["robo" + _local_2].gotoAndStop(1);
                _local_2++;
            }
        }
        function configurePaintButtons() {
            var _local_2 = 0;
            while (_local_2 < 5) {
                _view["paint_" + _local_2].btn.onRelease = com.clubpenguin.util.Delegate.create(this, onClickColor, _local_2);
                _local_2++;
            }
        }
        function onClickColor(colorId) {
            trace("MechPainterINterface.onClickColor() colorId " + colorId);
            if (_baseMechID == com.clubpenguin.world.rooms2014.future.FutureParty.CONSTANTS.ROBO_TYPE_A) {
                _selectedMechID = com.clubpenguin.world.rooms2014.future.FutureParty.CONSTANTS.ROBO_A_IDS[colorId];
            }
            if (_baseMechID == com.clubpenguin.world.rooms2014.future.FutureParty.CONSTANTS.ROBO_TYPE_B) {
                _selectedMechID = com.clubpenguin.world.rooms2014.future.FutureParty.CONSTANTS.ROBO_B_IDS[colorId];
            }
            if (_baseMechID == com.clubpenguin.world.rooms2014.future.FutureParty.CONSTANTS.ROBO_TYPE_C) {
                _selectedMechID = com.clubpenguin.world.rooms2014.future.FutureParty.CONSTANTS.ROBO_C_IDS[colorId];
            }
            setColorAsSelected(colorId);
        }
        function configureButtons() {
            trace("MechPaintInterface.configureButtons");
            _view.btnPaint.onRelease = com.clubpenguin.util.Delegate.create(this, onPaintClicked);
            _view.btnClose.onRelease = com.clubpenguin.util.Delegate.create(this, closeUI);
        }
        function onPaintClicked() {
            function onPaintClicked_Delayed() {
                if (this._selectedMechID != undefined) {
                    com.clubpenguin.world.rooms2014.future.FutureParty.sendMechTransformation(this._selectedMechID);
                    com.clubpenguin.world.rooms2014.future.FutureParty.sendPaintCurrentRobo(this._baseMechID, this._selectedColorId);
                }
                this.closeInterface();
            }
            setTimeout(com.clubpenguin.util.Delegate.create(this, onPaintClicked_Delayed), 800);
            trace("MechPaintInterface.onPaintClicked() _selectedMechID " + _selectedMechID);
            trace("MechPaintInterface.onPaintClicked() _selectedColorId " + _selectedColorId);
        }
        function onTransformClicked() {
            com.clubpenguin.world.rooms2014.future.FutureParty.playSound(_view, "sfx_select");
            _view.transformUI.gotoAndStop("choose");
        }
        function showPromptGetMech() {
            trace("MechPaintInterface.showPromptGetMech");
            hideAllMechs();
            _view.promptGetMech._visible = true;
            _view.promptGetMech.btnPromptClose.onRelease = com.clubpenguin.util.Delegate.create(this, closeUI);
            _view.promptGetMech.btnPromptQuestUI.onRelease = com.clubpenguin.util.Delegate.create(this, showQuestUI);
        }
        function showQuestUI() {
            function showQuestUI_Delayed() {
                this._INTERFACE.showContent(com.clubpenguin.world.rooms2014.future.FutureParty.CONSTANTS.QUEST_UI_PATH);
            }
            trace("MechPaintInterface.showQuestUI");
            setTimeout(com.clubpenguin.util.Delegate.create(this, showQuestUI_Delayed), 800);
        }
        function closeUI() {
            trace("MechPaintInterface.closeUI");
            com.clubpenguin.world.rooms2014.future.FutureParty.playSound(_view, "sfx_close");
            setTimeout(com.clubpenguin.util.Delegate.create(this, closeInterface), 400);
        }
        function closeInterface() {
            _SHELL.startRoomMusic();
            _INTERFACE.closeContent();
        }
        function getBaseMech(mechID) {
            return(Math.floor(mechID / 5));
        }
    }
