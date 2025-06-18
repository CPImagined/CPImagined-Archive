//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.prehistoric.TrexHQ extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, _triggerWatcher, setupNavigationButtons, _shakingTimeout, _secondCheckIntervalID, _currentTime, _currentMinute, _triggerWatcherInterval, _ENGINE, _INTERFACE, _currentSecond, _rocksTimeout, _weightStation1, _weightStation2, _weightStationTrigger1, _weightStationTrigger2;
        function TrexHQ (stageReference) {
            super(stageReference);
            _stage.start_x = 500;
            _stage.start_y = 245;
            _stage.customPenguinSize = 85;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _stage.triggers_mc.party7_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party7", 550, 325);
            _stage.triggers_mc.party10_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party10", 335, 160);
            var _local_2 = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty, com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.launchDinoDigGame);
            _stage.triggers_mc.nest1_mc.triggerFunction = _local_2;
            _stage.triggers_mc.nest2_mc.triggerFunction = _local_2;
            _stage.foreground_mc.partyCat_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, com.clubpenguin.world.rooms.common.RoomConstants.PARTY_CATALOGUE_1);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.nest1_mc.nest_btn, 185, 255), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.nest2_mc.nest_btn, 690, 285), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.weightEffect01_mc.buttonFrame, 445, 236), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.weightEffect02_mc.buttonFrame, 131, 355)]);
            _shakingTimeout = -1;
            _secondCheckIntervalID = setInterval(com.clubpenguin.util.Delegate.create(this, updateTime), ONE_SECOND);
            _currentTime = fetchTime();
            _currentMinute = _currentTime.getMinutes();
            updateTime();
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            configureWeightStationTriggers();
            _stage.nest1_mc.nest_btn.onRollOver = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty, com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.showDinoDigHint, _stage.nest1_mc);
            _stage.nest1_mc.nest_btn.onRollOut = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty, com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.hideDinoDigHint);
            _stage.nest2_mc.nest_btn.onRollOver = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty, com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.showDinoDigHint, _stage.nest2_mc);
            _stage.nest2_mc.nest_btn.onRollOut = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty, com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.hideDinoDigHint);
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function joinGame(gameName, is_prompt) {
            _ENGINE.sendJoinGame(gameName, is_prompt);
        }
        function showContent(content) {
            _INTERFACE.showContent(content);
        }
        function fetchTime() {
            if (_SHELL == undefined) {
                return(new Date());
            } else {
                return(_SHELL.getPenguinStandardTime());
            }
        }
        function updateTime() {
            _currentTime.setTime(_currentTime.getTime() + ONE_SECOND);
            _currentSecond = _currentTime.getSeconds();
            if (_currentMinute != _currentTime.getMinutes()) {
                _currentMinute = _currentTime.getMinutes();
                _currentTime = fetchTime();
                if ((_currentMinute % 3) == 0) {
                    meteoriteSequence();
                }
            }
        }
        function meteoriteSequence() {
            _stage.background_mc.meteorite_mc.gotoAndPlay(2);
            _shakingTimeout = setTimeout(com.clubpenguin.util.Delegate.create(this, playRocks), _rocksDelay);
        }
        function playRocks() {
            _stage.rockFall_mc.gotoAndPlay(2);
            clearTimeout(_shakingTimeout);
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            clearInterval(_secondCheckIntervalID);
            clearTimeout(_rocksTimeout);
            clearTimeout(_shakingTimeout);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _weightStation1.cleanStation();
            _weightStation2.cleanStation();
        }
        function configureWeightStationTriggers() {
            _weightStation1 = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStation(_stage.weightEffect01_mc, PLAY_TASK, null, WEIGHTS_PATH);
            _weightStation1.stationBIInfo("prehistoric_weights", com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_PLAY_STATION);
            configureStationTrigger(_weightStation1, _weightStationTrigger1, _stage.triggers_mc.weightStation01_mc);
            _weightStation2 = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStation(_stage.weightEffect02_mc, PLAY_TASK, null, WEIGHTS_PATH);
            _weightStation2.stationBIInfo("prehistoric_weights", com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_PLAY_STATION);
            configureStationTrigger(_weightStation2, _weightStationTrigger2, _stage.triggers_mc.weightStation02_mc);
        }
        function configureStationTrigger(careStation, playerTrigger, triggerClip) {
            playerTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(triggerClip);
            playerTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(careStation, careStation.beginActivity));
            playerTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(careStation, careStation.endActivity));
            _triggerWatcher.addTrigger(playerTrigger);
        }
        static var CLASS_NAME = "TrexHQ";
        var ONE_SECOND = 1000;
        var _rocksDelay = 2000;
        static var WEIGHTS_FRAME = com.clubpenguin.puffleavatar.PuffleAvatarConstants.PUFFLE_WALK_SOUTH_FRAME;
        static var WEIGHTS_PATH = com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStationAnimationConstants.PUFFLE_BARBELL;
        static var PLAY_TASK = com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareTaskEnum.PLAYING_TASK;
    }
