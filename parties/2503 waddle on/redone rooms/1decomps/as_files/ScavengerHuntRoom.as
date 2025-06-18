    class as_files.ScavengerHuntRoom extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _currentParty, _stage, _SHELL;
        function ScavengerHuntRoom (stageReference) {
            super(stageReference);
            _currentParty = _global.getCurrentParty().BaseParty.CURRENT_PARTY;
        }
        function registerScavengerHuntItem(item_name) {
            var _local_4 = item_name.split("_");
            var _local_2 = Number(_local_4[1]);
            scavengerItems[item_name] = _local_2;
            setTaskAvailability(item_name, _local_2);
        }
        function setTaskAvailability(item_name, taskId) {
            if (_currentParty.isTaskAvailable(taskId)) {
                _stage.pavilion_btn.onRelease = com.clubpenguin.util.Delegate.create(this, onScavengerItemClicked, item_name);
                _stage.pavilion_btn._visible = true;
                if ((_stage[item_name + "_mc"] != undefined) && (_stage[item_name + "_mc"] != null)) {
                    _stage[item_name + "_mc"].gotoAndStop(2);
                }
                if ((_stage.pavilionBack != undefined) && (_stage.pavilionBack != null)) {
                    _stage.pavilionBack.gotoAndStop(2);
                }
                if (!_currentParty.isQuestTaskComplete(taskId)) {
                    setTaskComplete(taskId);
                    if ((_stage.crate != undefined) && (_stage.crate != null)) {
                        _stage.crate.gotoAndStop(2);
                    }
                } else if ((_stage.crate != undefined) && (_stage.crate != null)) {
                    _stage.crate.gotoAndStop(3);
                }
            } else {
                _stage.pavilion_btn._visible = false;
            }
        }
        function questItemRollOver(item_mc) {
            item_mc.gotoAndStop(2);
        }
        function questItemRollOut(item_mc) {
            item_mc.gotoAndStop(1);
        }
        function onScavengerItemClicked(item_name) {
            _currentParty.displayTaskCompletePrompt(Number(scavengerItems[item_name]));
        }
        function setTaskComplete(taskId) {
            _currentParty.taskCompleteWithoutPrompt(taskId);
            if (_stage.checkmark_mc) {
                _stage.checkmark_mc.removeMovieClip();
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
    }
