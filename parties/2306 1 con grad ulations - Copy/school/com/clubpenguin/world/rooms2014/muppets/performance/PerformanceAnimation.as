//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.muppets.performance.PerformanceAnimation
    {
        var _shell, _interface, _engine, _party;
        function PerformanceAnimation (swfName, hostId, participantId, callback) {
            com.clubpenguin.util.Log.info("PerformanceAnimation " + swfName);
            _shell = _global.getCurrentShell();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _party = _global.getCurrentParty();
            var _local_7 = _engine.getPlayerMovieClip(hostId);
            var _local_10 = _local_7.getNextHighestDepth();
            var _local_6 = _engine.getRoomMovieClip();
            var _local_4 = ((_local_6["performance_" + hostId] == undefined) ? (_local_6.createEmptyMovieClip("performance_" + hostId, _local_10)) : (_local_6["performance_" + hostId]));
            _engine.updateItemDepth(_local_4, _local_7.getDepth());
            if (_local_4[(("performance_" + hostId) + "_") + swfName] == undefined) {
                var _local_8 = _local_4.createEmptyMovieClip((("performance_" + hostId) + "_") + swfName, _local_4.getNextHighestDepth());
                var _local_11 = ((_shell.getGlobalContentPath() + PERFORMANCE_ASSETS_PATH) + swfName) + ".swf";
                var _local_9 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
                _local_9.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, handleExternalAssetLoaded, _local_8, hostId, participantId, callback));
                _local_9.loadClip(_local_11, _local_8, "AvatarManager loadAnimations() " + swfName);
            } else {
                com.clubpenguin.util.Log.info("PerformanceAnimation showing existing anim");
                _local_4[(("performance_" + hostId) + "_") + swfName]._visible = true;
                handleExternalAssetLoaded(undefined, _local_4[(("performance_" + hostId) + "_") + swfName], hostId, participantId, callback);
            }
        }
        function handleExternalAssetLoaded(event, performanceMC, hostId, participantId, callback) {
            com.clubpenguin.util.Log.info("PerformanceAnimation loaded");
            performanceMC.gotoAndStop(1);
            performanceMC.host.gotoAndStop(1);
            performanceMC.participant.gotoAndStop(1);
            var _local_3 = _engine.getPlayerMovieClip(hostId);
            performanceMC._x = _local_3._x;
            performanceMC._y = _local_3._y;
            com.clubpenguin.util.Log.info("PerformanceAnimation playerMC scale " + _local_3._xscale);
            performanceMC._xscale = (performanceMC._yscale = _local_3._xscale);
            var _local_4 = Number(_shell.getPlayerHexFromId(_shell.getPlayerObjectById(hostId).colour_id));
            _shell.setColourFromHex(performanceMC.host, Number(_local_4));
            _local_4 = Number(_shell.getPlayerHexFromId(_shell.getPlayerObjectById(participantId).colour_id));
            _shell.setColourFromHex(performanceMC.participant, Number(_local_4));
            var _local_6 = new com.clubpenguin.world.rooms2013.common.CallbackAnimation(performanceMC, com.clubpenguin.util.Delegate.create(this, onAnimationComplete, performanceMC, hostId, callback));
            performanceMC.host.gotoAndPlay(1);
            performanceMC.participant.gotoAndPlay(1);
        }
        function onAnimationComplete(performanceMC, hostId, callback) {
            com.clubpenguin.util.Log.info("PerformanceAnimation onAnimationComplete callback " + callback);
            callback();
        }
        function clean(hostId) {
            com.clubpenguin.util.Log.info("PerformanceAnimation Clean " + hostId);
            var _local_4 = _engine.getRoomMovieClip();
            var _local_5 = _shell.getPlayerObjectById(hostId);
            var _local_3 = _party.MuppetsParty.getMuppetByInteractiveItem(_local_5.hand);
            _local_4["performance_" + hostId][(("performance_" + hostId) + "_muppets_") + _local_3]._visible = false;
        }
        static var PERFORMANCE_ASSETS_PATH = "avatar/sprites/";
    }
