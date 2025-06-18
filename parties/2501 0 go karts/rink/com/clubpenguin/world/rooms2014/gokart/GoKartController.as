//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.gokart.GoKartController extends com.clubpenguin.world.rooms.common.PropController
    {
        var __set__propScale, _ENGINE, _SHELL, showprop, __get__playersWithProp, handleExternalAssetLoaded;
        function GoKartController () {
            super();
            __set__propScale(PROP_SCALE);
        }
        function addPenguinToProp(playerObj) {
            var _local_4 = _ENGINE.getPlayerMovieClip(playerObj.player_id);
            var _local_2 = _SHELL.getPlayerColorName(_local_4.colour_id);
            trace("penguinColor " + _local_2);
            trace("playerMC.colour_id " + _local_4.colour_id);
            var _local_5 = _local_4[(((PROP_FRONT_SWF_NAME + "_") + _local_2) + "_") + playerObj.player_id];
            var _local_6 = _local_4[(((PROP_BACK_SWF_NAME + "_") + _local_2) + "_") + playerObj.player_id];
            if ((_local_5 != undefined) && (_local_6 != undefined)) {
                showprop(_local_5, _local_6, playerObj.player_id);
                return(undefined);
            }
            if (_local_5 == undefined) {
                loadpropPart((PROP_FRONT_SWF_NAME + "_") + _local_2, playerObj);
            }
            if (_local_6 == undefined) {
                loadpropPart((PROP_BACK_SWF_NAME + "_") + _local_2, playerObj);
            }
        }
        function removePenguinFromProp(player_id) {
            __get__playersWithProp()[player_id] = false;
            var _local_3 = _ENGINE.getPlayerMovieClip(player_id);
            var _local_4 = _SHELL.getPlayerColorName(_local_3.colour_id);
            _local_3[(((PROP_FRONT_SWF_NAME + "_") + _local_4) + "_") + player_id]._visible = false;
            _local_3[(((PROP_BACK_SWF_NAME + "_") + _local_4) + "_") + player_id]._visible = false;
            _ENGINE.updatePlayer(_SHELL.getPlayerObjectById(player_id));
        }
        function loadpropPart(propPart, playerObj) {
            var _local_4;
            var _local_2 = _ENGINE.getPlayerMovieClip(playerObj.player_id);
            var _local_3 = _local_2.art_mc.getDepth();
            var _local_9 = _local_2.head_mc.getDepth();
            var _local_7 = _SHELL.getPlayerColorName(_local_2.colour_id);
            _local_3 = ((propPart == String((PROP_FRONT_SWF_NAME + "_") + _local_7)) ? (Number(_local_9 + 1)) : (Number(_local_3 - 1)));
            _local_4 = _local_2.createEmptyMovieClip((propPart + "_") + playerObj.player_id, _local_3);
            var _local_10 = ((_SHELL.getGlobalContentPath() + com.clubpenguin.world.rooms.common.PropController.PROP_DIRECTORY_PATH) + propPart) + ".swf";
            var _local_6 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            _local_6.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, handleExternalAssetLoaded, playerObj.player_id, _local_4));
            _local_6.loadClip(_local_10, _local_4, "AvatarManager loadAnimations() " + propPart);
        }
        static var PROP_FRONT_SWF_NAME = "gokart_front";
        static var PROP_BACK_SWF_NAME = "gokart_back";
        static var PROP_SCALE = 75;
    }
