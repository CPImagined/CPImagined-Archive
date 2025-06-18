//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.prehistoric.PrehistoricPartyDinoHitCheck
    {
        var _shell, _engine;
        function PrehistoricPartyDinoHitCheck () {
            _shell = _global.getCurrentShell();
            _engine = _global.getCurrentEngine();
        }
        function hitCheck(snowballEvent) {
            var _local_4 = _shell.getPlayerObjectById(snowballEvent.player_id);
            var _local_3 = _shell.getPlayerObjectById(snowballEvent.hit_player_id);
            if (snowballEvent.hit_player_id != snowballEvent.player_id) {
                if (com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.isPrehistoricRoom && (com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.isDinosaur(snowballEvent.hit_player_id))) {
                    if (snowballEvent.snowballType == com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_FOOD) {
                        _engine.updatePlayerFrame(_local_3.player_id, com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.CONSTANTS.EAT_FRAME);
                        com.clubpenguin.world.rooms2014.prehistoric.DinoSounds.onDinoEatStart(_shell.getPlayerObjectById(_local_3.player_id));
                        snowballEvent.snowballMC._visible = false;
                    }
                }
            }
        }
    }
