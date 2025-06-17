//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.AgentLobby extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, localize, setupNavigationButtons, _isEPFAgent, _ENGINE, _INTERFACE, _recruitmentDialogDelgate, _destroyDelegate, _now, _currentSecond, _currentMinute, _currentHour, _emptyClip;
        function AgentLobby (stageReference) {
            super(stageReference);
            _stage.start_x = 380;
            _stage.start_y = 305;
            if (!_SHELL) {
                init();
            }
            localize([_stage.background_mc.phone_mc.booth_mc, _stage.background_mc.secretDoor02_mc.badge_mc]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chairReception01_btn, 302, 190), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chairReception02_btn, 383, 198), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chairClient01_btn, 556, 252), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chairClient02_btn, 577, 296), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chairBoss_btn, 688, 240), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chairWorker01_btn, 335, 358), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chairWorker02_btn, 377, 386), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chairWorker03_btn, 431, 360), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chairWorker04_btn, 560, 380), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chairWorker05_btn, 603, 361), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.stairs_mc.exitVillage_btn, 80, 230)]);
            _stage.chairReception01_btn.useHandCursor = false;
            _stage.chairReception02_btn.useHandCursor = false;
            _stage.chairClient01_btn.useHandCursor = false;
            _stage.chairClient02_btn.useHandCursor = false;
            _stage.chairBoss_btn.useHandCursor = false;
            _stage.chairWorker01_btn.useHandCursor = false;
            _stage.chairWorker02_btn.useHandCursor = false;
            _stage.chairWorker03_btn.useHandCursor = false;
            _stage.chairWorker04_btn.useHandCursor = false;
            _stage.chairWorker05_btn.useHandCursor = false;
            _stage.foreground_mc.tv_mc.tv_btn.useHandCursor = false;
            _stage.background_mc.secretDoor01_mc.secretDoor_btn.useHandCursor = false;
            _stage.foreground_mc.tv_mc.tv_btn.onRelease = com.clubpenguin.util.Delegate.create(this, tvNextChannel);
            _stage.stairs_mc.exitVillage_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, villageDoorRollOver);
            _stage.stairs_mc.exitVillage_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, villageDoorRollOut);
            _stage.stairs_mc.exitVillage_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, villageDoorRollOut);
            _stage.background_mc.secretDoor01_mc.secretDoor_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, secretDoorRollOver);
            _stage.background_mc.secretDoor01_mc.secretDoor_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, secretDoorRollOut);
            _stage.background_mc.secretDoor01_mc.secretDoor_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, secretDoorRollOut);
            _stage.background_mc.secretDoor01_mc.secretDoor_btn.onRelease = com.clubpenguin.util.Delegate.create(this, secretDoorRelease);
            _stage.background_mc.phone_mc.phone_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, phoneRollOver);
            _stage.background_mc.phone_mc.phone_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, phoneRollOut);
            _stage.background_mc.phone_mc.phone_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, phoneRollOut);
            _stage.background_mc.phone_mc.phone_btn.onRelease = com.clubpenguin.util.Delegate.create(this, phoneRelease);
            _stage.triggers_mc.village_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party25", 570, 305);
            _stage.triggers_mc.agentCommand_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, enterCommandRoom);
            _stage.triggers_mc.becomeAgent_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, showRecruitmentDialog);
        }
        function tvNextChannel() {
            _stage.foreground_mc.tv_mc.tvChannel_mc.nextFrame();
            _stage.foreground_mc.tv_mc.tvStatic_mc.gotoAndPlay("staticAnimation");
        }
        function villageDoorRollOver() {
            var _local_2 = new Sound(_stage);
            _local_2.attachSound("sfxSideDoorOpen");
            _local_2.start();
        }
        function villageDoorRollOut() {
            var _local_2 = new Sound(_stage);
            _local_2.attachSound("sfxSideDoorClose");
            _local_2.start();
        }
        function secretDoorRollOver() {
            if (_isEPFAgent) {
                if (_stage.background_mc.secretDoor01_mc._currentframe == 1) {
                    _stage.background_mc.secretDoor01_mc.gotoAndPlay("secretOpening");
                    _stage.background_mc.secretDoor02_mc.gotoAndPlay("secretOpening");
                } else if ((_stage.background_mc.secretDoor01_mc._currentframe > 1) && (_stage.background_mc.secretDoor01_mc._currentframe <= 75)) {
                } else if ((_stage.background_mc.secretDoor01_mc._currentframe >= 76) && (_stage.background_mc.secretDoor01_mc._currentframe <= 163)) {
                    _stage.background_mc.secretDoor01_mc.gotoAndStop("secretOpenStop");
                    _stage.background_mc.secretDoor02_mc.gotoAndStop("secretOpenStop");
                } else if ((_stage.background_mc.secretDoor01_mc._currentframe >= 164) && (_stage.background_mc.secretDoor01_mc._currentframe <= 177)) {
                    _stage.background_mc.secretDoor01_mc.gotoAndPlay("secretOpenBush");
                    _stage.background_mc.secretDoor02_mc.gotoAndPlay("secretOpenBush");
                } else if ((_stage.background_mc.secretDoor01_mc._currentframe >= 178) && (_stage.background_mc.secretDoor01_mc._currentframe <= 210)) {
                    _stage.background_mc.secretDoor01_mc.gotoAndPlay("secretOpenBadge");
                    _stage.background_mc.secretDoor02_mc.gotoAndPlay("secretOpenBadge");
                } else if ((_stage.background_mc.secretDoor01_mc._currentframe >= 211) && (_stage.background_mc.secretDoor01_mc._currentframe <= 285)) {
                }
                _stage.background_mc.secretDoor02_mc.secretRollOver_mc.gotoAndStop("rollOver");
            }
        }
        function secretDoorRollOut() {
            if (_isEPFAgent) {
                if ((_stage.background_mc.secretDoor01_mc._currentframe >= 75) && (_stage.background_mc.secretDoor01_mc._currentframe <= 210)) {
                    _stage.background_mc.secretDoor01_mc.gotoAndPlay("secretClosingSoon");
                    _stage.background_mc.secretDoor02_mc.gotoAndPlay("secretClosingSoon");
                } else if ((_stage.background_mc.secretDoor01_mc._currentframe >= 211) && (_stage.background_mc.secretDoor01_mc._currentframe <= 285)) {
                }
                _stage.background_mc.secretDoor02_mc.secretRollOver_mc.gotoAndStop("rollOut");
            }
        }
        function secretDoorRelease() {
            if (_isEPFAgent) {
                _ENGINE.sendPlayerMove(380, 170);
            } else if (!_isEPFAgent) {
                _ENGINE.sendPlayerMove(_xmouse, _ymouse);
            }
        }
        function phoneRollOver() {
            if (!_isEPFAgent) {
                if ((_stage.background_mc.phoneScreen_mc.phoneScreenAni_mc._currentframe > 1) && (_stage.background_mc.phoneScreen_mc.phoneScreenAni_mc._currentframe <= 45)) {
                } else if ((_stage.background_mc.phoneScreen_mc.phoneScreenAni_mc._currentframe >= 46) && (_stage.background_mc.phoneScreen_mc.phoneScreenAni_mc._currentframe <= 120)) {
                    _stage.background_mc.phoneScreen_mc.phoneScreenAni_mc.gotoAndStop("screenOpenStop");
                } else if ((_stage.background_mc.phoneScreen_mc.phoneScreenAni_mc._currentframe >= 121) && (_stage.background_mc.phoneScreen_mc.phoneScreenAni_mc._currentframe <= 131)) {
                    _stage.background_mc.phoneScreen_mc.phoneScreenAni_mc.gotoAndPlay("screenOpenExpand");
                } else {
                    _stage.background_mc.phoneScreen_mc.phoneScreenAni_mc.gotoAndPlay("screenOpening");
                }
                _stage.background_mc.phoneScreen_mc.gotoAndStop("rollOver");
            }
        }
        function phoneRollOut() {
            if (!_isEPFAgent) {
                if ((!isOnBecomeAgentTrigger()) && (_stage.background_mc.phoneScreen_mc.phoneScreenAni_mc._currentframe >= 45)) {
                    _stage.background_mc.phoneScreen_mc.phoneScreenAni_mc.gotoAndPlay("screenClosingSoon");
                }
                _stage.background_mc.phoneScreen_mc.gotoAndStop("rollOut");
            }
        }
        function isOnBecomeAgentTrigger() {
            var _local_2 = _SHELL.getMyPlayerObject();
            return(_stage.triggers_mc.becomeAgent_mc.hitTest(_local_2.x, _local_2.y, true));
        }
        function phoneRelease() {
            if (!_isEPFAgent) {
                if (isOnBecomeAgentTrigger()) {
                    showRecruitmentDialog();
                } else {
                    _ENGINE.sendPlayerMove(540, 205);
                }
            } else {
                _ENGINE.sendPlayerMove(_xmouse, _ymouse);
            }
        }
        function showRecruitmentDialog() {
            if (!_isEPFAgent) {
                _stage.background_mc.phoneScreen_mc.phoneScreenAni_mc.gotoAndStop("screenOpenStop");
                _INTERFACE.showContent("w.epf.recruitment.dialog");
                _stage.background_mc.phone_mc.gotoAndStop("phoneOff");
                _stage.background_mc.phoneWall_mc.gotoAndStop("phoneOff");
                _recruitmentDialogDelgate = com.clubpenguin.util.Delegate.create(this, onRecruitmentDialogClosed);
                _SHELL.addListener(_SHELL.CONTENT_CLOSED, _recruitmentDialogDelgate);
            }
        }
        function enterCommandRoom() {
            if (_isEPFAgent) {
                _SHELL.sendJoinRoom("agentcom", 630, 190);
            }
        }
        function exit(name, x, y) {
            _SHELL.sendJoinRoom(name, x, y);
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _isEPFAgent = _SHELL.isEPFAgent();
            if (_isEPFAgent) {
                _stage.background_mc.secretDoor01_mc.secretDoor_btn.useHandCursor = true;
            }
            if (_isEPFAgent) {
                _stage.background_mc.phone_mc.gotoAndStop("phoneOff");
                _stage.background_mc.phoneWall_mc.gotoAndStop("phoneOff");
            }
            _now = _SHELL.getPenguinStandardTime();
            _currentSecond = _now.getSeconds();
            _currentMinute = _now.getMinutes();
            _currentHour = _now.getHours();
            minuteFrameCompensation();
            hourFrameCompensation();
            _emptyClip = _stage.createEmptyMovieClip("_emptyClip", _stage.getNextHighestDepth());
            _emptyClip.onEnterFrame = com.clubpenguin.util.Delegate.create(this, updateTime);
        }
        function onRecruitmentDialogClosed() {
            if (_SHELL.isEPFAgent()) {
                _isEPFAgent = true;
                _stage.background_mc.secretDoor01_mc.gotoAndPlay("secretOpeningFirstTime");
                _stage.background_mc.secretDoor02_mc.gotoAndPlay("secretOpeningFirstTime");
                _stage.background_mc.secretDoor01_mc.secretDoor_btn.useHandCursor = true;
            } else {
                _stage.background_mc.phone_mc.gotoAndPlay("phoneOn");
                _stage.background_mc.phoneWall_mc.gotoAndPlay("phoneOn");
            }
            _stage.background_mc.phoneScreen_mc.phoneScreenAni_mc.gotoAndPlay("screenClosing");
        }
        function updateTime() {
            var _local_2 = getTimer();
            var _local_3 = 1000;
            if ((_local_2 - _previousTimer) >= _local_3) {
                _previousTimer = _local_2;
                _now.setTime(_now.getTime() + _local_3);
            }
            if (_currentSecond != _now.getSeconds()) {
                _currentSecond = _now.getSeconds();
                if (_currentMinute != _now.getMinutes()) {
                    _currentMinute = _now.getMinutes();
                    minuteFrameCompensation();
                    if (_currentHour != _now.getHours()) {
                        _currentHour = _now.getHours();
                        hourFrameCompensation();
                    }
                }
            }
        }
        function minuteFrameCompensation() {
            var _local_2 = 60;
            if (_currentHour != 0) {
                _stage.workersDesks_mc.clock.minuteHand.gotoAndStop(_currentMinute);
            } else {
                _stage.workersDesks_mc.clock.minuteHand.gotoAndStop(_local_2);
            }
        }
        function hourFrameCompensation() {
            var _local_2 = 24;
            if (_currentHour != 0) {
                _stage.workersDesks_mc.clock.hourHand.gotoAndStop(_currentHour);
            } else {
                _stage.workersDesks_mc.clock.hourHand.gotoAndStop(_local_2);
            }
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _SHELL.removeListener(_SHELL.CONTENT_CLOSED, _recruitmentDialogDelgate);
        }
        static var CLASS_NAME = "AgentLobby";
        var _previousTimer = 0;
    }
