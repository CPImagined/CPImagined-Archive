//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.halloween.party.HalloweenPartyQuestCommunicator
    {
        static var _shell, _airtower, _interface, _engine, _party, _questCommunicatorTimeout, _genericRoomHintTimeout;
        function HalloweenPartyQuestCommunicator () {
        }
        static function init() {
            if (_initialized) {
                return(undefined);
            }
            _initialized = true;
            _shell = _global.getCurrentShell();
            _airtower = _global.getCurrentAirtower();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _party = _global.getCurrentParty().HalloweenParty;
            _party.pebug("\n\nHalloweenPartyQuestCommunicator init");
            _shell.sendOpenAS3Module(com.clubpenguin.modules.AS3ModuleConstants.QUEST_COMMUNICATOR, null, {modalBackgroundEnabled:false, hideLoadingDialog:true});
            if (!com.clubpenguin.world.rooms2014.halloween.party.HalloweenParty.firstTimeUserExperience) {
                checkForHauntedHouseReminder();
            }
        }
        static function sendCommunicatorMessage(messageToken, expressionID, duration) {
            _shell.sendDataToAS3("questcommunicator", {message:messageToken, expression:expressionID, duration:duration});
        }
        static function sendDismissCommunicator() {
            _party.pebug("HalloweenPartyQuestCommunicator.sendCommunicatorMessage() questcommunicatordismiss");
            _shell.sendDataToAS3("questcommunicatordismiss", {message:undefined});
        }
        static function clearTimeouts() {
            if ((_questCommunicatorTimeout == undefined) && (_genericRoomHintTimeout == undefined)) {
                return(undefined);
            }
            _party.pebug("-------- HalloweenPartyQuestCommunicator clearTimeouts() --------");
            clearTimeout(_questCommunicatorTimeout);
            clearTimeout(_genericRoomHintTimeout);
            _questCommunicatorTimeout = undefined;
            _genericRoomHintTimeout = undefined;
        }
        static function clean() {
            clearTimeouts();
            sendDismissCommunicator();
        }
        static function checkForHauntedHouseReminder() {
            if (_party.partyCookie.msgViewedArray[_party.CONSTANTS.BELLHOP_MESSAGE_NUMBER] == 0) {
                _party.pebug("HalloweenPartyQuestCommunicator (FTL1) checkForHauntedHouseReminder()");
                _questCommunicatorTimeout = setTimeout(com.clubpenguin.util.Delegate.create(_this, displayHauntedHouseReminder), 30 * SECOND);
            }
        }
        static function displayHauntedHouseReminder() {
            _party.pebug("HalloweenPartyQuestCommunicator (FTL1) displayHauntedHouseReminder()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_REMINDER_TO_CHECKOUT_HAUNTED_HOTEL, EXPRESSION_GARY_1);
            clearTimeouts();
            _party.sendQuestCommunicatorBI(0, "haunted_house_reminder");
        }
        static function checkForPlayerClicksOnElevator() {
            if ((_party.partyCookie.msgViewedArray[_party.CONSTANTS.BELLHOP_MESSAGE_NUMBER] == 1) && (!_party.getTaskStatus(_party.getQuestVOByRoomID(_party.CONSTANTS.ROOM_ID_BASEMENT)))) {
                _party.pebug("HalloweenPartyQuestCommunicator (QFI1) checkForPlayerClicksOnElevator()");
                sendCommunicatorMessage(_party.CONSTANTS.QC_PLAYER_CLICKS_ON_ELEVATOR, EXPRESSION_SKIP_2);
                _party.sendQuestCommunicatorBI(0, "elevator_broken");
            }
        }
        static function checkPointOutBasementToPlayer() {
            clearTimeouts();
            if (!_party.getTaskStatus(_party.getQuestVOByRoomID(_party.CONSTANTS.ROOM_ID_BASEMENT))) {
                _party.pebug("HalloweenPartyQuestCommunicator (QFI2) checkPointOutBasementToPlayer()");
                _questCommunicatorTimeout = setTimeout(com.clubpenguin.util.Delegate.create(_this, displayPointOutBasementMessage), 60 * SECOND);
            }
        }
        static function displayPointOutBasementMessage() {
            _party.pebug("HalloweenPartyQuestCommunicator (QFI2) displayPointOutBasementMessage()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_POINT_OUT_BASEMENT, EXPRESSION_SKIP_1);
            clearTimeouts();
            _party.sendQuestCommunicatorBI(0, "point_out_basement");
        }
        static function checkPointOutBasementPuzzle() {
            if (!_party.getTaskStatus(_party.getQuestVOByRoomID(_party.CONSTANTS.ROOM_ID_BASEMENT))) {
                _party.pebug("HalloweenPartyQuestCommunicator (QFI3) checkPointOutBasementPuzzle()");
                _questCommunicatorTimeout = setTimeout(com.clubpenguin.util.Delegate.create(_this, displayPointOutBasementPuzzle), 60 * SECOND);
            }
        }
        static function displayPointOutBasementPuzzle() {
            _party.pebug("HalloweenPartyQuestCommunicator (QFI3) displayPointOutBasementPuzzle()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_POINT_OUT_BASEMENT_PUZZLE, EXPRESSION_SKIP_1);
            clearTimeouts();
            _party.sendQuestCommunicatorBI(0, "point_out_puzzle");
        }
        static function checkGiveBasementPuzzleHint() {
            clearTimeouts();
            if (!_party.getTaskStatus(_party.getQuestVOByRoomID(_party.CONSTANTS.ROOM_ID_BASEMENT))) {
                _party.pebug("HalloweenPartyQuestCommunicator (QFI4) checkGiveBasementPuzzleHint()");
                _questCommunicatorTimeout = setTimeout(com.clubpenguin.util.Delegate.create(_this, displayBasementPuzzleHint), 60 * SECOND);
            }
        }
        static function displayBasementPuzzleHint() {
            _party.pebug("HalloweenPartyQuestCommunicator (QFI4) displayBasementPuzzleHint()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_BASEMENT_PUZZLE_HINT, EXPRESSION_SKIP_1);
            clearTimeouts();
            _party.sendQuestCommunicatorBI(0, "basement_switches");
        }
        static function delayDisplayBasementGhostPuffleAppear() {
            clearTimeouts();
            _party.pebug("HalloweenPartyQuestCommunicator (QFI4) delayDisplayBasementGhostPuffleAppear()");
            _questCommunicatorTimeout = setTimeout(com.clubpenguin.util.Delegate.create(_this, displayBasementGhostPuffleAppear), 5 * SECOND);
        }
        static function displayBasementGhostPuffleAppear() {
            _party.pebug("HalloweenPartyQuestCommunicator (QFI5&6) displayBasementGhostPuffleAppear()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_BASEMENT_PUFFLE_APPEAR_1, EXPRESSION_SKIP_2);
            sendCommunicatorMessage(_party.CONSTANTS.QC_BASEMENT_PUFFLE_APPEAR_2, EXPRESSION_SKIP_2);
            clearTimeouts();
            _party.sendQuestCommunicatorBI(0, "ghost_puffle_appearance");
        }
        static function displayNothingOnFloor13() {
            _party.pebug("HalloweenPartyQuestCommunicator (QFI7) displayNothingOnFloor13()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_NOTHING_ON_13TH_FLOOR, EXPRESSION_SKIP_1);
            _party.sendQuestCommunicatorBI(0, "nothing_on_floor_13");
        }
        static function checkDisplayGenericFloorHint() {
            clearTimeouts();
            if ((!_party.getTaskStatus(_party.getQuestVOByRoomID(_shell.getRoomObject().room_id))) && (!_party.partyCookie.didCompleteAtLeastOneTask)) {
                _party.pebug("HalloweenPartyQuestCommunicator (MP 1) checkDisplayGenericFloorHint()");
                _genericRoomHintTimeout = setTimeout(com.clubpenguin.util.Delegate.create(_this, displayGenericFloorHint), 60 * SECOND);
            }
        }
        static function displayGenericFloorHint() {
            _party.pebug("HalloweenPartyQuestCommunicator (MP 1) displayGenericFloorHint()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_GENERIC_PUZZLE_HINT, EXPRESSION_SKIP_1);
            clearTimeout(_genericRoomHintTimeout);
            var _local_1 = _party.getQuestVOByRoomID(_shell.getRoomObject().room_id);
            _party.sendQuestCommunicatorBI(_local_1.questIndex, "generic_puzzle_hint");
        }
        static function displayCollectMachinePiece(visitedFloor12) {
            _party.pebug("HalloweenPartyQuestCommunicator (MP 2,5) displayCollectMachinePieceWithoutFloor12()");
            clearTimeouts();
            if (_party.partyCookie.didCompleteAtLeastOneTask) {
                return(undefined);
            }
            var _local_1 = _shell.getRoomObject().room_id;
            if (_local_1 == _party.CONSTANTS.ROOM_ID_PARTY15) {
                _local_1 = _party.CONSTANTS.ROOM_ID_BALL_ROOM;
            }
            var _local_2 = _party.getQuestVOByRoomID(_local_1);
            if (!visitedFloor12) {
                sendCommunicatorMessage(_party.CONSTANTS.QC_GENERIC_MACHINE_NO_FLOOR_12_1, EXPRESSION_SKIP_2);
                sendCommunicatorMessage(_party.CONSTANTS.QC_GENERIC_MACHINE_NO_FLOOR_12_2, EXPRESSION_SKIP_1);
                _party.sendQuestCommunicatorBI(_local_2.questIndex, "collected_machine_piece_without_floor12");
            } else {
                sendCommunicatorMessage(_party.CONSTANTS.QC_GENERIC_MACHINE_FLOOR_12_1, EXPRESSION_SKIP_1);
                sendCommunicatorMessage(_party.CONSTANTS.QC_GENERIC_MACHINE_FLOOR_12_2, EXPRESSION_SKIP_2);
                _party.sendQuestCommunicatorBI(_local_2.questIndex, "collected_machine_piece_with_floor12");
            }
        }
        static function displayCollectedAllMachinePieces(visitedFloor12) {
            _party.pebug("HalloweenPartyQuestCommunicator (MP 6,7) displayCollectedAllMachinePieces()");
            _party.pebug("HalloweenPartyQuestCommunicator (MP 6,7) displayCollectedAllMachinePieces() Seen 12th Floor? " + visitedFloor12);
            clearTimeouts();
            if (!visitedFloor12) {
                sendCommunicatorMessage(_party.CONSTANTS.QC_COLLECTED_ALL_MACHINE_PIECES_NO_FLOOR_12, EXPRESSION_SKIP_2);
            } else {
                sendCommunicatorMessage(_party.CONSTANTS.QC_COLLECTED_ALL_MACHINE_PIECES_FLOOR_12, EXPRESSION_SKIP_1);
            }
            var _local_2 = _party.getQuestVOByRoomID(_shell.getRoomObject().room_id);
            _party.sendQuestCommunicatorBI(6, ((!visitedFloor12) ? "collected_all_machine_piece_without_floor12" : "collected_all_machine_piece_with_floor12"));
        }
        static function checkDisplaySittingRoomHint() {
            if (!_party.getTaskStatus(_party.getQuestVOByRoomID(_party.CONSTANTS.ROOM_ID_SITTING_ROOM))) {
                _party.pebug("HalloweenPartyQuestCommunicator (4F 1) checkDisplaySittingRoomHint()");
                _questCommunicatorTimeout = setTimeout(com.clubpenguin.util.Delegate.create(_this, displaySittingRoomHint), 180 * SECOND);
            }
        }
        static function displaySittingRoomHint() {
            _party.pebug("HalloweenPartyQuestCommunicator (4F 1) displaySittingRoomHint()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_SITTING_ROOM_PUZZLE_HINT, EXPRESSION_SKIP_1);
            clearTimeouts();
            var _local_1 = _party.getQuestVOByRoomID(_party.CONSTANTS.ROOM_ID_SITTING_ROOM);
            _party.sendQuestCommunicatorBI(_local_1.questIndex, "sitting_room_puzzle");
        }
        static function checkDisplayBallroomHint() {
            if (!_party.getTaskStatus(_party.getQuestVOByRoomID(_party.CONSTANTS.ROOM_ID_BALL_ROOM))) {
                _party.pebug("HalloweenPartyQuestCommunicator (5F 1) checkDisplayBallroomHint()");
                _questCommunicatorTimeout = setTimeout(com.clubpenguin.util.Delegate.create(_this, displayBallroomHint), 180 * SECOND);
            }
        }
        static function displayBallroomHint() {
            _party.pebug("HalloweenPartyQuestCommunicator (5F 1) displayBallroomHint()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_BALLROOM_PUZZLE_HINT, EXPRESSION_SKIP_1);
            clearTimeouts();
            var _local_1 = _party.getQuestVOByRoomID(_party.CONSTANTS.ROOM_ID_BALL_ROOM);
            _party.sendQuestCommunicatorBI(_local_1.questIndex, "ballroom_puzzle");
        }
        static function displayBallroomFirstHallway() {
            clearTimeouts();
            _party.pebug("HalloweenPartyQuestCommunicator (5F 2) displayBallroomFirstHallway()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_BALLROOM_FIRST_HALLWAY, EXPRESSION_SKIP_2);
            var _local_1 = _party.getQuestVOByRoomID(_party.CONSTANTS.ROOM_ID_BALL_ROOM);
            _party.sendQuestCommunicatorBI(_local_1.questIndex, "ballroom_first_hallway");
            checkDisplayBallroomHint2();
        }
        static function checkDisplayBallroomHint2() {
            if (!_party.getTaskStatus(_party.getQuestVOByRoomID(_party.CONSTANTS.ROOM_ID_BALL_ROOM))) {
                _party.pebug("HalloweenPartyQuestCommunicator (5F 4) checkDisplayBallroomHint2()");
                _questCommunicatorTimeout = setTimeout(com.clubpenguin.util.Delegate.create(_this, displayBallroomHint2), 180 * SECOND);
            }
        }
        static function displayBallroomHint2() {
            _party.pebug("HalloweenPartyQuestCommunicator (5F 4) displayBallroomHint2()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_BALLROOM_PUZZLE_HINT_2, EXPRESSION_SKIP_1);
            clearTimeouts();
            var _local_1 = _party.getQuestVOByRoomID(_party.CONSTANTS.ROOM_ID_BALL_ROOM);
            _party.sendQuestCommunicatorBI(_local_1.questIndex, "ballroom_puzzle_2");
        }
        static function checkDisplayDiningRoomHint() {
            if (!_party.getTaskStatus(_party.getQuestVOByRoomID(_party.CONSTANTS.ROOM_ID_DINING_ROOM))) {
                _party.pebug("HalloweenPartyQuestCommunicator (6F 1) checkDisplayDiningRoomHint()");
                _questCommunicatorTimeout = setTimeout(com.clubpenguin.util.Delegate.create(_this, displayDiningRoomHint), 180 * SECOND);
            }
        }
        static function displayDiningRoomHint() {
            _party.pebug("HalloweenPartyQuestCommunicator (6F 1) displayDiningRoomHint()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_DINING_ROOM_PUZZLE_HINT, EXPRESSION_SKIP_2);
            clearTimeouts();
            var _local_1 = _party.getQuestVOByRoomID(_party.CONSTANTS.ROOM_ID_DINING_ROOM);
            _party.sendQuestCommunicatorBI(_local_1.questIndex, "dining_room_puzzle");
        }
        static function checkDisplayDiningRoomHint2() {
            if (!_party.getTaskStatus(_party.getQuestVOByRoomID(_party.CONSTANTS.ROOM_ID_DINING_ROOM))) {
                _party.pebug("HalloweenPartyQuestCommunicator (6F 2) checkDisplayDiningRoomHint2()");
                _questCommunicatorTimeout = setTimeout(com.clubpenguin.util.Delegate.create(_this, displayDiningRoomHint2), 60 * SECOND);
            }
        }
        static function displayDiningRoomHint2() {
            _party.pebug("HalloweenPartyQuestCommunicator (6F 2) checkDisplayDiningRoomHint2()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_DINING_ROOM_PUZZLE_HINT_2, EXPRESSION_SKIP_2);
            clearTimeouts();
            checkDisplayDiningRoomHint3();
            var _local_1 = _party.getQuestVOByRoomID(_party.CONSTANTS.ROOM_ID_DINING_ROOM);
            _party.sendQuestCommunicatorBI(_local_1.questIndex, "dining_room_puzzle_2");
        }
        static function checkDisplayDiningRoomHint3() {
            if (!_party.getTaskStatus(_party.getQuestVOByRoomID(_party.CONSTANTS.ROOM_ID_DINING_ROOM))) {
                _party.pebug("HalloweenPartyQuestCommunicator (6F 3) checkDisplayDiningRoomHint3()");
                _questCommunicatorTimeout = setTimeout(com.clubpenguin.util.Delegate.create(_this, displayDiningRoomHint3), 60 * SECOND);
            }
        }
        static function displayDiningRoomHint3() {
            _party.pebug("HalloweenPartyQuestCommunicator (6F 3) checkDisplayDiningRoomHint3()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_DINING_ROOM_PUZZLE_HINT_3, EXPRESSION_SKIP_1);
            clearTimeouts();
            var _local_1 = _party.getQuestVOByRoomID(_party.CONSTANTS.ROOM_ID_DINING_ROOM);
            _party.sendQuestCommunicatorBI(_local_1.questIndex, "dining_room_puzzle_3");
        }
        static function checkDisplayEmptyRoomMessage() {
            _party.pebug("HalloweenPartyQuestCommunicator (7F 1) checkDisplayEmptyRoomMessage()");
            _questCommunicatorTimeout = setTimeout(com.clubpenguin.util.Delegate.create(_this, displayEmptyRoomMessage), 60 * SECOND);
        }
        static function displayEmptyRoomMessage() {
            _party.pebug("HalloweenPartyQuestCommunicator (7F 1) displayEmptyRoomMessage()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_EMPTY_FLOOR_MESSAGE, EXPRESSION_SKIP_1);
            clearTimeouts();
            _party.sendQuestCommunicatorBI(-1, "empty_room_1");
        }
        static function checkDisplayPoolRoomHint() {
            if (!_party.getTaskStatus(_party.getQuestVOByRoomID(_party.CONSTANTS.ROOM_ID_POOL_ROOM))) {
                _party.pebug("HalloweenPartyQuestCommunicator (8F 1) checkDisplayPoolRoomHint()");
                _questCommunicatorTimeout = setTimeout(com.clubpenguin.util.Delegate.create(_this, displayPoolRoomHint), 180 * SECOND);
            }
        }
        static function displayPoolRoomHint() {
            _party.pebug("HalloweenPartyQuestCommunicator (8F 1) displayPoolRoomHint()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_POOL_PUZZLE_HINT, EXPRESSION_SKIP_1);
            clearTimeouts();
            var _local_1 = _party.getQuestVOByRoomID(_party.CONSTANTS.ROOM_ID_POOL_ROOM);
            _party.sendQuestCommunicatorBI(_local_1.questIndex, "pool_puzzle");
        }
        static function checkDisplayLibraryRoomHint() {
            if (!_party.getTaskStatus(_party.getQuestVOByRoomID(_party.CONSTANTS.ROOM_ID_LIBRARY))) {
                _party.pebug("HalloweenPartyQuestCommunicator (9F 1) checkDisplayLibraryRoomHint()");
                _questCommunicatorTimeout = setTimeout(com.clubpenguin.util.Delegate.create(_this, displayLibraryRoomHint), 180 * SECOND);
            }
        }
        static function displayLibraryRoomHint() {
            _party.pebug("HalloweenPartyQuestCommunicator (9F 1) displayLibraryRoomHint()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_LIBRARY_PUZZLE_HINT, EXPRESSION_SKIP_1);
            clearTimeouts();
            var _local_1 = _party.getQuestVOByRoomID(_party.CONSTANTS.ROOM_ID_LIBRARY);
            _party.sendQuestCommunicatorBI(_local_1.questIndex, "library_puzzle");
        }
        static function checkDisplayEmptyRoomMessage2() {
            _party.pebug("HalloweenPartyQuestCommunicator (7F 1) checkDisplayEmptyRoomMessage()");
            _questCommunicatorTimeout = setTimeout(com.clubpenguin.util.Delegate.create(_this, displayEmptyRoomMessage2), 60 * SECOND);
        }
        static function displayEmptyRoomMessage2() {
            _party.pebug("HalloweenPartyQuestCommunicator (7F 1) displayEmptyRoomMessage()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_EMPTY_FLOOR_MESSAGE_2, EXPRESSION_SKIP_2);
            clearTimeouts();
            _party.sendQuestCommunicatorBI(-1, "empty_room_2");
        }
        static function checkDisplayBalconyRoomHint() {
            if (!_party.getTaskStatus(_party.getQuestVOByRoomID(_party.CONSTANTS.ROOM_ID_BALCONY))) {
                _party.pebug("HalloweenPartyQuestCommunicator (11F 1) checkDisplayBalconyRoomHint()");
                _questCommunicatorTimeout = setTimeout(com.clubpenguin.util.Delegate.create(_this, displayBalconyRoomHint), 180 * SECOND);
            }
        }
        static function displayBalconyRoomHint() {
            _party.pebug("HalloweenPartyQuestCommunicator (11F 1) displayBalconyRoomHint()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_BALCONY_PUZZLE_HINT, EXPRESSION_SKIP_1);
            clearTimeouts();
            checkDisplayBalconyRoomHint2();
            var _local_1 = _party.getQuestVOByRoomID(_party.CONSTANTS.ROOM_ID_BALCONY);
            _party.sendQuestCommunicatorBI(_local_1.questIndex, "balcony_puzzle");
        }
        static function checkDisplayBalconyRoomHint2() {
            if (!_party.getTaskStatus(_party.getQuestVOByRoomID(_party.CONSTANTS.ROOM_ID_BALCONY))) {
                _party.pebug("HalloweenPartyQuestCommunicator (11F 2) checkDisplayBalconyRoomHint()");
                _questCommunicatorTimeout = setTimeout(com.clubpenguin.util.Delegate.create(_this, displayBalconyRoomHint2), 60 * SECOND);
            }
        }
        static function displayBalconyRoomHint2() {
            _party.pebug("HalloweenPartyQuestCommunicator (11F 2) displayBalconyRoomHint()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_BALCONY_PUZZLE_HINT_2, EXPRESSION_SKIP_1);
            clearTimeouts();
            var _local_1 = _party.getQuestVOByRoomID(_party.CONSTANTS.ROOM_ID_BALCONY);
            _party.sendQuestCommunicatorBI(_local_1.questIndex, "balcony_puzzle_2");
        }
        static function displayGargoyleIncorrectResponse() {
            _party.pebug("HalloweenPartyQuestCommunicator (11F 4) displayGargoyleIncorrectResponse()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_BALCONY_WRONG_RESPONSE, EXPRESSION_CARMAD);
            var _local_1 = _party.getQuestVOByRoomID(_party.CONSTANTS.ROOM_ID_BALCONY);
            _party.sendQuestCommunicatorBI(_local_1.questIndex, "balcony_wrong_answer");
        }
        static function checkDisplayFloor12Messages() {
            _party.pebug("HalloweenPartyQuestCommunicator (12F 4) _party.partyCookie.areItemsCollected()  " + _party.partyCookie.areItemsCollected());
            if (_party.partyCookie.areItemsCollected()) {
                displayFloor12PiecesCollected();
            } else if (_party.partyCookie.hasPlayerVisitedFloor12) {
                _party.pebug("HalloweenPartyQuestCommunicator (12F 4) checkDisplayFloor12Hint()");
                _questCommunicatorTimeout = setTimeout(com.clubpenguin.util.Delegate.create(_this, displayFloor12Hint), 60 * SECOND);
            } else {
                displayFloor12IntroMessages();
            }
        }
        static function displayFloor12IntroMessages() {
            _party.pebug("HalloweenPartyQuestCommunicator (12F 1,3,5) displayFloor12IntroMessages()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_FLOOR_12_INTRO_1, EXPRESSION_SKIP_2);
            sendCommunicatorMessage(_party.CONSTANTS.QC_FLOOR_12_INTRO_2, EXPRESSION_SKIP_1);
            sendCommunicatorMessage(_party.CONSTANTS.QC_FLOOR_12_INTRO_3, EXPRESSION_SKIP_2);
            _party.sendQuestCommunicatorBI(-1, "floor_12_intro");
        }
        static function displayFloor12Hint() {
            _party.pebug("HalloweenPartyQuestCommunicator (12F 4) displayFloor12Hint()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_FLOOR_12_HINT, EXPRESSION_SKIP_1);
            clearTimeouts();
            _party.sendQuestCommunicatorBI(-1, "floor_12_hint");
        }
        static function displayFloor12PiecesCollected() {
            _party.pebug("HalloweenPartyQuestCommunicator (12F 2) displayFloor12PiecesCollected()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_FLOOR_12_PIECES_COLLECTED, EXPRESSION_SKIP_1);
            checkDisplayFloor12PlatformHint();
            _party.sendQuestCommunicatorBI(-1, "floor_12_complete");
        }
        static function checkDisplayFloor12PlatformHint() {
            _party.pebug("HalloweenPartyQuestCommunicator (12F 6) checkDisplayFloor12PlatformHint()");
            _questCommunicatorTimeout = setTimeout(com.clubpenguin.util.Delegate.create(_this, displayFloor12PlatformHint), 60 * SECOND);
        }
        static function displayFloor12PlatformHint() {
            _party.pebug("HalloweenPartyQuestCommunicator (12F 6) displayFloor12PlatformHint()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_FLOOR_12_PLATFORM_HINT, EXPRESSION_SKIP_1);
            clearTimeouts();
            _party.sendQuestCommunicatorBI(-1, "floor_12_platform");
        }
        static function displayFloor12SkipCongrats() {
            clearTimeouts();
            _party.pebug("HalloweenPartyQuestCommunicator (12F 7) displayFloor12SkipCongrats()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_FLOOR_12_SKIP_CONGRATS, EXPRESSION_SKIP_1);
            _party.sendQuestCommunicatorBI(-1, "floor_12_skip_congrats");
        }
        static function displayFloor12SkipEvil() {
            _party.pebug("HalloweenPartyQuestCommunicator (12F 8) displayFloor12SkipEvil()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_FLOOR_12_SKIP_EVIL, EXPRESSION_SKIP_3);
            _party.sendQuestCommunicatorBI(-1, "floor_12_skip_evil");
        }
        static function displayFloor13GariwaldIntro() {
            _party.pebug("HalloweenPartyQuestCommunicator (13F 1) displayFloor13GariwaldIntro()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_FLOOR_13_GARIWALD_INTRO, EXPRESSION_GARIWALD_2);
            var _local_1 = _party.getQuestVOByRoomID(_party.CONSTANTS.ROOM_ID_13TH_FLOOR_SOLO);
            _party.sendQuestCommunicatorBI(_local_1.questIndex, "floor_13_gariwald_intro");
            checkDisplayFloor13Hint();
        }
        static function checkDisplayFloor13Hint() {
            _party.pebug("HalloweenPartyQuestCommunicator (13F 2) checkDisplayFloor13Hint()");
            _questCommunicatorTimeout = setTimeout(com.clubpenguin.util.Delegate.create(_this, displayFloor13Hint), 60 * SECOND);
        }
        static function displayFloor13Hint() {
            _party.pebug("HalloweenPartyQuestCommunicator (13F 2) displayFloor13Hint()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_FLOOR_13_HINT_1, EXPRESSION_GARIWALD_1);
            var _local_1 = _party.getQuestVOByRoomID(_party.CONSTANTS.ROOM_ID_13TH_FLOOR_SOLO);
            _party.sendQuestCommunicatorBI(_local_1.questIndex, "floor_13_fusebox");
        }
        static function checkDisplayFloor13Hint2() {
            clearTimeouts();
            _party.pebug("HalloweenPartyQuestCommunicator (13F 3) checkDisplayFloor13Hint2()");
            _questCommunicatorTimeout = setTimeout(com.clubpenguin.util.Delegate.create(_this, displayFloor13Hint2), 15 * SECOND);
        }
        static function displayFloor13Hint2() {
            _party.pebug("HalloweenPartyQuestCommunicator (13F 3) displayFloor13Hint2()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_FLOOR_13_HINT_2, EXPRESSION_GARIWALD_1);
            var _local_1 = _party.getQuestVOByRoomID(_party.CONSTANTS.ROOM_ID_13TH_FLOOR_SOLO);
            _party.sendQuestCommunicatorBI(_local_1.questIndex, "floor_13_button");
        }
        static function displayFloor13GhostStop() {
            _party.pebug("HalloweenPartyQuestCommunicator (13F 4) displayFloor13GhostStop()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_FLOOR_13_GHOST_STOP, EXPRESSION_GHOST_1);
            var _local_1 = _party.getQuestVOByRoomID(_party.CONSTANTS.ROOM_ID_13TH_FLOOR_SOLO);
            _party.sendQuestCommunicatorBI(_local_1.questIndex, "floor_13_ghost_stop");
        }
        static function checkDisplayFloor13Hint3() {
            clearTimeouts();
            _party.pebug("HalloweenPartyQuestCommunicator (13F 5) checkDisplayFloor13Hint3()");
            _questCommunicatorTimeout = setTimeout(com.clubpenguin.util.Delegate.create(_this, displayFloor13Hint3), 60 * SECOND);
        }
        static function displayFloor13Hint3() {
            _party.pebug("HalloweenPartyQuestCommunicator (13F 5) displayFloor13Hint3()");
            sendCommunicatorMessage(_party.CONSTANTS.QC_FLOOR_13_HINT_3, EXPRESSION_GARIWALD_3);
            clearTimeouts();
            var _local_1 = _party.getQuestVOByRoomID(_party.CONSTANTS.ROOM_ID_13TH_FLOOR_SOLO);
            _party.sendQuestCommunicatorBI(_local_1.questIndex, "floor_13_debris");
        }
        static var _this = com.clubpenguin.world.rooms2014.halloween.party.HalloweenPartyQuestCommunicator;
        static var _initialized = false;
        static var SECOND = 1000;
        static var EXPRESSION_GARY_1 = 0;
        static var EXPRESSION_SKIP_1 = 1;
        static var EXPRESSION_SKIP_2 = 2;
        static var EXPRESSION_SKIP_3 = 3;
        static var EXPRESSION_GARIWALD_1 = 4;
        static var EXPRESSION_GARIWALD_2 = 5;
        static var EXPRESSION_GARIWALD_3 = 6;
        static var EXPRESSION_CARMAD = 7;
        static var EXPRESSION_GHOST_1 = 8;
        static var EXPRESSION_GHOST_2 = 9;
    }
