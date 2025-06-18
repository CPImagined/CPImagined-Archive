//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.gokart.Rink extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, localize, setupNavigationButtons, showContent, _ENGINE, _INTERFACE, _destroyDelegate, _triggerWatcher, _triggerWatcherInterval, _checkpoint1Trigger, _checkpoint1PitTrigger, _checkpoint2Trigger, _checkpoint3Trigger, _checkpoint4Trigger, _checkpoint5Trigger, _checkpoint6Trigger, _checkpoint7Trigger, _checkpoint8Trigger, _checkpoint9Trigger, _checkpoint10Trigger, wem, _propController, _engineOverrides;
        function Rink (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 380;
            _stage.start_y = 155;
            if (!_SHELL) {
                init();
            }
            localize([_stage.boxseatsLang_mc, _stage.raceSign_mc, _stage.raceSign_mc.raceSignBottom_mc.fishdogLang_mc, _stage.helmetLang_mc, _stage.interface_mc.sports_mc]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navForts_btn, 380, 130), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navSchool_btn, 635, 155), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navFishDogs_btn, 102, 153), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navSeat01_btn, 233, 116), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navSeat02_btn, 261, 114), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navSeat03_btn, 289, 112), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navSeat04_btn, 317, 110), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navStand01_btn, 514, 108), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navStand02_btn, 459, 121), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navStand03_btn, 541, 141), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.helmetLang_mc.navHelmet_btn, 623, 232), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.jacket_mc.navJacket_btn, 691, 298)]);
            _stage.navForts_btn.useHandCursor = false;
            _stage.navSchool_btn.useHandCursor = false;
            _stage.navFishDogs_btn.useHandCursor = false;
            _stage.navSeat01_btn.useHandCursor = false;
            _stage.navSeat02_btn.useHandCursor = false;
            _stage.navSeat03_btn.useHandCursor = false;
            _stage.navSeat04_btn.useHandCursor = false;
            _stage.navStand01_btn.useHandCursor = false;
            _stage.navStand02_btn.useHandCursor = false;
            _stage.navStand03_btn.useHandCursor = false;
            _stage.triggers_mc.forts_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forts", 290, 204);
            _stage.triggers_mc.school_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "school", 55, 360);
            _stage.triggers_mc.itemHelmet_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, getItemHelmet);
            _stage.triggers_mc.itemJacket_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, getItemJacket);
            _stage.triggers_mc.startArea_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, atStartLine);
            showContent([new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.interface_mc.sports_mc.sports_btn, true, "sport_catalogue", "")]);
            configureGoKartFunctionality();
            _stage.foreground_mc.moveXY_btn.onRelease = com.clubpenguin.util.Delegate.create(this, moveToMouse);
            _stage.foreground_mc.moveXY_btn.useHandCursor = false;
        }
        function moveToMouse() {
            _ENGINE.sendPlayerMove(_xmouse, _ymouse);
        }
        function getItemHelmet() {
            _INTERFACE.buyInventory(HELMET_ITEM_ID);
        }
        function getItemJacket() {
            if (_SHELL.getMyPlayerObject().is_member) {
                _INTERFACE.buyInventory(JACKET_ITEM_ID);
            } else {
                _INTERFACE.showContent("oops_catalog_clothing");
            }
        }
        function atStartLine() {
            if (_stage.raceSign_mc.raceSignTopLang_mc._currentframe <= 300) {
                startRace();
            }
        }
        function exit(name, x, y) {
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom(name, x, y);
        }
        function init() {
            trace(CLASS_NAME + ": init()");
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _stage.customPenguinSize = 85;
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            _checkpoint1Trigger = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.line01_mc);
            _checkpoint1Trigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, addPlayerline01));
            _triggerWatcher.addTrigger(_checkpoint1Trigger);
            _checkpoint1PitTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.line01pit_mc);
            _checkpoint1PitTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, addPlayerline01pit));
            _triggerWatcher.addTrigger(_checkpoint1PitTrigger);
            _checkpoint2Trigger = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.line02_mc);
            _checkpoint2Trigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, addPlayerline02));
            _triggerWatcher.addTrigger(_checkpoint2Trigger);
            _checkpoint3Trigger = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.line03_mc);
            _checkpoint3Trigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, addPlayerline03));
            _triggerWatcher.addTrigger(_checkpoint3Trigger);
            _checkpoint4Trigger = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.line04_mc);
            _checkpoint4Trigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, addPlayerline04));
            _triggerWatcher.addTrigger(_checkpoint4Trigger);
            _checkpoint5Trigger = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.line05_mc);
            _checkpoint5Trigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, addPlayerline05));
            _triggerWatcher.addTrigger(_checkpoint5Trigger);
            _checkpoint6Trigger = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.line06_mc);
            _checkpoint6Trigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, addPlayerline06));
            _triggerWatcher.addTrigger(_checkpoint6Trigger);
            _checkpoint7Trigger = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.line07_mc);
            _checkpoint7Trigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, addPlayerline07));
            _triggerWatcher.addTrigger(_checkpoint7Trigger);
            _checkpoint8Trigger = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.line08_mc);
            _checkpoint8Trigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, addPlayerline08));
            _triggerWatcher.addTrigger(_checkpoint8Trigger);
            _checkpoint9Trigger = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.line09_mc);
            _checkpoint9Trigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, addPlayerline09));
            _triggerWatcher.addTrigger(_checkpoint9Trigger);
            _checkpoint10Trigger = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.line10_mc);
            _checkpoint10Trigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, addPlayerline10));
            _triggerWatcher.addTrigger(_checkpoint10Trigger);
        }
        function addPlayerline01(players) {
            var _local_2 = 0;
            while (_local_2 < players.length) {
                if (players[_local_2] == _SHELL.getMyPlayerId()) {
                    if (trackingRaceNumber == 0) {
                        if (_stage.raceSign_mc.raceSignTopLang_mc._currentframe <= 300) {
                            startRace();
                        }
                        if (_stage.raceSign_mc.raceSignTopLang_mc._currentframe <= 500) {
                            _stage.pole01_mc.gotoAndPlay("lap1On");
                            trackingRaceNumber = 1;
                        }
                    } else if (trackingRaceNumber == 10) {
                        _stage.pole01_mc.gotoAndPlay("lap2On");
                        _stage.pole02_mc.gotoAndPlay("lap2Reset");
                        _stage.pole03_mc.gotoAndPlay("lap2Reset");
                        _stage.pole04_mc.gotoAndPlay("lap2Reset");
                        _stage.pole05_mc.gotoAndPlay("lap2Reset");
                        _stage.pole06_mc.gotoAndPlay("lap2Reset");
                        _stage.pole07_mc.gotoAndPlay("lap2Reset");
                        _stage.pole08_mc.gotoAndPlay("lap2Reset");
                        _stage.pole09_mc.gotoAndPlay("lap2Reset");
                        _stage.pole10_mc.gotoAndPlay("lap2Reset");
                        _stage.raceSign_mc.raceSignTopLang_mc.gotoAndPlay("lap2");
                        trackingRaceNumber = 11;
                    } else if (trackingRaceNumber == 20) {
                        _stage.pole01_mc.gotoAndPlay("lap3On");
                        _stage.pole02_mc.gotoAndPlay("lap3Reset");
                        _stage.pole03_mc.gotoAndPlay("lap3Reset");
                        _stage.pole04_mc.gotoAndPlay("lap3Reset");
                        _stage.pole05_mc.gotoAndPlay("lap3Reset");
                        _stage.pole06_mc.gotoAndPlay("lap3Reset");
                        _stage.pole07_mc.gotoAndPlay("lap3Reset");
                        _stage.pole08_mc.gotoAndPlay("lap3Reset");
                        _stage.pole09_mc.gotoAndPlay("lap3Reset");
                        _stage.pole10_mc.gotoAndPlay("lap3Reset");
                        _stage.raceSign_mc.raceSignTopLang_mc.gotoAndPlay("lap3");
                        trackingRaceNumber = 21;
                    } else if (trackingRaceNumber == 30) {
                        _stage.pole01_mc.gotoAndPlay("finish");
                        _stage.pole02_mc.gotoAndPlay("finish");
                        _stage.pole03_mc.gotoAndPlay("finish");
                        _stage.pole04_mc.gotoAndPlay("finish");
                        _stage.pole05_mc.gotoAndPlay("finish");
                        _stage.pole06_mc.gotoAndPlay("finish");
                        _stage.pole07_mc.gotoAndPlay("finish");
                        _stage.pole08_mc.gotoAndPlay("finish");
                        _stage.pole09_mc.gotoAndPlay("finish");
                        _stage.pole10_mc.gotoAndPlay("finish");
                        _stage.raceSign_mc.raceSignTopLang_mc.gotoAndPlay("finished");
                        trackingRaceNumber = 0;
                    }
                }
                _local_2++;
            }
        }
        function addPlayerline01pit(players) {
            var _local_2 = 0;
            while (_local_2 < players.length) {
                if (players[_local_2] == _SHELL.getMyPlayerId()) {
                    if (trackingRaceNumber == 10) {
                        _stage.pole01_mc.gotoAndPlay("lap2On");
                        _stage.pole02_mc.gotoAndPlay("lap2Reset");
                        _stage.pole03_mc.gotoAndPlay("lap2Reset");
                        _stage.pole04_mc.gotoAndPlay("lap2Reset");
                        _stage.pole05_mc.gotoAndPlay("lap2Reset");
                        _stage.pole06_mc.gotoAndPlay("lap2Reset");
                        _stage.pole07_mc.gotoAndPlay("lap2Reset");
                        _stage.pole08_mc.gotoAndPlay("lap2Reset");
                        _stage.pole09_mc.gotoAndPlay("lap2Reset");
                        _stage.pole10_mc.gotoAndPlay("lap2Reset");
                        _stage.raceSign_mc.raceSignTopLang_mc.gotoAndPlay("lap2");
                        trackingRaceNumber = 11;
                    } else if (trackingRaceNumber == 20) {
                        _stage.pole01_mc.gotoAndPlay("lap3On");
                        _stage.pole02_mc.gotoAndPlay("lap3Reset");
                        _stage.pole03_mc.gotoAndPlay("lap3Reset");
                        _stage.pole04_mc.gotoAndPlay("lap3Reset");
                        _stage.pole05_mc.gotoAndPlay("lap3Reset");
                        _stage.pole06_mc.gotoAndPlay("lap3Reset");
                        _stage.pole07_mc.gotoAndPlay("lap3Reset");
                        _stage.pole08_mc.gotoAndPlay("lap3Reset");
                        _stage.pole09_mc.gotoAndPlay("lap3Reset");
                        _stage.pole10_mc.gotoAndPlay("lap3Reset");
                        _stage.raceSign_mc.raceSignTopLang_mc.gotoAndPlay("lap3");
                        trackingRaceNumber = 21;
                    }
                }
                _local_2++;
            }
        }
        function addPlayerline02(players) {
            var _local_2 = 0;
            while (_local_2 < players.length) {
                if (players[_local_2] == _SHELL.getMyPlayerId()) {
                    if ((trackingRaceNumber == 1) && (_stage.raceSign_mc.raceSignTopLang_mc._currentframe >= 391)) {
                        _stage.pole02_mc.gotoAndPlay("lap1On");
                        trackingRaceNumber = 2;
                    } else if (trackingRaceNumber == 11) {
                        _stage.pole02_mc.gotoAndPlay("lap2On");
                        trackingRaceNumber = 12;
                    } else if (trackingRaceNumber == 21) {
                        _stage.pole02_mc.gotoAndPlay("lap3On");
                        trackingRaceNumber = 22;
                    }
                }
                _local_2++;
            }
        }
        function addPlayerline03(players) {
            var _local_2 = 0;
            while (_local_2 < players.length) {
                if (players[_local_2] == _SHELL.getMyPlayerId()) {
                    if (trackingRaceNumber == 2) {
                        _stage.pole03_mc.gotoAndPlay("lap1On");
                        trackingRaceNumber = 3;
                    } else if (trackingRaceNumber == 12) {
                        _stage.pole03_mc.gotoAndPlay("lap2On");
                        trackingRaceNumber = 13;
                    } else if (trackingRaceNumber == 22) {
                        _stage.pole03_mc.gotoAndPlay("lap3On");
                        trackingRaceNumber = 23;
                    }
                }
                _local_2++;
            }
        }
        function addPlayerline04(players) {
            var _local_2 = 0;
            while (_local_2 < players.length) {
                if (players[_local_2] == _SHELL.getMyPlayerId()) {
                    if (trackingRaceNumber == 3) {
                        _stage.pole04_mc.gotoAndPlay("lap1On");
                        trackingRaceNumber = 4;
                    } else if (trackingRaceNumber == 13) {
                        _stage.pole04_mc.gotoAndPlay("lap2On");
                        trackingRaceNumber = 14;
                    } else if (trackingRaceNumber == 23) {
                        _stage.pole04_mc.gotoAndPlay("lap3On");
                        trackingRaceNumber = 24;
                    }
                }
                _local_2++;
            }
        }
        function addPlayerline05(players) {
            var _local_2 = 0;
            while (_local_2 < players.length) {
                if (players[_local_2] == _SHELL.getMyPlayerId()) {
                    if (trackingRaceNumber == 4) {
                        _stage.pole05_mc.gotoAndPlay("lap1On");
                        trackingRaceNumber = 5;
                    } else if (trackingRaceNumber == 14) {
                        _stage.pole05_mc.gotoAndPlay("lap2On");
                        trackingRaceNumber = 15;
                    } else if (trackingRaceNumber == 24) {
                        _stage.pole05_mc.gotoAndPlay("lap3On");
                        trackingRaceNumber = 25;
                    }
                }
                _local_2++;
            }
        }
        function addPlayerline06(players) {
            var _local_2 = 0;
            while (_local_2 < players.length) {
                if (players[_local_2] == _SHELL.getMyPlayerId()) {
                    if (trackingRaceNumber == 5) {
                        _stage.pole06_mc.gotoAndPlay("lap1On");
                        trackingRaceNumber = 6;
                    } else if (trackingRaceNumber == 15) {
                        _stage.pole06_mc.gotoAndPlay("lap2On");
                        trackingRaceNumber = 16;
                    } else if (trackingRaceNumber == 25) {
                        _stage.pole06_mc.gotoAndPlay("lap3On");
                        trackingRaceNumber = 26;
                    }
                }
                _local_2++;
            }
        }
        function addPlayerline07(players) {
            var _local_2 = 0;
            while (_local_2 < players.length) {
                if (players[_local_2] == _SHELL.getMyPlayerId()) {
                    if (trackingRaceNumber == 6) {
                        _stage.pole07_mc.gotoAndPlay("lap1On");
                        trackingRaceNumber = 7;
                    } else if (trackingRaceNumber == 16) {
                        _stage.pole07_mc.gotoAndPlay("lap2On");
                        trackingRaceNumber = 17;
                    } else if (trackingRaceNumber == 26) {
                        _stage.pole07_mc.gotoAndPlay("lap3On");
                        trackingRaceNumber = 27;
                    }
                }
                _local_2++;
            }
        }
        function addPlayerline08(players) {
            var _local_2 = 0;
            while (_local_2 < players.length) {
                if (players[_local_2] == _SHELL.getMyPlayerId()) {
                    if (trackingRaceNumber == 7) {
                        _stage.pole08_mc.gotoAndPlay("lap1On");
                        trackingRaceNumber = 8;
                    } else if (trackingRaceNumber == 17) {
                        _stage.pole08_mc.gotoAndPlay("lap2On");
                        trackingRaceNumber = 18;
                    } else if (trackingRaceNumber == 27) {
                        _stage.pole08_mc.gotoAndPlay("lap3On");
                        trackingRaceNumber = 28;
                    }
                }
                _local_2++;
            }
        }
        function addPlayerline09(players) {
            var _local_2 = 0;
            while (_local_2 < players.length) {
                if (players[_local_2] == _SHELL.getMyPlayerId()) {
                    if (trackingRaceNumber == 8) {
                        _stage.pole09_mc.gotoAndPlay("lap1On");
                        trackingRaceNumber = 9;
                    } else if (trackingRaceNumber == 18) {
                        _stage.pole09_mc.gotoAndPlay("lap2On");
                        trackingRaceNumber = 19;
                    } else if (trackingRaceNumber == 28) {
                        _stage.pole09_mc.gotoAndPlay("lap3On");
                        trackingRaceNumber = 29;
                    }
                }
                _local_2++;
            }
        }
        function addPlayerline10(players) {
            var _local_2 = 0;
            while (_local_2 < players.length) {
                if (players[_local_2] == _SHELL.getMyPlayerId()) {
                    if (trackingRaceNumber == 9) {
                        _stage.pole10_mc.gotoAndPlay("lap1On");
                        trackingRaceNumber = 10;
                    } else if (trackingRaceNumber == 19) {
                        _stage.pole10_mc.gotoAndPlay("lap2On");
                        trackingRaceNumber = 20;
                    } else if (trackingRaceNumber == 29) {
                        _stage.pole10_mc.gotoAndPlay("lap3On");
                        trackingRaceNumber = 30;
                    }
                }
                _local_2++;
            }
        }
        function startRace() {
            _stage.raceSign_mc.raceSignTopLang_mc.gotoAndPlay("raceBeginsIn");
        }
        function configureGoKartFunctionality() {
            _propController = new com.clubpenguin.world.rooms2014.gokart.GoKartController();
            _propController.createPropTrigger(_stage.triggers_mc.goKart_mc, _triggerWatcher);
            _engineOverrides = new com.clubpenguin.world.rooms2014.gokart.GoKart_EngineOverrides(_propController);
            _engineOverrides.init();
            activateGoKartEngineOverrides();
        }
        function activateGoKartEngineOverrides() {
            trace("Activate engine overrides");
            _ENGINE.updatePlayerFrame = com.clubpenguin.util.Delegate.create(this, _engineOverrides.updatePlayerFrame);
        }
        function deactivateGoKartEngineOverrides() {
            trace("Deactivate engine overrides");
            _ENGINE.updatePlayerFrame = _engineOverrides.defaultUpdatePlayerFrame;
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            deactivateGoKartEngineOverrides();
            wem.destroy();
        }
        static var CLASS_NAME = "Rink";
        static var HELMET_ITEM_ID = 93086;
        static var JACKET_ITEM_ID = 93087;
        var trackingRaceNumber = 0;
    }
