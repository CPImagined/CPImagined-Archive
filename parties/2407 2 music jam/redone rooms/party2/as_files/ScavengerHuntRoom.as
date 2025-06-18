//Created by Action Script Viewer - https://www.buraks.com/asv
    class as_files.ScavengerHuntRoom extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _currentParty, _redherringItems, _destroyDelegate, _SHELL, _stage, _hideBotEmoteIntervalID, _showBotEmoteIntervalID;
        function ScavengerHuntRoom (stageReference) {
            super(stageReference);
            _currentParty = _global.getCurrentParty().BaseParty.CURRENT_PARTY;
            _redherringItems = [];
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroyScavengerHuntRoom);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        function botEmote() {
            if (_stage.bot != undefined) {
                var _local_2 = _SHELL.randBetween(2, 4);
                if (_local_2 == _botEmoteCurrentFrame) {
                    _local_2++;
                    if (_local_2 == 5) {
                        _local_2 = 2;
                    }
                }
                _botEmoteCurrentFrame = _local_2;
                _stage.bot.gotoAndStop(_local_2);
                clearTimeout(_hideBotEmoteIntervalID);
                clearTimeout(_showBotEmoteIntervalID);
                _hideBotEmoteIntervalID = setTimeout(com.clubpenguin.util.Delegate.create(this, hideBbotEmote), 5000);
            }
        }
        function hideBbotEmote() {
            if (_stage.bot != undefined) {
                _stage.bot.gotoAndStop(1);
                clearTimeout(_hideBotEmoteIntervalID);
                clearTimeout(_showBotEmoteIntervalID);
                _showBotEmoteIntervalID = setTimeout(com.clubpenguin.util.Delegate.create(this, botEmote), 10000);
            }
        }
        function destroyScavengerHuntRoom() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            clearTimeout(_hideBotEmoteIntervalID);
            clearTimeout(_showBotEmoteIntervalID);
        }
        function registerScavengerHuntItem(item_name) {
            var _local_4 = item_name.split("_");
            var _local_2 = Number(_local_4[1]);
            scavengerItems[item_name] = _local_2;
            setTaskAvailability(item_name, _local_2);
        }
        function registerRedherringItems(redherringItems) {
            _redherringItems.push(redherringItems);
            var _local_3 = redherringItems[1];
            setRedherringAvailability(redherringItems, completedAllTasks(_local_3), false);
        }
        function setRedherringAvailability(redherringItems, completedAllTasks, playFadeOutAnim) {
            var _local_3 = redherringItems[0];
            var _local_5 = redherringItems[1];
            var _local_2 = 0;
            while (_local_2 < _local_3.length) {
                var _local_4 = (!completedAllTasks) && (_currentParty.isTaskAvailable(_local_5[0]));
                _stage[_local_3[_local_2] + "_btn"]._visible = _local_4;
                if (!_local_4) {
                    if (playFadeOutAnim) {
                        _stage[_local_3[_local_2] + "_mc"].gotoAndStop(2);
                    } else {
                        _stage[_local_3[_local_2] + "_mc"]._visible = false;
                    }
                } else {
                    _stage[_local_3[_local_2] + "_mc"]._visible = _local_4;
                }
                _local_2++;
            }
        }
        function getRedherringItems(taskId) {
            var _local_3 = 0;
            while (_local_3 < _redherringItems.length) {
                var _local_4 = _redherringItems[_local_3][1];
                var _local_2 = 0;
                while (_local_2 < _local_4.length) {
                    if (_local_4[_local_2] == taskId) {
                        return(_redherringItems[_local_3]);
                    }
                    _local_2++;
                }
                _local_3++;
            }
            return(null);
        }
        function setTaskAvailability(item_name, taskId) {
            if (_currentParty.isTaskAvailable(taskId) && (!_currentParty.isQuestTaskComplete(taskId))) {
                _stage.bot.onRollOver = com.clubpenguin.util.Delegate.create(this, questItemRollOver, _stage[item_name + "_btn"]);
                _stage.bot.onRollOut = com.clubpenguin.util.Delegate.create(this, questItemRollOut, _stage[item_name + "_btn"]);
                _stage.bot.onRelease = com.clubpenguin.util.Delegate.create(this, onScavengerItemClicked, item_name);
                _stage[item_name + "_btn"]._visible = true;
            } else {
                _stage[item_name + "_btn"]._visible = false;
            }
            _stage.bot._visible = _currentParty.isTaskAvailable(taskId);
            if (_currentParty.isTaskAvailable(taskId)) {
                clearTimeout(_hideBotEmoteIntervalID);
                clearTimeout(_showBotEmoteIntervalID);
                botEmote();
            }
        }
        function completedAllTasks(tasks) {
            var _local_2 = 0;
            while (_local_2 < tasks.length) {
                if (!_currentParty.isQuestTaskComplete(tasks[_local_2])) {
                    return(false);
                }
                _local_2++;
            }
            return(true);
        }
        function questItemRollOver(item_mc) {
            item_mc.gotoAndStop(2);
        }
        function questItemRollOut(item_mc) {
            item_mc.gotoAndStop(1);
        }
        function onScavengerItemClicked(item_name) {
            _stage[item_name + "_btn"]._visible = false;
            _stage.bot.enabled = false;
            setTaskComplete(Number(scavengerItems[item_name]));
            showCheckMark();
        }
        function setTaskComplete(taskId) {
            _currentParty.taskComplete(taskId);
            if (_stage.checkmark_mc) {
                _stage.checkmark_mc.removeMovieClip();
            }
            var _local_6 = getRedherringItems(taskId);
            if (_local_6 != null) {
                var _local_3 = _local_6[1];
                var _local_4 = true;
                var _local_2 = 0;
                while (_local_2 < _local_3.length) {
                    if ((_local_3[_local_2] != taskId) && (!_currentParty.isQuestTaskComplete(_local_3[_local_2]))) {
                        _local_4 = false;
                    }
                    _local_2++;
                }
                setRedherringAvailability(_local_6, _local_4, true);
            }
        }
        function showCheckMark() {
            if (_stage.checkmark_mc) {
                _stage.checkmark_mc.removeMovieClip();
            }
            var _local_4 = _SHELL.getMyPlayerId();
            var _local_3 = _global.getCurrentEngine().getPlayerMovieClip(_local_4);
            _stage.attachMovie("CheckMarkAnimation", "checkmark_mc", _stage.getNextHighestDepth());
            _stage.checkmark_mc.swapDepths(_stage.getNextHighestDepth());
            _stage.checkmark_mc._x = _local_3._x;
            _stage.checkmark_mc._y = _local_3._y + 120;
            _stage.checkmark_mc._xscale = 250;
            _stage.checkmark_mc._yscale = 250;
        }
        var scavengerItems = {};
        var _botEmoteCurrentFrame = -1;
    }
