//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.cfc.trains.TrainLoader
    {
        static var _SHELL, _ENGINE;
        function TrainLoader () {
        }
        static function init() {
            _SHELL = _global.getCurrentShell();
            _ENGINE = _global.getCurrentEngine();
        }
        static function addPenguinToTrain(player_id) {
            var _local_4 = _SHELL.getPlayerObjectById(player_id);
            var _local_5 = _ENGINE.getPlayerMovieClip(player_id);
            var _local_7 = _local_5["trainfront_" + player_id];
            var _local_8 = _local_5["trainback_" + player_id];
            if ((_local_7 != undefined) && (_local_8 != undefined)) {
                showTrain(_local_7, _local_8, player_id);
                return(undefined);
            }
            var _local_2;
            var _local_9 = _global.getCurrentRoom().trainManager.getPlayerTrain(player_id).driverId;
            var _local_10 = _SHELL.getPlayerObjectById(_local_9);
            var _local_6 = _local_10.hand;
            switch (_local_6) {
                case com.clubpenguin.world.rooms2013.cfc.CFCParty.CONSTANTS.TRAIN_1_ID : 
                    _local_2 = "HOLIDAY";
                    break;
                case com.clubpenguin.world.rooms2013.cfc.CFCParty.CONSTANTS.TRAIN_2_ID : 
                    _local_2 = "PUFFLE";
                    break;
                case com.clubpenguin.world.rooms2013.cfc.CFCParty.CONSTANTS.TRAIN_3_ID : 
                    _local_2 = "SWEETTOOTH";
                    break;
                case com.clubpenguin.world.rooms2013.cfc.CFCParty.CONSTANTS.TRAIN_4_ID : 
                    _local_2 = "RAINBOW";
                    break;
                default : 
                    com.clubpenguin.world.rooms2013.cfc.CFCParty.pebug("Driver does not appear to have an itemID that is a train item, hand item id is " + _local_6);
                    return(undefined);
            }
            loadTrainPart(com.clubpenguin.world.rooms2013.cfc.trains.TrainLoader[_local_2 + "_TRAIN_FRONT_SWF_NAME"], _local_4);
            loadTrainPart(com.clubpenguin.world.rooms2013.cfc.trains.TrainLoader[_local_2 + "_TRAIN_BACK_SWF_NAME"], _local_4);
        }
        static function showTrain(TrainFrontMC, TrainBackMC, player_id) {
            TrainFrontMC._visible = true;
            TrainBackMC._visible = true;
            _ENGINE.updatePlayer(_SHELL.getPlayerObjectById(player_id));
        }
        static function loadTrainPart(TrainPart, playerObj) {
            var _local_3;
            var _local_1 = _ENGINE.getPlayerMovieClip(playerObj.player_id);
            var _local_2 = _local_1.art_mc.getDepth();
            var _local_8 = _local_1.head_mc.getDepth();
            _local_2 = (isFrontTrainPart(TrainPart) ? (Number(_local_8 + 1)) : (Number(_local_2 - 1)));
            var _local_7 = (isFrontTrainPart(TrainPart) ? "trainfront" : "trainback");
            _local_3 = _local_1.createEmptyMovieClip((_local_7 + "_") + playerObj.player_id, _local_2);
            var _local_9 = ((_SHELL.getGlobalContentPath() + "rooms/effects/") + TrainPart) + ".swf";
            var _local_5 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            _local_5.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.cfc.trains.TrainLoader, handleExternalAssetLoaded, playerObj.player_id, _local_3));
            _local_5.loadClip(_local_9, _local_3, "AvatarManager loadAnimations() " + TrainPart);
        }
        static function isFrontTrainPart(partName) {
            return((((((partName == PUFFLE_TRAIN_FRONT_SWF_NAME) || (partName == HOLIDAY_TRAIN_FRONT_SWF_NAME)) || (partName == SWEETTOOTH_TRAIN_FRONT_SWF_NAME)) || (partName == RAINBOW_TRAIN_FRONT_SWF_NAME)) ? true : false));
        }
        static function handleExternalAssetLoaded(event, player_id, TrainMC) {
            TrainMC._xscale = (TrainMC._yscale = TRAIN_SCALE);
            if (com.clubpenguin.world.rooms2013.cfc.CFCParty.isTrainBodyItemEquipped(player_id)) {
                _ENGINE.getPlayerMovieClip(player_id).hand_mc._visible = false;
            }
            _ENGINE.updatePlayer(_SHELL.getPlayerObjectById(player_id));
        }
        static function removePenguinFromTrain(player_id) {
            var _local_2 = _ENGINE.getPlayerMovieClip(player_id);
            if (_local_2 != null) {
                _local_2["trainfront_" + player_id].removeMovieClip();
                _local_2["trainback_" + player_id].removeMovieClip();
                if (com.clubpenguin.world.rooms2013.cfc.CFCParty.isTrainBodyItemEquipped(player_id)) {
                    _ENGINE.getPlayerMovieClip(player_id).hand_mc._visible = true;
                }
                _ENGINE.updatePlayer(_SHELL.getPlayerObjectById(player_id));
            }
        }
        static var PUFFLE_TRAIN_FRONT_SWF_NAME = "puffle_cartfront";
        static var PUFFLE_TRAIN_BACK_SWF_NAME = "puffle_cartback";
        static var HOLIDAY_TRAIN_FRONT_SWF_NAME = "holiday_cartfront";
        static var HOLIDAY_TRAIN_BACK_SWF_NAME = "holiday_cartback";
        static var SWEETTOOTH_TRAIN_FRONT_SWF_NAME = "sweettooth_cartfront";
        static var SWEETTOOTH_TRAIN_BACK_SWF_NAME = "sweettooth_cartback";
        static var RAINBOW_TRAIN_FRONT_SWF_NAME = "rainbowzephyr_cartfront";
        static var RAINBOW_TRAIN_BACK_SWF_NAME = "rainbowzephyr_cartback";
        static var TRAIN_SCALE = 100;
    }
