//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.card.PowerController
    {
        var _gameEngine, _seq, _mc, _aPows, _topSlots, _pickSlots;
        function PowerController (engine, sequence, mc) {
            _gameEngine = engine;
            _seq = sequence;
            _mc = mc;
            _aPows = new Array();
            _topSlots = [[], [], []];
            _pickSlots = [[], []];
        }
        function get sequence() {
            return(_seq);
        }
        function addPow(pow) {
            _aPows.push(pow);
        }
        function doPowPreJudge() {
            _seq.addFunction({i:this, f:"removeUsedTypeD", p:[]});
            doPreA();
            doE();
            doPostB();
            doPostA();
            _seq.addDelay(1000);
            _seq.addFunction({i:this, f:"gcPowers", p:[]});
        }
        function doPowPostJudge() {
            doC();
            doPreB();
            doD();
        }
        function updatePostA(updateData) {
            var _local_3 = 0;
            while (_local_3 < _aPows.length) {
                var _local_2 = _aPows[_local_3];
                if (((updateData.owner == _local_2.owner) && (updateData.pow == _local_2.pow)) && (updateData.round == _local_2.round)) {
                    _local_2.receiver = updateData.receiver;
                    return(undefined);
                }
                _local_3++;
            }
            com.clubpenguin.util.Debug.log((((("[updatePostA - NOT FOUND] owner: " + updateData.owner) + " | pow: ") + updateData.pow) + " | round: ") + updateData.round, "ERROR");
        }
        function queryD() {
            var _local_3 = 0;
            while (_local_3 < _aPows.length) {
                var _local_2 = _aPows[_local_3];
                if (((_local_2.pow >= 13) && (_local_2.pow <= 15)) && (_gameEngine.iRound == _local_2.round)) {
                    return(_local_2);
                }
                _local_3++;
            }
        }
        function doPreA() {
            var _local_3 = 0;
            var _local_6 = _aPows.length - 1;
            while (_local_6 >= 0) {
                var _local_2 = _aPows[_local_6];
                if ((_local_2.pow == 1) && (_gameEngine.iRound < _local_2.round)) {
                    _local_3++;
                    if (_local_3 < 2) {
                        _seq.addFunction({i:this, f:"createPower", p:[_local_2, {name:"pick", seat:_local_2.owner}]});
                        _seq.addFunction({i:this, f:"movePowerTo", p:[_local_2, {name:"top", seat:2}, MOVE_DURATION]});
                        _seq.addDelay(MOVE_DURATION * 1000);
                        _seq.addFunction({i:this, f:"arrangePowSlot", p:[{name:"pick", seat:_local_2.owner}]});
                        _seq.addFunction({i:this, f:"arrangePowSlot", p:[{name:"top", seat:2}]});
                    } else {
                        _seq.addFunction({i:this, f:"createPower", p:[_local_2, {name:"pick", seat:_local_2.owner}]});
                        _seq.addFunction({i:this, f:"movePowerToLastPos", p:[_local_2, {name:"top", seat:2}, MOVE_DURATION]});
                        _seq.addDelay(MOVE_DURATION * 1000);
                        _seq.addFunction({i:this, f:"removePower", p:[_local_2]});
                    }
                }
                _local_6--;
            }
        }
        function doE() {
            var _local_5 = _aPows.length - 1;
            while (_local_5 >= 0) {
                var _local_2 = _aPows[_local_5];
                if ((_local_2.pow >= 16) && (_local_2.pow <= 18)) {
                    _seq.addFunction({i:this, f:"createPower", p:[_local_2, {name:"pick", seat:_local_2.owner}]});
                    _seq.addFunction({i:this, f:"movePowerTo", p:[_local_2, {name:"pick", seat:_local_2.receiver}, MOVE_DURATION]});
                    _seq.addDelay(MOVE_DURATION * 1000);
                    _local_2.gc = true;
                    _seq.addFunction({i:this, f:"arrangePowSlot", p:[{name:"pick", seat:_local_2.owner}]});
                    _seq.addFunction({i:this, f:"arrangePowSlot", p:[{name:"pick", seat:_local_2.receiver}]});
                }
                _local_5--;
            }
        }
        function doPostB() {
            var _local_5 = _aPows.length - 1;
            while (_local_5 >= 0) {
                var _local_2 = _aPows[_local_5];
                if (((_local_2.pow == 2) || (_local_2.pow == 3)) && (_gameEngine.iRound == _local_2.round)) {
                    _seq.addFunction({i:this, f:"movePowerTo", p:[_local_2, {name:"pick", seat:_local_2.receiver}, MOVE_DURATION]});
                    _seq.addDelay(MOVE_DURATION * 1000);
                    _local_2.gc = true;
                    _seq.addFunction({i:this, f:"arrangePowSlot", p:[{name:"pick", seat:_local_2.receiver}]});
                }
                _local_5--;
            }
        }
        function doPostA() {
            var _local_5 = _aPows.length - 1;
            while (_local_5 >= 0) {
                var _local_2 = _aPows[_local_5];
                if ((_local_2.pow == 1) && (_gameEngine.iRound == _local_2.round)) {
                    if (_local_2.receiver == -1) {
                        _seq.addMovie(_local_2.mc, "poof", true);
                        _seq.addDelay(MOVE_DURATION * 1000);
                    } else {
                        _seq.addFunction({i:this, f:"movePowerTo", p:[_local_2, {name:"pick", seat:_local_2.receiver}, MOVE_DURATION]});
                        _seq.addDelay(MOVE_DURATION * 1000);
                    }
                    _local_2.gc = true;
                    _seq.addFunction({i:this, f:"arrangePowSlot", p:[{name:"top", seat:2}]});
                    _seq.addFunction({i:this, f:"arrangePowSlot", p:[{name:"pick", seat:_local_2.receiver}]});
                }
                _local_5--;
            }
        }
        function doC() {
            var _local_6 = _aPows.length - 1;
            while (_local_6 >= 0) {
                var _local_2 = _aPows[_local_6];
                if (((_local_2.pow >= 4) && (_local_2.pow <= 12)) || ((_local_2.pow >= 19) && (_local_2.pow <= 24))) {
                    _seq.addFunction({i:this, f:"createPower", p:[_local_2, {name:"pick", seat:_local_2.owner}]});
                    _seq.addFunction({i:this, f:"movePowerTo", p:[_local_2, {name:"top", seat:_local_2.receiver}, MOVE_DURATION]});
                    _seq.addDelay(MOVE_DURATION * 1000);
                    var _local_3 = 0;
                    while (_local_3 < _local_2.rems.length) {
                        _seq.addFunction({i:_gameEngine.seatMap[_local_2.receiver], f:"discardWinCard", p:[_local_2.rems[_local_3]]});
                        _local_3++;
                    }
                    _seq.addDelay(500);
                    _seq.addFunction({i:this, f:"removePower", p:[_local_2]});
                    _seq.addFunction({i:this, f:"arrangePowSlot", p:[{name:"pick", seat:_local_2.owner}]});
                    _seq.addFunction({i:this, f:"arrangePowSlot", p:[{name:"top", seat:_local_2.receiver}]});
                }
                _local_6--;
            }
        }
        function doPreB() {
            var _local_5 = _aPows.length - 1;
            while (_local_5 >= 0) {
                var _local_2 = _aPows[_local_5];
                if (((_local_2.pow == 2) || (_local_2.pow == 3)) && (_gameEngine.iRound < _local_2.round)) {
                    _seq.addFunction({i:this, f:"createPower", p:[_local_2, {name:"pick", seat:_local_2.owner}]});
                    _seq.addFunction({i:this, f:"movePowerTo", p:[_local_2, {name:"top", seat:_local_2.receiver}, MOVE_DURATION]});
                    _seq.addDelay(MOVE_DURATION * 1000);
                    _seq.addFunction({i:this, f:"arrangePowSlot", p:[{name:"pick", seat:_local_2.owner}]});
                    _seq.addFunction({i:this, f:"arrangePowSlot", p:[{name:"top", seat:_local_2.receiver}]});
                }
                _local_5--;
            }
        }
        function doD() {
            var _local_5 = _aPows.length - 1;
            while (_local_5 >= 0) {
                var _local_2 = _aPows[_local_5];
                if (((_local_2.pow >= 13) && (_local_2.pow <= 15)) && (_gameEngine.iRound < _local_2.round)) {
                    _seq.addFunction({i:this, f:"createPower", p:[_local_2, {name:"pick", seat:_local_2.owner}]});
                    _seq.addFunction({i:this, f:"movePowerTo", p:[_local_2, {name:"top", seat:_local_2.receiver}, MOVE_DURATION]});
                    _seq.addDelay(MOVE_DURATION * 1000);
                    _seq.addFunction({i:this, f:"arrangePowSlot", p:[{name:"pick", seat:_local_2.owner}]});
                    _seq.addFunction({i:this, f:"arrangePowSlot", p:[{name:"top", seat:_local_2.receiver}]});
                }
                _local_5--;
            }
        }
        function createPower(data, dest) {
            var _local_4 = _mc.getNextHighestDepth();
            var _local_3 = getPowSlot(dest);
            data.mc = _mc.attachMovie("power", "pow_" + _local_4, _local_4, {_x:_local_3.x, _y:_local_3.y});
            data.mc.gotoAndStop(data.pow);
            data.loc = dest;
            addPowToSlot(data, dest);
        }
        function movePowerTo(data, dest, duration) {
            var _local_3 = getPowSlot(dest);
            gs.TweenMax.to(data.mc, duration, {_x:_local_3.x, _y:_local_3.y});
            removePowFromSlot(data, data.loc);
            data.loc = dest;
            addPowToSlot(data, dest);
        }
        function movePowerToLastPos(data, dest, duration) {
            var _local_3 = getLastPowSlot(dest);
            gs.TweenMax.to(data.mc, duration, {_x:_local_3.x, _y:_local_3.y});
            removePowFromSlot(data, data.loc);
            data.loc = dest;
            addPowToSlot(data, dest);
        }
        function removePower(data) {
            var _local_2 = _aPows.length - 1;
            while (_local_2 >= 0) {
                if (data == _aPows[_local_2]) {
                    data.mc.removeMovieClip();
                    _aPows.splice(_local_2, 1);
                    removePowFromSlot(data, data.loc);
                    arrangePowSlot(data.loc);
                }
                _local_2--;
            }
        }
        function gcPowers() {
            var _local_2 = _aPows.length - 1;
            while (_local_2 >= 0) {
                if (_aPows[_local_2].gc == true) {
                    removePower(_aPows[_local_2]);
                }
                _local_2--;
            }
        }
        function removeUsedTypeD() {
            var _local_3 = _aPows.length - 1;
            while (_local_3 >= 0) {
                var _local_2 = _aPows[_local_3];
                if (((_local_2.pow >= 13) && (_local_2.pow <= 15)) && (_gameEngine.iRound == _local_2.round)) {
                    removePower(_local_2);
                }
                _local_3--;
            }
        }
        function getPowSlot(dest) {
            var _local_4 = this[("_" + dest.name) + "Slots"][dest.seat].length;
            var _local_3 = new Object();
            _local_3.x = com.clubpenguin.games.card.PowerController["POS_POWER_" + dest.name.toUpperCase()][dest.seat].x;
            _local_3.y = com.clubpenguin.games.card.PowerController["POS_POWER_" + dest.name.toUpperCase()][dest.seat].y;
            if (dest.name == "top") {
                _local_3.y = _local_3.y + (POWER_SPACER * _local_4);
            } else if (dest.name == "pick") {
                _local_3.y = _local_3.y - (POWER_SPACER * _local_4);
            }
            return(_local_3);
        }
        function getLastPowSlot(dest) {
            var _local_4 = this[("_" + dest.name) + "Slots"][dest.seat].length;
            if (_local_4 == 0) {
                return(null);
            }
            var _local_3 = new Object();
            _local_3.x = com.clubpenguin.games.card.PowerController["POS_POWER_" + dest.name.toUpperCase()][dest.seat].x;
            _local_3.y = com.clubpenguin.games.card.PowerController["POS_POWER_" + dest.name.toUpperCase()][dest.seat].y;
            if (dest.name == "top") {
                _local_3.y = _local_3.y + (POWER_SPACER * (_local_4 - 1));
            } else if (dest.name == "pick") {
                _local_3.y = _local_3.y - (POWER_SPACER * (_local_4 - 1));
            }
            return(_local_3);
        }
        function addPowToSlot(data, dest) {
            this[("_" + dest.name) + "Slots"][dest.seat].push(data);
        }
        function removePowFromSlot(data, dest) {
            var _local_3 = this[("_" + dest.name) + "Slots"][dest.seat];
            var _local_2 = _local_3.length - 1;
            while (_local_2 >= 0) {
                if (_local_3[_local_2] == data) {
                    _local_3.splice(_local_2, 1);
                }
                _local_2--;
            }
        }
        function arrangePowSlot(dest) {
            var _local_6 = this[("_" + dest.name) + "Slots"][dest.seat];
            var _local_3 = new Object();
            _local_3.x = com.clubpenguin.games.card.PowerController["POS_POWER_" + dest.name.toUpperCase()][dest.seat].x;
            _local_3.y = com.clubpenguin.games.card.PowerController["POS_POWER_" + dest.name.toUpperCase()][dest.seat].y;
            var _local_2 = 0;
            while (_local_2 < _local_6.length) {
                var _local_4 = _local_6[_local_2];
                if (dest.name == "top") {
                    gs.TweenMax.to(_local_4.mc, ARRANGE_DURATION, {_x:_local_3.x, _y:_local_3.y + (POWER_SPACER * _local_2)});
                } else if (dest.name == "pick") {
                    gs.TweenMax.to(_local_4.mc, ARRANGE_DURATION, {_x:_local_3.x, _y:_local_3.y - (POWER_SPACER * _local_2)});
                }
                _local_2++;
            }
        }
        function debugPows() {
            com.clubpenguin.util.Debug.log("**********************debugPows**********************", "PowerController");
            var _local_3 = 0;
            while (_local_3 < _aPows.length) {
                var _local_2 = _aPows[_local_3];
                var _local_4 = "";
                for (var _local_5 in _local_2) {
                    _local_4 = _local_4 + (((_local_5 + ": ") + _local_2[_local_5]) + " | ");
                }
                com.clubpenguin.util.Debug.log((("_aPows[" + _local_3) + "] - ") + _local_4, "PowerController");
                _local_3++;
            }
            com.clubpenguin.util.Debug.log("**********************debugPows**********************", "PowerController");
        }
        function debugPow(type, data) {
            com.clubpenguin.util.Debug.log((((((((((("[do" + type) + "] - pow: ") + data.pow) + " | owner: ") + data.owner) + " | receiver: ") + data.receiver) + " | round: ") + data.round) + " | rems: ") + data.rems, "PowerController");
        }
        static var POS_POWER_TOP = [{x:205, y:35}, {x:475, y:35}, {x:358, y:60}];
        static var POS_POWER_PICK = [{x:250, y:110}, {x:450, y:110}];
        static var POWER_SPACER = 40;
        static var MOVE_DURATION = 1;
        static var ARRANGE_DURATION = 0.25;
    }
