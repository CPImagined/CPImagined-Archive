//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.PenguinProp
    {
        var propMC, _SHELL, _ENGINE, _BASEPARTY, propPlayerID;
        function PenguinProp (mc) {
            propMC = mc;
            _SHELL = _global.getCurrentShell();
            _ENGINE = _global.getCurrentEngine();
            _BASEPARTY = _global.getCurrentParty().BaseParty;
            _BASEPARTY.pebug("[PenguinProp] Name of the prop " + mc._name);
            var _local_3 = mc._name;
            propPlayerID = Number(_local_3.substr(_local_3.lastIndexOf("_") + 1));
            propMC.gotoAndStop(_ENGINE.getPlayerMovieClip(propPlayerID).art_mc._currentframe);
            var _local_5 = com.clubpenguin.util.Delegate.create(this, handlePlayerFrameUpdate);
            _BASEPARTY.updatePlayerFrame.add(_local_5, this);
            _BASEPARTY.pebug("propPlayerID " + propPlayerID);
        }
        function handlePlayerFrameUpdate(player_id) {
            _BASEPARTY.pebug("[PenguinProp] player_id " + player_id);
            _BASEPARTY.pebug("[PenguinProp] propPlayerID " + propPlayerID);
            if (propPlayerID == player_id) {
                var _local_2 = _ENGINE.getPlayerMovieClip(player_id).art_mc._currentframe;
                propMC.gotoAndStop(Number(_local_2 + 1));
                if (_local_2 == _SHELL.WAVE_FRAME) {
                    propMC.body.gotoAndPlay(1);
                }
            }
        }
    }
