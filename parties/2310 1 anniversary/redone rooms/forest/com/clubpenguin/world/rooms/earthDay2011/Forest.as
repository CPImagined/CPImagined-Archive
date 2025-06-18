//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.earthDay2011.Forest extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, hideRoomElements, setupScavengerHunt, _SHELL, _interactiveMusic, _locationBasedMusicController;
        function Forest (stageReference) {
            super();
            trace("Forest()");
            _stage = stageReference;
            hideRoomElements();
            _stage.start_x = 325;
            _stage.start_y = 375;
            setupScavengerHunt(_stage.foreground_mc.egg2_btn, 2, null);
            _stage.triggers_mc.what_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, lakeExit);
            _stage.triggers_mc.shack_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, shackExit);
            _stage.triggers_mc.cove_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, coveExit);
            _stage.triggers_mc.plaza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, plazaExit);
            _stage.foreground_mc.egg2play_btn.onPress = com.clubpenguin.util.Delegate.create(this, scavengerAnimationPlay);
            if (_SHELL == undefined) {
                init();
            }
        }
        function lakeExit() {
            trace("Forest: lakeExit()");
            _SHELL.sendJoinRoom("lake", 220, 160);
        }
        function shackExit() {
            trace("Forest: shackExit()");
            _SHELL.sendJoinRoom("shack", 250, 400);
        }
        function coveExit() {
            trace("Forest: coveExit()");
            _SHELL.sendJoinRoom("cove", 260, 208);
        }
        function plazaExit() {
            trace("Forest: plazaExit()");
            _SHELL.sendJoinRoom("plaza", 620, 330);
        }
        function scavengerAnimationPlay() {
            trace("Forest: scavengerAnimationPlay()");
            _stage.foreground_mc.play();
        }
        function init() {
            trace("Forest: init()");
            _interactiveMusic = new com.clubpenguin.world.rooms.common.InteractiveMusic(_stage, ["soundBass", "soundFlute", "soundOrgan", "soundPiano", "soundTrumpet"]);
            _locationBasedMusicController = new com.clubpenguin.world.rooms.common.LocationBasedMusicController(_SHELL, _interactiveMusic, [_stage.triggers_mc.frog1, _stage.triggers_mc.frog2, _stage.triggers_mc.frog3, _stage.triggers_mc.frog4, _stage.triggers_mc.frog5], [_stage.frog1, _stage.frog2, _stage.island.frog3, _stage.frog4, _stage.farRight.frog5]);
        }
    }
