
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.games.dancing.AnimationEngine
    {
        var gameEngine, movie, dancingPenguin, backgroundLightBuffer, hideHUDTimeMillis, timePerFrameMillis, animationTimeMillis;
        function AnimationEngine ($gameEngine, $movie) {
            gameEngine = $gameEngine;
            movie = $movie;
            var _local3 = _global.getCurrentShell();
            hasPurplePuffle = _local3.isItemOnMyPlayer(ITEM_ID_PURPLE_PUFFLE);
            if (movie[BACKGROUND_MOVIECLIP][DANCER_MOVIECLIP] == undefined) {
                debugTrace("cannot find the dancer movieclip!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
            }
            if (movie[ARROWS_MOVIECLIP] == undefined) {
                debugTrace("cannot find the arrows movieclip!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
            }
            movie.closeBtn.onRelease = com.clubpenguin.util.Delegate.create(gameEngine, gameEngine.destroy);
            dancingPenguin = movie[BACKGROUND_MOVIECLIP][DANCER_MOVIECLIP];
            backgroundLightBuffer = new flash.display.BitmapData(movie._width, movie._height, true, 0);
            movie[SCORE_MOVIECLIP].multiplier.gotoAndStop("inactive");
            movie[SCORE_MOVIECLIP].rating.gotoAndStop("inactive");
            movie[SCORE_MOVIECLIP].streakLabel.text = "";
            movie[SCORE_MOVIECLIP].streakValue.text = "";
            movie[SCORE_MOVIECLIP].score.text = "";
            movie[SCORE_MOVIECLIP].scoreValue.text = "";
            movie[SCORE_MOVIECLIP].rating.text = "";
            setMultiplayerScoreVisibility(false);
            showHUD = true;
            hideHUDTimeMillis = getTimer() + (HUD_SHOW_TIME + HUD_SHOW_TIME);
        }
        function setQualityMode($quality) {
            qualityMode = $quality;
            movie[BACKGROUND_MOVIECLIP].lights._visible = qualityMode == QUALITY_HIGH;
        }
        function getQualityMode() {
            return(qualityMode);
        }
        function handleSongSelect($direction) {
            var _local8 = gameEngine.currentSong;
            var _local6 = [255, 255, 255, 16711680, 16711680, 16711680];
            var _local5 = [movie[MENUS_MOVIECLIP].howtoplay.song.chooser.records_mc.disk1_mc.label_mc, movie[MENUS_MOVIECLIP].howtoplay.song.chooser.records_mc.disk2_mc.label_mc, movie[MENUS_MOVIECLIP].howtoplay.song.chooser.records_mc.disk3_mc.label_mc, movie[MENUS_MOVIECLIP].howtoplay.song.chooser.records_mc.disk4_mc.label_mc];
            var _local7 = movie[MENUS_MOVIECLIP].howtoplay.song.chooser.records_mc.badge;
            var _local3 = _local8 + 2;
            var _local4 = new Array();
            if ($direction == DIRECTION_LEFT) {
                movie[MENUS_MOVIECLIP].howtoplay.song.chooser.gotoAndPlay("animateLeft");
            } else if ($direction == DIRECTION_RIGHT) {
                movie[MENUS_MOVIECLIP].howtoplay.song.chooser.gotoAndPlay("animateRight");
            }
            var _local2 = _local5.length - 1;
            while (_local2 >= 0) {
                if (_local3 >= com.clubpenguin.games.dancing.GameEngine.TOTAL_SONGS) {
                    _local3 = _local3 - com.clubpenguin.games.dancing.GameEngine.TOTAL_SONGS;
                }
                _local4[_local2] = new Color(_local5[_local2]);
                _local4[_local2].setRGB(_local6[_local3]);
                _local3++;
                _local2--;
            }
            movie[MENUS_MOVIECLIP].howtoplay.song.songLabel.text = com.clubpenguin.util.LocaleText.getText("menu_song_item_" + _local8);
            _local7._visible = false;
            if ((!gameEngine.isMember()) && (_local8 >= 3)) {
                _local7._visible = true;
            }
        }
        function startSong($timePerFrameMillis) {
            timePerFrameMillis = $timePerFrameMillis;
            animationTimeMillis = 0;
            specialMove = SPECIAL_NONE;
            updateCurrentRating(RATING_OK, 0);
        }
        function endSong() {
            movie[BACKGROUND_MOVIECLIP].crowd.gotoAndStop(1);
            if (movie[BACKGROUND_MOVIECLIP].discoBall._currentframe != 1) {
                movie[BACKGROUND_MOVIECLIP].discoBall.gotoAndPlay("NoteStreakLost");
            }
            movie[SCORE_MOVIECLIP].multiplier.gotoAndStop("inactive");
            movie[SCORE_MOVIECLIP].rating.gotoAndStop("inactive");
            movie[SCORE_MOVIECLIP].streakLabel.text = "";
            movie[SCORE_MOVIECLIP].streakValue.text = "";
            movie[SCORE_MOVIECLIP].score.text = "";
            movie[SCORE_MOVIECLIP].scoreValue.text = "";
            movie[SCORE_MOVIECLIP].rating.text = "";
            movie[SCORE_MOVIECLIP].streakPopup.gotoAndStop("inactive");
            setMultiplayerScoreVisibility(false);
            var _local2 = 1;
            while (_local2 <= 10) {
                movie[SCORE_MOVIECLIP].combo["light" + _local2].gotoAndStop(1);
                _local2++;
            }
            var _local3 = new flash.geom.ColorTransform();
            var _local4;
            _local4 = new flash.geom.Transform(movie[BACKGROUND_MOVIECLIP].lights.ambience);
            _local3.rgb = COLOUR_WHITE;
            _local4.colorTransform = _local3;
            _local4 = new flash.geom.Transform(movie[BACKGROUND_MOVIECLIP].lights.animation.light1);
            _local3.rgb = COLOUR_WHITE;
            _local4.colorTransform = _local3;
            _local4 = new flash.geom.Transform(movie[BACKGROUND_MOVIECLIP].lights.animation.light2);
            _local3.rgb = COLOUR_WHITE;
            _local4.colorTransform = _local3;
            _local4 = new flash.geom.Transform(movie[BACKGROUND_MOVIECLIP].lights.animation.light3);
            _local3.rgb = COLOUR_WHITE;
            _local4.colorTransform = _local3;
            movie[BACKGROUND_MOVIECLIP].speakerLeft.gotoAndStop("inactive");
            movie[BACKGROUND_MOVIECLIP].speakerRight.gotoAndStop("inactive");
            movie[BACKGROUND_MOVIECLIP].lights.gotoAndStop("inactive");
        }
        function updateHUD() {
            var _local2 = getTimer();
            if (movie._ymouse < 50) {
                if (!showHUD) {
                    showHUD = true;
                    movie.qualityBtn.gotoAndStop("fadeIn");
                }
                hideHUDTimeMillis = _local2 + HUD_SHOW_TIME;
            }
            if (showHUD) {
                if (_local2 > hideHUDTimeMillis) {
                    showHUD = false;
                    movie.qualityBtn.gotoAndStop("fadeOut");
                }
            }
        }
        function updateBackground() {
            var _local9 = gameEngine.elapsedTimeMillis;
            var _local8 = gameEngine.currentSong;
            var _local10 = gameEngine.currentMultiplier;
            if ((qualityMode == QUALITY_MEDIUM) || (qualityMode == QUALITY_LOW)) {
                movie[BACKGROUND_MOVIECLIP].lights._visible = false;
                return(undefined);
            }
            movie[BACKGROUND_MOVIECLIP].lights._visible = true;
            var _local15 = ((_local9 % (com.clubpenguin.games.dancing.data.SongData.getMillisPerBar(_local8) / 2)) / com.clubpenguin.games.dancing.data.SongData.getMillisPerBar(_local8)) * 2;
            var _local12 = Math.round(movie[BACKGROUND_MOVIECLIP].speakerLeft.animation._totalframes * _local15);
            movie[BACKGROUND_MOVIECLIP].speakerLeft.animation.gotoAndStop(_local12);
            movie[BACKGROUND_MOVIECLIP].speakerRight.animation.gotoAndStop(_local12);
            _local15 = ((_local9 % (com.clubpenguin.games.dancing.data.SongData.getMillisPerBar(_local8) * 2)) / com.clubpenguin.games.dancing.data.SongData.getMillisPerBar(_local8)) / 2;
            _local12 = Math.round(movie[BACKGROUND_MOVIECLIP].lights.animation._totalframes * _local15);
            movie[BACKGROUND_MOVIECLIP].lights.animation.gotoAndStop(_local12);
            var _local5;
            var _local3;
            var _local6;
            switch (_local10) {
                case 1 : 
                    _local5 = COLOUR_OFF_WHITE;
                    _local3 = COLOUR_WHITE;
                    _local6 = COLOUR_OFF_WHITE;
                    break;
                case 2 : 
                    _local5 = COLOUR_WHITE;
                    _local3 = COLOUR_GREEN;
                    _local6 = COLOUR_YELLOW;
                    break;
                case 3 : 
                    _local5 = COLOUR_GREEN;
                    _local3 = COLOUR_YELLOW;
                    _local6 = COLOUR_LIGHT_ORANGE;
                    break;
                case 4 : 
                    _local5 = COLOUR_YELLOW;
                    _local3 = COLOUR_LIGHT_ORANGE;
                    _local6 = COLOUR_DARK_ORANGE;
                    break;
                case 5 : 
                    _local5 = COLOUR_LIGHT_ORANGE;
                    _local3 = COLOUR_DARK_ORANGE;
                    _local6 = COLOUR_RED;
                    break;
                case 6 : 
                    _local5 = COLOUR_DARK_ORANGE;
                    _local3 = COLOUR_RED;
                    _local6 = COLOUR_DARK_ORANGE;
                    break;
                case 8 : 
                    _local5 = COLOUR_DARK_ORANGE;
                    _local3 = COLOUR_RED;
                    _local6 = COLOUR_MAGENTA;
                    break;
                case 10 : 
                    _local5 = COLOUR_MAGENTA;
                    _local3 = COLOUR_PURPLE;
                    _local6 = COLOUR_DARKBLUE;
                    break;
                default : 
                    debugTrace("unknown multiplier! multiplier set to " + _local10, com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
                    break;
            }
            var _local4 = new flash.geom.ColorTransform();
            var _local7;
            _local7 = new flash.geom.Transform(movie[BACKGROUND_MOVIECLIP].lights.ambience);
            _local4.rgb = _local3;
            _local7.colorTransform = _local4;
            _local7 = new flash.geom.Transform(movie[BACKGROUND_MOVIECLIP].lights.animation.light1);
            _local4.rgb = _local3;
            _local7.colorTransform = _local4;
            _local7 = new flash.geom.Transform(movie[BACKGROUND_MOVIECLIP].lights.animation.light2);
            _local4.rgb = _local6;
            _local7.colorTransform = _local4;
            _local7 = new flash.geom.Transform(movie[BACKGROUND_MOVIECLIP].lights.animation.light3);
            _local4.rgb = _local5;
            _local7.colorTransform = _local4;
            var _local11 = new flash.geom.ColorTransform();
            _local11.alphaMultiplier = 0.45;
            backgroundLightBuffer.draw(movie[BACKGROUND_MOVIECLIP].lights.animation, new flash.geom.Matrix(), _local11);
            var _local2 = new Array();
            var _local13 = 0.95;
            _local2 = _local2.concat([1, 0, 0, 0, 0]);
            _local2 = _local2.concat([0, 1, 0, 0, 0]);
            _local2 = _local2.concat([0, 0, 1, 0, 0]);
            _local2 = _local2.concat([0, 0, 0, _local13, 0]);
            var _local14 = new flash.filters.ColorMatrixFilter(_local2);
            backgroundLightBuffer.applyFilter(backgroundLightBuffer, backgroundLightBuffer.rectangle, new flash.geom.Point(0, 0), _local14);
            movie[BACKGROUND_MOVIECLIP].lights.createEmptyMovieClip("buffer", 100);
            movie[BACKGROUND_MOVIECLIP].lights.buffer.attachBitmap(backgroundLightBuffer, 1, "auto", true);
        }
        function updateDancefloor() {
            var _local9 = gameEngine.currentTimeMillis;
            var _local8 = gameEngine.currentMultiplier;
            var _local10 = gameEngine.isDancing;
            var _local2 = Math.round(_local9 / 500) % 3;
            if ((qualityMode == QUALITY_MEDIUM) || (qualityMode == QUALITY_LOW)) {
                _local2 = Math.round(_local9 / 2000) % 3;
            }
            if (_local2 != lastColour) {
                lastColour = _local2;
                var _local7 = ((_local8 < 6) ? (_local8) : 6);
                var _local4 = new Array();
                if (!_local10) {
                    _local7 = 6;
                }
                if (_local7 < 6) {
                    _local4[0] = _local8;
                    _local4[1] = _local8 + 1;
                    _local4[2] = _local8 + 2;
                } else {
                    var _local6 = 0;
                    while (_local6 < _local7) {
                        _local4[_local6] = (Math.round(Math.random() * 1000) % _local7) + 2;
                        _local6++;
                    }
                }
                var _local6 = 0;
                while (_local6 < 6) {
                    var _local3 = 0;
                    while (_local3 < 5) {
                        _local2 = ((_local2 > _local4.length) ? 0 : (_local2 + 1));
                        var _local5 = (Math.floor(Math.random() * 10) % 4) == 0;
                        if (_local5) {
                            _local2 = ((_local2 > _local4.length) ? 0 : (_local2 + 1));
                        }
                        movie[BACKGROUND_MOVIECLIP].dancefloor[("light" + _local3) + _local6].gotoAndStop(_local4[_local2]);
                        _local3++;
                    }
                    _local6++;
                }
            }
        }
        function updateDancer($normalisedRating) {
            var _local6 = gameEngine.currentSong;
            var _local5 = gameEngine.elapsedTimeMillis;
            var _local11 = gameEngine.isPlayingGame;
            if (_local5 >= com.clubpenguin.games.dancing.data.SongData.getSongLengthMillis(_local6)) {
                return(undefined);
            }
            if (dancingPenguin[DANCER_MOVIECLIP] == undefined) {
                var _local3 = String(Math.ceil(Math.random() * 4));
                dancingPenguin.attachMovie(DANCER_MOVIECLIP_OK + _local3, DANCER_MOVIECLIP, 1);
                dancingPenguin[DANCER_MOVIECLIP].gotoAndStop(1);
                if (hasPurplePuffle) {
                    if (dancingPenguin[PUFFLE_MOVIECLIP] == undefined) {
                        dancingPenguin.attachMovie(PUFFLE_MOVIECLIP, PUFFLE_MOVIECLIP, 2);
                        dancingPenguin[PUFFLE_MOVIECLIP].gotoAndStop(1);
                    }
                    dancingPenguin[PUFFLE_MOVIECLIP]._visible = true;
                }
                var _local13 = dancingPenguin[DANCER_MOVIECLIP]._totalframes / 4;
                dancingPenguin[DANCER_MOVIECLIP].gotoAndStop(_local13 + 1);
                loopAgain = true;
            }
            if (_local5 > (animationTimeMillis + timePerFrameMillis)) {
                animationTimeMillis = animationTimeMillis + timePerFrameMillis;
                if (dancingPenguin[DANCER_MOVIECLIP]._currentframe < dancingPenguin[DANCER_MOVIECLIP]._totalframes) {
                    updateDancerFrame(dancingPenguin[DANCER_MOVIECLIP]._currentframe);
                } else {
                    if (loopAgain) {
                        loopAgain = false;
                        updateDancerFrame(0);
                        return(undefined);
                    }
                    loopAgain = true;
                    dancingPenguin[DANCER_MOVIECLIP].removeMovieClip();
                    if (!_local11) {
                        dancingPenguin[PUFFLE_MOVIECLIP]._visible = false;
                        gameEngine.isDancing = false;
                        return(undefined);
                    }
                    var _local3 = String(Math.ceil(Math.random() * 4));
                    var _local9 = (Math.floor(Math.random() * 10) % 2) == 0;
                    var _local2;
                    var _local8;
                    switch ($normalisedRating) {
                        case RATING_BAD : 
                            if (_local9) {
                                _local2 = DANCER_MOVIECLIP_TERRIBLE + ((_local3 % 2) + 1);
                            } else {
                                _local2 = DANCER_MOVIECLIP_BAD + _local3;
                            }
                            _local8 = Math.floor(Math.random() * 2) + 1;
                            break;
                        case RATING_OK : 
                            if (_local9) {
                                _local2 = DANCER_MOVIECLIP_BAD + _local3;
                            } else {
                                _local2 = DANCER_MOVIECLIP_OK + _local3;
                            }
                            _local8 = Math.floor(Math.random() * 3) + 1;
                            break;
                        case RATING_GREAT : 
                            if (_local9) {
                                _local2 = DANCER_MOVIECLIP_OK + _local3;
                            } else {
                                _local2 = DANCER_MOVIECLIP_GREAT + _local3;
                            }
                            _local8 = Math.floor(Math.random() * 4) + 2;
                            break;
                        default : 
                            debugTrace(("normalised current rating (" + $normalisedRating) + ") is out of range, unable to do new dance move!", com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
                            break;
                    }
                    if (hasPurplePuffle) {
                        if (!dancingPenguin[PUFFLE_MOVIECLIP]._visible) {
                            dancingPenguin[PUFFLE_MOVIECLIP]._visible = true;
                        }
                    }
                    if (specialMove != SPECIAL_NONE) {
                        _local2 = DANCER_MOVIECLIP_SPECIAL + specialMove;
                        if (specialMove == SPECIAL_COMBO_LOST) {
                            _local2 = DANCER_MOVIECLIP_TERRIBLE + ((_local3 % 2) + 1);
                        }
                    }
                    var _local12 = com.clubpenguin.games.dancing.data.SongData.getSongLengthMillis(_local6) - (com.clubpenguin.games.dancing.data.SongData.getMillisPerBar(_local6) * 2);
                    if (_local5 >= _local12) {
                        var _local7 = gameEngine.getNoteHitPercentage();
                        if (_local7 < 50) {
                            _local2 = DANCER_MOVIECLIP_ENDING + "4";
                        } else if (_local7 < 75) {
                            _local2 = DANCER_MOVIECLIP_ENDING + "3";
                        } else if (_local7 <= 99) {
                            _local2 = DANCER_MOVIECLIP_ENDING + "2";
                        } else {
                            _local2 = DANCER_MOVIECLIP_ENDING + "1";
                        }
                    }
                    dancingPenguin.attachMovie(_local2, DANCER_MOVIECLIP, 1);
                    dancingPenguin[DANCER_MOVIECLIP].gotoAndStop(1);
                    if (specialMove != SPECIAL_NONE) {
                        if (specialMove == SPECIAL_PUFFLESPIN) {
                            dancingPenguin[PUFFLE_MOVIECLIP]._visible = false;
                            dancingPenguin[DANCER_MOVIECLIP].puffleBonus.label.puffleBonus.text = "+100";
                            dancingPenguin[DANCER_MOVIECLIP].puffleBonus.gotoAndPlay(1);
                            gameEngine.currentScore = gameEngine.currentScore + 100;
                        } else if (hasPurplePuffle) {
                            dancingPenguin[PUFFLE_MOVIECLIP].gotoAndStop(PUFFLEDANCE_SPECIAL);
                            dancingPenguin[PUFFLE_MOVIECLIP].puffleBonus.label.puffleBonus.text = "+50";
                            dancingPenguin[PUFFLE_MOVIECLIP].puffleBonus.gotoAndPlay(1);
                            gameEngine.currentScore = gameEngine.currentScore + 50;
                        }
                        specialMove = SPECIAL_NONE;
                    } else if (hasPurplePuffle) {
                        var _local4 = 1;
                        switch ($normalisedRating) {
                            case RATING_BAD : 
                                _local4 = 1;
                                break;
                            case RATING_OK : 
                                _local4 = 2;
                                break;
                            case RATING_GREAT : 
                                _local4 = 5;
                                break;
                        }
                        dancingPenguin[PUFFLE_MOVIECLIP].puffleBonus.label.puffleBonus.text = "+" + _local4;
                        dancingPenguin[PUFFLE_MOVIECLIP].puffleBonus.gotoAndPlay(1);
                        gameEngine.currentScore = gameEngine.currentScore + _local4;
                    }
                    if (hasPurplePuffle) {
                        dancingPenguin[PUFFLE_MOVIECLIP].gotoAndStop(_local8);
                    }
                    debugTrace("add new dancer mc! animation name is " + _local2, com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE);
                }
                updateDancer($normalisedRating);
            }
        }
        function updateDancerFrame($targetFrame) {
            var _local2 = $targetFrame + 1;
            dancingPenguin[DANCER_MOVIECLIP].gotoAndStop(_local2);
            dancingPenguin[DANCER_MOVIECLIP].penguin_mc.eyes_mc.gotoAndStop(_local2);
            dancingPenguin[DANCER_MOVIECLIP].penguin_mc.beak_mc.gotoAndStop(_local2);
            dancingPenguin[DANCER_MOVIECLIP].penguin_mc.face_mc.gotoAndStop(_local2);
            dancingPenguin[DANCER_MOVIECLIP].penguin_mc.frontArm_mc.gotoAndStop(_local2);
            dancingPenguin[DANCER_MOVIECLIP].penguin_mc.frontArmLines_mc.gotoAndStop(_local2);
            dancingPenguin[DANCER_MOVIECLIP].penguin_mc.backArm_mc.gotoAndStop(_local2);
            dancingPenguin[DANCER_MOVIECLIP].penguin_mc.backArmLines_mc.gotoAndStop(_local2);
            dancingPenguin[DANCER_MOVIECLIP].penguin_mc.body_mc.gotoAndStop(_local2);
            dancingPenguin[DANCER_MOVIECLIP].penguin_mc.bodyLines_mc.gotoAndStop(_local2);
            dancingPenguin[DANCER_MOVIECLIP].penguin_mc.shadow_mc.gotoAndStop(_local2);
            dancingPenguin[DANCER_MOVIECLIP].penguin_mc.feet_mc.gotoAndStop(_local2);
            dancingPenguin[DANCER_MOVIECLIP].penguin_mc.rightFoot_mc.gotoAndStop(_local2);
            dancingPenguin[DANCER_MOVIECLIP].penguin_mc.leftFoot_mc.gotoAndStop(_local2);
            if (hasPurplePuffle) {
                if (_local2 == 1) {
                    if (dancingPenguin[PUFFLE_MOVIECLIP].puffle_mc._totalframes > TOTAL_DANCE_FRAMES) {
                        dancingPenguin[PUFFLE_MOVIECLIP].puffle_mc.gotoAndStop(TOTAL_DANCE_FRAMES + 1);
                    } else {
                        dancingPenguin[PUFFLE_MOVIECLIP].puffle_mc.gotoAndStop(_local2);
                    }
                } else {
                    var _local3 = dancingPenguin[PUFFLE_MOVIECLIP].puffle_mc._currentframe;
                    if (_local3 > TOTAL_DANCE_FRAMES) {
                        dancingPenguin[PUFFLE_MOVIECLIP].puffle_mc.gotoAndStop(TOTAL_DANCE_FRAMES + _local2);
                    } else {
                        dancingPenguin[PUFFLE_MOVIECLIP].puffle_mc.gotoAndStop(_local2);
                    }
                }
                dancingPenguin[DANCER_MOVIECLIP].penguin_mc.puffle_mc.gotoAndStop(_local2);
            }
        }
        function hideDancer() {
            dancingPenguin[DANCER_MOVIECLIP].removeMovieClip();
            dancingPenguin[PUFFLE_MOVIECLIP]._visible = false;
            gameEngine.isDancing = false;
        }
        function updateNoteBonus($noteType, $noteValue, $currentScore) {
            movie[SCORE_MOVIECLIP][HOLD_POPUP_MOVIECLIP + $noteType].gotoAndPlay(2);
            movie[SCORE_MOVIECLIP][HOLD_POPUP_MOVIECLIP + $noteType].bonus.text = "+" + $noteValue;
            movie[SCORE_MOVIECLIP].score.text = com.clubpenguin.util.LocaleText.getText("ui_score") + ":";
            movie[SCORE_MOVIECLIP].scoreValue.text = $currentScore;
        }
        function updateNoteCombo($noteResult, $consecutiveNotes, $comboLost, $currentScore, $normalisedRating) {
            switch ($noteResult) {
                case com.clubpenguin.games.dancing.Note.RESULT_PERFECT : 
                    movie[SCORE_MOVIECLIP].notePopup.gotoAndPlay(POPUPANIM_PERFECT);
                    break;
                case com.clubpenguin.games.dancing.Note.RESULT_GREAT : 
                    movie[SCORE_MOVIECLIP].notePopup.gotoAndPlay(POPUPANIM_GREAT);
                    break;
                case com.clubpenguin.games.dancing.Note.RESULT_GOOD : 
                    movie[SCORE_MOVIECLIP].notePopup.gotoAndPlay(POPUPANIM_OK);
                    break;
                case com.clubpenguin.games.dancing.Note.RESULT_ALMOST : 
                    movie[SCORE_MOVIECLIP].notePopup.gotoAndPlay(POPUPANIM_ALMOST);
                    break;
                case com.clubpenguin.games.dancing.Note.RESULT_MISS : 
                    movie[SCORE_MOVIECLIP].notePopup.gotoAndPlay(POPUPANIM_MISS);
                    break;
                case com.clubpenguin.games.dancing.Note.RESULT_BOO : 
                    movie[SCORE_MOVIECLIP].notePopup.gotoAndPlay(POPUPANIM_BOO);
                    break;
            }
            if (((((($consecutiveNotes / 100) >= 1) && (($consecutiveNotes % 100) == 0)) || ($consecutiveNotes == 25)) || ($consecutiveNotes == 50)) || ($consecutiveNotes == 75)) {
                switch ($consecutiveNotes) {
                    case 25 : 
                        specialMove = SPECIAL_RIVERDANCE;
                        movie[SCORE_MOVIECLIP].streakPopup.gotoAndPlay("animation");
                        var _local7 = (Math.round(Math.random() * 100) % 2) == 0;
                        if (_local7) {
                            movie[SCORE_MOVIECLIP].streakPopup.cadence.gotoAndStop("25NoteStreak1");
                        } else {
                            movie[SCORE_MOVIECLIP].streakPopup.cadence.gotoAndStop("25NoteStreak2");
                        }
                        break;
                    case 50 : 
                        specialMove = SPECIAL_WORM;
                        movie[SCORE_MOVIECLIP].streakPopup.gotoAndPlay("animation");
                        movie[SCORE_MOVIECLIP].streakPopup.cadence.gotoAndStop("50NoteStreak");
                        break;
                    case 75 : 
                        if (hasPurplePuffle) {
                            specialMove = SPECIAL_PUFFLESPIN;
                        }
                        if (qualityMode == QUALITY_HIGH) {
                            if (movie[BACKGROUND_MOVIECLIP].discoBall._currentframe == 1) {
                                movie[BACKGROUND_MOVIECLIP].discoBall.gotoAndPlay("75NoteStreak");
                            }
                            movie[SCORE_MOVIECLIP].streakPopup.gotoAndStop(1);
                        }
                        break;
                    default : 
                        specialMove = SPECIAL_BREAKDANCE;
                        movie[SCORE_MOVIECLIP].streakPopup.gotoAndPlay("animation");
                        movie[SCORE_MOVIECLIP].streakPopup.cadence.gotoAndStop("100NoteStreak");
                        break;
                }
                if ($consecutiveNotes != 75) {
                    movie[SCORE_MOVIECLIP].streakPopup.tween.message.text = com.clubpenguin.util.LocaleText.getTextReplaced("ui_noteCombo", [$consecutiveNotes]).toUpperCase();
                }
            }
            if ($comboLost) {
                specialMove = SPECIAL_COMBO_LOST;
                movie[SCORE_MOVIECLIP].streakPopup.gotoAndPlay("animation");
                movie[SCORE_MOVIECLIP].streakPopup.cadence.gotoAndStop("NoteStreakLost");
                movie[SCORE_MOVIECLIP].streakPopup.tween.message.text = com.clubpenguin.util.LocaleText.getText("ui_noteComboLost").toUpperCase();
            }
            var _local3 = 1;
            var _local4 = new TextFormat();
            _local4.bold = true;
            switch (Math.floor($consecutiveNotes / MULTIPLIER_LIMIT)) {
                case 0 : 
                    _local3 = 1;
                    _local4["color"] = COLOUR_WHITE;
                    break;
                case 1 : 
                    _local3 = 2;
                    _local4["color"] = COLOUR_GREEN;
                    break;
                case 2 : 
                    _local3 = 3;
                    _local4["color"] = COLOUR_YELLOW;
                    break;
                case 3 : 
                    _local3 = 4;
                    _local4["color"] = COLOUR_LIGHT_ORANGE;
                    break;
                case 4 : 
                    _local3 = 5;
                    _local4["color"] = COLOUR_DARK_ORANGE;
                    break;
                case 5 : 
                    _local3 = 6;
                    _local4["color"] = COLOUR_RED;
                    break;
                case 6 : 
                    _local3 = 7;
                    _local4["color"] = COLOUR_MAGENTA;
                    break;
                case 7 : 
                    _local3 = 8;
                    _local4["color"] = COLOUR_PURPLE;
                    break;
                default : 
                    _local3 = 8;
                    _local4["color"] = COLOUR_PURPLE;
                    break;
            }
            if ($consecutiveNotes < 10) {
                movie[SCORE_MOVIECLIP].streakLabel.text = "";
                movie[SCORE_MOVIECLIP].streakValue.text = "";
            } else {
                movie[SCORE_MOVIECLIP].streakLabel.text = com.clubpenguin.util.LocaleText.getText("ui_combo").toUpperCase();
                movie[SCORE_MOVIECLIP].streakValue.text = $consecutiveNotes;
            }
            movie[SCORE_MOVIECLIP].multiplier.gotoAndStop(_local3);
            movie[SCORE_MOVIECLIP].streakLabel.setTextFormat(_local4);
            movie[SCORE_MOVIECLIP].streakValue.setTextFormat(_local4);
            movie[SCORE_MOVIECLIP].score.text = com.clubpenguin.util.LocaleText.getText("ui_score") + ":";
            movie[SCORE_MOVIECLIP].scoreValue.text = $currentScore;
            var _local6 = $consecutiveNotes % MULTIPLIER_LIMIT;
            var _local2 = 1;
            while (_local2 <= 10) {
                if (_local2 <= _local6) {
                    movie[SCORE_MOVIECLIP].combo["light" + _local2].gotoAndStop(_local3 + 1);
                } else {
                    movie[SCORE_MOVIECLIP].combo["light" + _local2].gotoAndStop(_local3);
                }
                _local2++;
            }
            movie[SCORE_MOVIECLIP].streakPopup.cadence.speedLines._visible = false;
            if (qualityMode == QUALITY_HIGH) {
                movie[SCORE_MOVIECLIP].streakPopup.cadence.speedLines._visible = true;
            }
            updateCurrentRating($normalisedRating, $consecutiveNotes);
        }
        function updateCurrentRating($normalisedRating, $consecutiveNotes) {
            var _local3 = "";
            switch ($normalisedRating) {
                case RATING_BAD : 
                    _local3 = com.clubpenguin.util.LocaleText.getText("ui_ratingBad");
                    movie[BACKGROUND_MOVIECLIP].speakerLeft.gotoAndStop(DANCER_MOVIECLIP_BAD);
                    movie[BACKGROUND_MOVIECLIP].speakerRight.gotoAndStop(DANCER_MOVIECLIP_BAD);
                    movie[BACKGROUND_MOVIECLIP].lights.gotoAndStop(DANCER_MOVIECLIP_BAD);
                    movie[SCORE_MOVIECLIP].rating.gotoAndStop(DANCER_MOVIECLIP_BAD);
                    break;
                case RATING_OK : 
                    _local3 = com.clubpenguin.util.LocaleText.getText("ui_ratingOK");
                    movie[BACKGROUND_MOVIECLIP].speakerLeft.gotoAndStop(DANCER_MOVIECLIP_OK);
                    movie[BACKGROUND_MOVIECLIP].speakerRight.gotoAndStop(DANCER_MOVIECLIP_OK);
                    movie[BACKGROUND_MOVIECLIP].lights.gotoAndStop(DANCER_MOVIECLIP_OK);
                    movie[SCORE_MOVIECLIP].rating.gotoAndStop(DANCER_MOVIECLIP_OK);
                    break;
                case RATING_GREAT : 
                    _local3 = com.clubpenguin.util.LocaleText.getText("ui_ratingGreat");
                    movie[BACKGROUND_MOVIECLIP].speakerLeft.gotoAndStop(DANCER_MOVIECLIP_GREAT);
                    movie[BACKGROUND_MOVIECLIP].speakerRight.gotoAndStop(DANCER_MOVIECLIP_GREAT);
                    movie[BACKGROUND_MOVIECLIP].lights.gotoAndStop(DANCER_MOVIECLIP_GREAT);
                    movie[SCORE_MOVIECLIP].rating.gotoAndStop(DANCER_MOVIECLIP_GREAT);
                    break;
            }
            var _local2 = 1;
            if ($consecutiveNotes > 15) {
                _local2 = 2;
            }
            if ($consecutiveNotes > 35) {
                _local2 = 3;
            }
            movie[BACKGROUND_MOVIECLIP].crowd.gotoAndStop(_local2);
        }
        function setMultiplayerScoreVisibility($visible) {
            if ($visible) {
                movie[SCORE_MOVIECLIP].multiplayerLabel.text = com.clubpenguin.util.LocaleText.getText("ui_allScores");
                movie[SCORE_MOVIECLIP].multiplayerNames._visible = true;
            } else {
                movie[SCORE_MOVIECLIP].multiplayerLabel.text = "";
                movie[SCORE_MOVIECLIP].multiplayerNames._visible = false;
            }
        }
        function updateMultiplayerScores(playerScores) {
            setMultiplayerScoreVisibility(true);
            movie[SCORE_MOVIECLIP].multiplayerNames.background._height = (playerScores.length * 31.25) + 12.5;
            var _local5 = 1;
            while (_local5 <= 15) {
                movie[SCORE_MOVIECLIP].multiplayerNames["item" + _local5].label.text = "";
                movie[SCORE_MOVIECLIP].multiplayerNames["item" + _local5]._visible = false;
                _local5++;
            }
            for (var _local11 in playerScores) {
                var _local4 = parseInt(_local11);
                if (_local4 >= 15) {
                    break;
                }
                var _local6 = playerScores[_local11].name.substring(0, 12);
                movie[SCORE_MOVIECLIP].multiplayerNames["item" + (_local4 + 1)]._visible = true;
                movie[SCORE_MOVIECLIP].multiplayerNames["item" + (_local4 + 1)].label.text = (_local6 + ": ") + playerScores[_local11].score;
                if (playerScores[_local11].name.substring(0, 6).toLowerCase() == "pengui") {
                    var _local8 = playerScores[_local11].name.substring(8, playerScores[_local11].name.length);
                    if (parseInt(_local8) != Number.NaN) {
                        movie[SCORE_MOVIECLIP].multiplayerNames["item" + (_local4 + 1)].label.text = (_local6.substring(0, 10) + ": ") + playerScores[_local11].score;
                    }
                }
                var _local9 = _global.getCurrentShell();
                var _local10 = _local9.getMyPlayerNickname();
                var _local7 = 1;
                if (playerScores[_local11].name == _local10) {
                    _local7 = 2;
                }
                movie[SCORE_MOVIECLIP].multiplayerNames["item" + (_local4 + 1)].gotoAndStop(_local7);
            }
        }
        static function debugTrace(message, priority) {
            if (priority == undefined) {
                priority = com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE;
            }
            if (com.clubpenguin.util.Reporting.DEBUG) {
                com.clubpenguin.util.Reporting.debugTrace("(AnimationEngine) " + message, priority);
            }
        }
        static var COLOUR_WHITE = 15724527;
        static var COLOUR_OFF_WHITE = 14277081;
        static var COLOUR_GREEN = 13434675;
        static var COLOUR_YELLOW = 16776960;
        static var COLOUR_LIGHT_ORANGE = 16763904;
        static var COLOUR_DARK_ORANGE = 16746512;
        static var COLOUR_RED = 16730931;
        static var COLOUR_MAGENTA = 14287066;
        static var COLOUR_PURPLE = 8026836;
        static var COLOUR_DARKBLUE = 5932468;
        static var QUALITY_LOW = 0;
        static var QUALITY_MEDIUM = 1;
        static var QUALITY_HIGH = 2;
        static var RATING_BAD = 0;
        static var RATING_OK = 1;
        static var RATING_GREAT = 2;
        static var SPECIAL_NONE = 0;
        static var SPECIAL_RIVERDANCE = 1;
        static var SPECIAL_WORM = 2;
        static var SPECIAL_BREAKDANCE = 3;
        static var SPECIAL_PUFFLESPIN = 4;
        static var SPECIAL_COMBO_LOST = 5;
        static var DIRECTION_LEFT = 0;
        static var DIRECTION_RIGHT = 1;
        static var ARROWS_MOVIECLIP = "arrows";
        static var DANCER_MOVIECLIP = "dancer";
        static var PUFFLE_MOVIECLIP = "puffle";
        static var SCORE_MOVIECLIP = "score";
        static var MENUS_MOVIECLIP = "menus";
        static var BACKGROUND_MOVIECLIP = "background";
        static var HOLD_POPUP_MOVIECLIP = "noteHoldPopup";
        static var DANCER_MOVIECLIP_TERRIBLE = "danceTerrible";
        static var DANCER_MOVIECLIP_BAD = "danceBad";
        static var DANCER_MOVIECLIP_OK = "danceOK";
        static var DANCER_MOVIECLIP_GREAT = "danceGreat";
        static var DANCER_MOVIECLIP_SPECIAL = "danceSpecial";
        static var DANCER_MOVIECLIP_ENDING = "danceEnd";
        static var PUFFLEDANCE_SMALLHOP = 1;
        static var PUFFLEDANCE_BIGHOP = 2;
        static var PUFFLEDANCE_GROOVIN = 3;
        static var PUFFLEDANCE_SOMERSAULT = 4;
        static var PUFFLEDANCE_SPECIAL = 5;
        static var POPUPANIM_PERFECT = "perfectPopup";
        static var POPUPANIM_GREAT = "greatPopup";
        static var POPUPANIM_OK = "okPopup";
        static var POPUPANIM_ALMOST = "almostPopup";
        static var POPUPANIM_BOO = "booPopup";
        static var POPUPANIM_MISS = "missPopup";
        static var MULTIPLIER_LIMIT = com.clubpenguin.games.dancing.GameEngine.MULTIPLIER_LIMIT;
        static var MAX_RATING = com.clubpenguin.games.dancing.GameEngine.MAX_RATING;
        static var ITEM_ID_PURPLE_PUFFLE = 754;
        static var HUD_SHOW_TIME = 2500;
        static var TOTAL_DANCE_FRAMES = 48;
        var specialMove = SPECIAL_NONE;
        var lastColour = 1;
        var loopAgain = false;
        var showHUD = false;
        var hasPurplePuffle = false;
        var qualityMode = QUALITY_HIGH;
    }
