
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.games.dancing.data.SongData
    {
        function SongData () {
        }
        static function getSongData($song, $difficulty) {
            var _local2 = getSongLength($song);
            var _local4 = getMillisPerBar($song);
            var _local1 = _local4 / BEATS_PER_BAR;
            switch ($song) {
                case com.clubpenguin.games.dancing.GameEngine.SONG_ONE : 
                    switch ($difficulty) {
                        case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EASY : 
                            return(com.clubpenguin.games.dancing.data.Song1Easy.getSongData(_local1));
                        case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_MEDIUM : 
                            return(com.clubpenguin.games.dancing.data.Song1Medium.getSongData(_local1));
                        case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_HARD : 
                            return(com.clubpenguin.games.dancing.data.Song1Hard.getSongData(_local1));
                        case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EXPERT : 
                            return(getExpertSongData(_local1, _local2));
                    }
                    break;
                case com.clubpenguin.games.dancing.GameEngine.SONG_TWO : 
                    switch ($difficulty) {
                        case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EASY : 
                            return(com.clubpenguin.games.dancing.data.Song2Easy.getSongData(_local1));
                        case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_MEDIUM : 
                            return(com.clubpenguin.games.dancing.data.Song2Medium.getSongData(_local1));
                        case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_HARD : 
                            return(com.clubpenguin.games.dancing.data.Song2Hard.getSongData(_local1));
                        case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EXPERT : 
                            return(getExpertSongData(_local1, _local2));
                    }
                    break;
                case com.clubpenguin.games.dancing.GameEngine.SONG_THREE : 
                    switch ($difficulty) {
                        case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EASY : 
                            return(com.clubpenguin.games.dancing.data.Song3Easy.getSongData(_local1));
                        case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_MEDIUM : 
                            return(com.clubpenguin.games.dancing.data.Song3Medium.getSongData(_local1));
                        case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_HARD : 
                            return(com.clubpenguin.games.dancing.data.Song3Hard.getSongData(_local1));
                        case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EXPERT : 
                            return(getExpertSongData(_local1, _local2));
                    }
                    break;
                case com.clubpenguin.games.dancing.GameEngine.SONG_FOUR : 
                    switch ($difficulty) {
                        case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EASY : 
                            return(com.clubpenguin.games.dancing.data.Song4Easy.getSongData(_local1));
                        case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_MEDIUM : 
                            return(com.clubpenguin.games.dancing.data.Song4Medium.getSongData(_local1));
                        case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_HARD : 
                            return(com.clubpenguin.games.dancing.data.Song4Hard.getSongData(_local1));
                        case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EXPERT : 
                            return(getExpertSongData(_local1, _local2));
                    }
                    break;
                case com.clubpenguin.games.dancing.GameEngine.SONG_FIVE : 
                    switch ($difficulty) {
                        case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EASY : 
                            return(com.clubpenguin.games.dancing.data.Song5Easy.getSongData(_local1));
                        case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_MEDIUM : 
                            return(com.clubpenguin.games.dancing.data.Song5Medium.getSongData(_local1));
                        case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_HARD : 
                            return(com.clubpenguin.games.dancing.data.Song5Hard.getSongData(_local1));
                        case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EXPERT : 
                            return(getExpertSongData(_local1, _local2));
                    }
                    break;
                case com.clubpenguin.games.dancing.GameEngine.SONG_SIX : 
                    switch ($difficulty) {
                        case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EASY : 
                            return(com.clubpenguin.games.dancing.data.Song6Easy.getSongData(_local1));
                        case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_MEDIUM : 
                            return(com.clubpenguin.games.dancing.data.Song6Medium.getSongData(_local1));
                        case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_HARD : 
                            return(com.clubpenguin.games.dancing.data.Song6Hard.getSongData(_local1));
                        case com.clubpenguin.games.dancing.GameEngine.DIFFICULTY_EXPERT : 
                            return(getExpertSongData(_local1, _local2));
                    }
                    break;
            }
            return(undefined);
        }
        static function getMillisPerBar($song) {
            switch ($song) {
                case com.clubpenguin.games.dancing.GameEngine.SONG_ONE : 
                    return(2000);
                case com.clubpenguin.games.dancing.GameEngine.SONG_TWO : 
                    return(2070);
                case com.clubpenguin.games.dancing.GameEngine.SONG_THREE : 
                    return(2666);
                case com.clubpenguin.games.dancing.GameEngine.SONG_FOUR : 
                    return(1714);
                case com.clubpenguin.games.dancing.GameEngine.SONG_FIVE : 
                    return(2181);
                case com.clubpenguin.games.dancing.GameEngine.SONG_SIX : 
                    return(2790);
            }
            return(undefined);
        }
        static function getSongLength($song) {
            switch ($song) {
                case com.clubpenguin.games.dancing.GameEngine.SONG_ONE : 
                    return(241);
                case com.clubpenguin.games.dancing.GameEngine.SONG_TWO : 
                    return(221);
                case com.clubpenguin.games.dancing.GameEngine.SONG_THREE : 
                    return(176);
                case com.clubpenguin.games.dancing.GameEngine.SONG_FOUR : 
                    return(288);
                case com.clubpenguin.games.dancing.GameEngine.SONG_FIVE : 
                    return(248);
                case com.clubpenguin.games.dancing.GameEngine.SONG_SIX : 
                    return(168);
            }
            return(undefined);
        }
        static function getSongLengthMillis($song) {
            switch ($song) {
                case com.clubpenguin.games.dancing.GameEngine.SONG_ONE : 
                    return(123000);
                case com.clubpenguin.games.dancing.GameEngine.SONG_TWO : 
                    return(117000);
                case com.clubpenguin.games.dancing.GameEngine.SONG_THREE : 
                    return(124000);
                case com.clubpenguin.games.dancing.GameEngine.SONG_FOUR : 
                    return(130000);
                case com.clubpenguin.games.dancing.GameEngine.SONG_FIVE : 
                    return(139000);
                case com.clubpenguin.games.dancing.GameEngine.SONG_SIX : 
                    return(118000);
            }
            return(undefined);
        }
        static function getExpertSongData($millisPerBeat, $songLength) {
            var _local4 = new Array();
            var _local3 = new Array();
            var _local2 = new Array();
            var _local5 = new Array(0, 0, 0, 0);
            var _local1 = 4;
            while (_local1 < $songLength) {
                if ((_local1 % 8) == 0) {
                    addNote(_local1, 4, _local5, $millisPerBeat, _local2, _local3, _local4);
                    if (Math.floor(Math.random() * 2) == 0) {
                        addNote(_local1, 0, _local5, $millisPerBeat, _local2, _local3, _local4);
                    }
                } else if ((_local1 % 4) == 0) {
                    addNote(_local1, 4, _local5, $millisPerBeat, _local2, _local3, _local4);
                    if (Math.floor(Math.random() * 4) == 0) {
                        addNote(_local1, 0, _local5, $millisPerBeat, _local2, _local3, _local4);
                    }
                } else if ((_local1 % 2) == 0) {
                    addNote(_local1, 2, _local5, $millisPerBeat, _local2, _local3, _local4);
                } else if (Math.floor(Math.random() * 4) > 0) {
                    addNote(_local1, 0, _local5, $millisPerBeat, _local2, _local3, _local4);
                    if (Math.floor(Math.random() * 4) == 0) {
                        addNote(_local1 + 0.5, 0, _local5, $millisPerBeat, _local2, _local3, _local4);
                    }
                }
                _local1++;
            }
            addNote($songLength, 0, _local5, $millisPerBeat, _local2, _local3, _local4);
            return(new Array(_local2, _local3, _local4));
        }
        static function addNote($beatTime, $maxBeatLength, $lastNoteTimes, $millisPerBeat, $noteTypes, $noteTimes, $noteLengths) {
            var _local3 = Math.floor(Math.random() * $maxBeatLength) * $millisPerBeat;
            var _local2 = $beatTime * $millisPerBeat;
            var _local1 = Math.floor(Math.random() * 4);
            if (_local2 > $lastNoteTimes[_local1]) {
                $noteTypes.push(_local1);
                $noteTimes.push(_local2);
                $noteLengths.push(_local3);
                $lastNoteTimes[_local1] = _local2 + _local3;
            }
        }
        static var BEATS_PER_BAR = 4;
    }
