//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.InteractiveMusic
    {
        var tracksAmount;
        function InteractiveMusic (stageReference, inputTracks) {
            trace("InteractiveMusic()");
            tracksAmount = inputTracks.length;
            var _local_2 = 0;
            while (_local_2 < tracksAmount) {
                var _local_3 = stageReference.createEmptyMovieClip(("track" + _local_2) + "Clip", stageReference.getNextHighestDepth() + _local_2);
                _tracks[_local_2] = new Sound(_local_3);
                _tracks[_local_2].attachSound(inputTracks[_local_2]);
                _tracks[_local_2].start(0, 999);
                _tracks[_local_2].setVolume(0);
                _local_2++;
            }
        }
        function muteTrack(track) {
            trace(("InteractiveMusic: muteTrack(" + track) + ")");
            if (_tracks[track] == undefined) {
                trace(("\tERROR _tracks[" + track) + "] is undefined");
            }
            _tracks[track].setVolume(0);
        }
        function unMuteTrack(track) {
            trace(("InteractiveMusic: unMuteTrack(" + track) + ")");
            if (_tracks[track] == undefined) {
                trace(("\tERROR _tracks[" + track) + "] is undefined");
            }
            _tracks[track].setVolume(100);
        }
        var _tracks = [];
    }
