//Created by Action Script Viewer - https://www.buraks.com/asv
    class mx.managers.DepthManager
    {
        var _childCounter, createClassObject, createObject, _parent, swapDepths, _topmost, getDepth;
        function DepthManager () {
            MovieClip.prototype.createClassChildAtDepth = createClassChildAtDepth;
            MovieClip.prototype.createChildAtDepth = createChildAtDepth;
            MovieClip.prototype.setDepthTo = setDepthTo;
            MovieClip.prototype.setDepthAbove = setDepthAbove;
            MovieClip.prototype.setDepthBelow = setDepthBelow;
            MovieClip.prototype.findNextAvailableDepth = findNextAvailableDepth;
            MovieClip.prototype.shuffleDepths = shuffleDepths;
            MovieClip.prototype.getDepthByFlag = getDepthByFlag;
            MovieClip.prototype.buildDepthTable = buildDepthTable;
            _global.ASSetPropFlags(MovieClip.prototype, "createClassChildAtDepth", 1);
            _global.ASSetPropFlags(MovieClip.prototype, "createChildAtDepth", 1);
            _global.ASSetPropFlags(MovieClip.prototype, "setDepthTo", 1);
            _global.ASSetPropFlags(MovieClip.prototype, "setDepthAbove", 1);
            _global.ASSetPropFlags(MovieClip.prototype, "setDepthBelow", 1);
            _global.ASSetPropFlags(MovieClip.prototype, "findNextAvailableDepth", 1);
            _global.ASSetPropFlags(MovieClip.prototype, "shuffleDepths", 1);
            _global.ASSetPropFlags(MovieClip.prototype, "getDepthByFlag", 1);
            _global.ASSetPropFlags(MovieClip.prototype, "buildDepthTable", 1);
        }
        static function sortFunction(a, b) {
            if (a.getDepth() > b.getDepth()) {
                return(1);
            }
            return(-1);
        }
        static function test(depth) {
            if (depth == reservedDepth) {
                return(false);
            } else {
                return(true);
            }
        }
        static function createClassObjectAtDepth(className, depthSpace, initObj) {
            var _local_1;
            switch (depthSpace) {
                case kCursor : 
                    _local_1 = holder.createClassChildAtDepth(className, kTopmost, initObj);
                    break;
                case kTooltip : 
                    _local_1 = holder.createClassChildAtDepth(className, kTop, initObj);
                    break;
                default : 
                    break;
            }
            return(_local_1);
        }
        static function createObjectAtDepth(linkageName, depthSpace, initObj) {
            var _local_1;
            switch (depthSpace) {
                case kCursor : 
                    _local_1 = holder.createChildAtDepth(linkageName, kTopmost, initObj);
                    break;
                case kTooltip : 
                    _local_1 = holder.createChildAtDepth(linkageName, kTop, initObj);
                    break;
                default : 
                    break;
            }
            return(_local_1);
        }
        function createClassChildAtDepth(className, depthFlag, initObj) {
            if (_childCounter == undefined) {
                _childCounter = 0;
            }
            var _local_3 = buildDepthTable();
            var _local_2 = getDepthByFlag(depthFlag, _local_3);
            var _local_6 = "down";
            if (depthFlag == kBottom) {
                _local_6 = "up";
            }
            var _local_5;
            if (_local_3[_local_2] != undefined) {
                _local_5 = _local_2;
                _local_2 = findNextAvailableDepth(_local_2, _local_3, _local_6);
            }
            var _local_4 = createClassObject(className, "depthChild" + (_childCounter++), _local_2, initObj);
            if (_local_5 != undefined) {
                _local_3[_local_2] = _local_4;
                shuffleDepths(_local_4, _local_5, _local_3, _local_6);
            }
            if (depthFlag == kTopmost) {
                _local_4._topmost = true;
            }
            return(_local_4);
        }
        function createChildAtDepth(linkageName, depthFlag, initObj) {
            if (_childCounter == undefined) {
                _childCounter = 0;
            }
            var _local_3 = buildDepthTable();
            var _local_2 = getDepthByFlag(depthFlag, _local_3);
            var _local_6 = "down";
            if (depthFlag == kBottom) {
                _local_6 = "up";
            }
            var _local_5;
            if (_local_3[_local_2] != undefined) {
                _local_5 = _local_2;
                _local_2 = findNextAvailableDepth(_local_2, _local_3, _local_6);
            }
            var _local_4 = createObject(linkageName, "depthChild" + (_childCounter++), _local_2, initObj);
            if (_local_5 != undefined) {
                _local_3[_local_2] = _local_4;
                shuffleDepths(_local_4, _local_5, _local_3, _local_6);
            }
            if (depthFlag == kTopmost) {
                _local_4._topmost = true;
            }
            return(_local_4);
        }
        function setDepthTo(depthFlag) {
            var _local_2 = _parent.buildDepthTable();
            var _local_3 = _parent.getDepthByFlag(depthFlag, _local_2);
            if (_local_2[_local_3] != undefined) {
                shuffleDepths(this, _local_3, _local_2, undefined);
            } else {
                this.swapDepths(_local_3);
            }
            if (depthFlag == kTopmost) {
                _topmost = true;
            } else {
                delete _topmost;
            }
        }
        function setDepthAbove(targetInstance) {
            if (targetInstance._parent != _parent) {
                return(undefined);
            }
            var _local_2 = targetInstance.getDepth() + 1;
            var _local_3 = _parent.buildDepthTable();
            if ((_local_3[_local_2] != undefined) && (this.getDepth() < _local_2)) {
                _local_2 = _local_2 - 1;
            }
            if (_local_2 > highestDepth) {
                _local_2 = highestDepth;
            }
            if (_local_2 == highestDepth) {
                _parent.shuffleDepths(this, _local_2, _local_3, "down");
            } else if (_local_3[_local_2] != undefined) {
                _parent.shuffleDepths(this, _local_2, _local_3, undefined);
            } else {
                this.swapDepths(_local_2);
            }
        }
        function setDepthBelow(targetInstance) {
            if (targetInstance._parent != _parent) {
                return(undefined);
            }
            var _local_6 = targetInstance.getDepth() - 1;
            var _local_3 = _parent.buildDepthTable();
            if ((_local_3[_local_6] != undefined) && (this.getDepth() > _local_6)) {
                _local_6 = _local_6 + 1;
            }
            var _local_4 = lowestDepth + numberOfAuthortimeLayers;
            var _local_5;
            for (_local_5 in _local_3) {
                var _local_2 = _local_3[_local_5];
                if (_local_2._parent != undefined) {
                    _local_4 = Math.min(_local_4, _local_2.getDepth());
                }
            }
            if (_local_6 < _local_4) {
                _local_6 = _local_4;
            }
            if (_local_6 == _local_4) {
                _parent.shuffleDepths(this, _local_6, _local_3, "up");
            } else if (_local_3[_local_6] != undefined) {
                _parent.shuffleDepths(this, _local_6, _local_3, undefined);
            } else {
                this.swapDepths(_local_6);
            }
        }
        function findNextAvailableDepth(targetDepth, depthTable, direction) {
            var _local_5 = lowestDepth + numberOfAuthortimeLayers;
            if (targetDepth < _local_5) {
                targetDepth = _local_5;
            }
            if (depthTable[targetDepth] == undefined) {
                return(targetDepth);
            }
            var _local_2 = targetDepth;
            var _local_1 = targetDepth;
            if (direction == "down") {
                while (depthTable[_local_1] != undefined) {
                    _local_1--;
                }
                return(_local_1);
            }
            while (depthTable[_local_2] != undefined) {
                _local_2++;
            }
            return(_local_2);
        }
        function shuffleDepths(subject, targetDepth, depthTable, direction) {
            var _local_9 = lowestDepth + numberOfAuthortimeLayers;
            var _local_8 = _local_9;
            var _local_5;
            for (_local_5 in depthTable) {
                var _local_7 = depthTable[_local_5];
                if (_local_7._parent != undefined) {
                    _local_9 = Math.min(_local_9, _local_7.getDepth());
                }
            }
            if (direction == undefined) {
                if (subject.getDepth() > targetDepth) {
                    direction = "up";
                } else {
                    direction = "down";
                }
            }
            var _local_1 = new Array();
            for (_local_5 in depthTable) {
                var _local_7 = depthTable[_local_5];
                if (_local_7._parent != undefined) {
                    _local_1.push(_local_7);
                }
            }
            _local_1.sort(sortFunction);
            if (direction == "up") {
                var _local_3;
                var _local_11;
                do {
                    if (_local_1.length <= 0) { 
                        break;
                    }
                    _local_3 = _local_1.pop();
                } while  (_local_3 != subject);
                do {
                    if (_local_1.length <= 0) { 
                        break;
                    }
                    _local_11 = subject.getDepth();
                    _local_3 = _local_1.pop();
                    var _local_4 = _local_3.getDepth();
                    if (_local_11 > (_local_4 + 1)) {
                        if (_local_4 >= 0) {
                            subject.swapDepths(_local_4 + 1);
                        } else if ((_local_11 > _local_8) && (_local_4 < _local_8)) {
                            subject.swapDepths(_local_8);
                        }
                    }
                    subject.swapDepths(_local_3);
                } while  (_local_4 != targetDepth);
            } else if (direction == "down") {
                var _local_3;
                do {
                    if (_local_1.length <= 0) { 
                        break;
                    }
                    _local_3 = _local_1.shift();
                } while  (_local_3 != subject);
                do {
                    if (_local_1.length <= 0) { 
                        break;
                    }
                    var _local_11 = _local_3.getDepth();
                    _local_3 = _local_1.shift();
                    var _local_4 = _local_3.getDepth();
                    if ((_local_11 < (_local_4 - 1)) && (_local_4 > 0)) {
                        subject.swapDepths(_local_4 - 1);
                    }
                    subject.swapDepths(_local_3);
                } while  (_local_4 != targetDepth);
            }
        }
        function getDepthByFlag(depthFlag, depthTable) {
            var _local_2 = 0;
            if ((depthFlag == kTop) || (depthFlag == kNotopmost)) {
                var _local_5 = 0;
                var _local_7 = false;
                var _local_8;
                for (_local_8 in depthTable) {
                    var _local_9 = depthTable[_local_8];
                    var _local_3 = typeof(_local_9);
                    if ((_local_3 == "movieclip") || ((_local_3 == "object") && (_local_9.__getTextFormat != undefined))) {
                        if (_local_9.getDepth() <= highestDepth) {
                            if (!_local_9._topmost) {
                                _local_2 = Math.max(_local_2, _local_9.getDepth());
                            } else if (!_local_7) {
                                _local_5 = _local_9.getDepth();
                                _local_7 = true;
                            } else {
                                _local_5 = Math.min(_local_5, _local_9.getDepth());
                            }
                        }
                    }
                }
                _local_2 = _local_2 + 20;
                if (_local_7) {
                    if (_local_2 >= _local_5) {
                        _local_2 = _local_5 - 1;
                    }
                }
            } else if (depthFlag == kBottom) {
                for (var _local_8 in depthTable) {
                    var _local_9 = depthTable[_local_8];
                    var _local_3 = typeof(_local_9);
                    if ((_local_3 == "movieclip") || ((_local_3 == "object") && (_local_9.__getTextFormat != undefined))) {
                        if (_local_9.getDepth() <= highestDepth) {
                            _local_2 = Math.min(_local_2, _local_9.getDepth());
                        }
                    }
                }
                _local_2 = _local_2 - 20;
            } else if (depthFlag == kTopmost) {
                for (var _local_8 in depthTable) {
                    var _local_9 = depthTable[_local_8];
                    var _local_3 = typeof(_local_9);
                    if ((_local_3 == "movieclip") || ((_local_3 == "object") && (_local_9.__getTextFormat != undefined))) {
                        if (_local_9.getDepth() <= highestDepth) {
                            _local_2 = Math.max(_local_2, _local_9.getDepth());
                        }
                    }
                }
                _local_2 = _local_2 + 100;
            }
            if (_local_2 >= highestDepth) {
                _local_2 = highestDepth;
            }
            var _local_6 = lowestDepth + numberOfAuthortimeLayers;
            for (var _local_9 in depthTable) {
                var _local_4 = depthTable[_local_9];
                if (_local_4._parent != undefined) {
                    _local_6 = Math.min(_local_6, _local_4.getDepth());
                }
            }
            if (_local_2 <= _local_6) {
                _local_2 = _local_6;
            }
            return(_local_2);
        }
        function buildDepthTable(Void) {
            var _local_5 = new Array();
            var _local_4;
            for (_local_4 in this) {
                var _local_2 = this[_local_4];
                var _local_3 = typeof(_local_2);
                if ((_local_3 == "movieclip") || ((_local_3 == "object") && (_local_2.__getTextFormat != undefined))) {
                    if (_local_2._parent == this) {
                        _local_5[_local_2.getDepth()] = _local_2;
                    }
                }
            }
            return(_local_5);
        }
        static var reservedDepth = 1048575;
        static var highestDepth = 1048574;
        static var lowestDepth = -16383;
        static var numberOfAuthortimeLayers = 383;
        static var kCursor = 101;
        static var kTooltip = 102;
        static var kTop = 201;
        static var kBottom = 202;
        static var kTopmost = 203;
        static var kNotopmost = 204;
        static var holder = _root.createEmptyMovieClip("reserved", reservedDepth);
        static var __depthManager = new mx.managers.DepthManager();
    }
