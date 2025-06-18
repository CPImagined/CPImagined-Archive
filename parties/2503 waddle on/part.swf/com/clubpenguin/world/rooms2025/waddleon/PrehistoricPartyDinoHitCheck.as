
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyDinoHitCheck
    {
        var _shell, _engine;
        function PrehistoricPartyDinoHitCheck () {
            _shell = _global.getCurrentShell();
            _engine = _global.getCurrentEngine();
        }
        function hitCheck(_arg_2) {
            var _local_4 = _shell.getPlayerObjectById(_arg_2.player_id);
            var _local_3 = _shell.getPlayerObjectById(_arg_2.hit_player_id);
            if (_arg_2.hit_player_id != _arg_2.player_id) {
                if (com.clubpenguin.world.rooms2025.waddleon.WaddleOnParty.isDinosaur(_arg_2.hit_player_id)) {
                    //if (_arg_2.snowballType == com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_FOOD) {
                        _engine.updatePlayerFrame(_local_3.player_id, com.clubpenguin.world.rooms2025.waddleon.PrehistoricPartyConstants.EAT_FRAME);
                        com.clubpenguin.world.rooms2025.waddleon.DinoSounds.onDinoEatStart(_shell.getPlayerObjectById(_local_3.player_id));
                        _arg_2.snowballMC._visible = false;
                    //}
                }
            }
        }
    }
