//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.ui.MascotScript extends MovieClip
    {
        static var _SHELL, _INTERFACE, _AIRTOWER;
        var _categoryHolderClip, _categoryDisplayClip, _mascotChangeClip, _mascotInviteClip, _resizeClip, _backgroundClip, _closeClip, _scrollbarThumb, _scriptUpArrowBtn, _scriptDownArrowBtn, _categoryScrollbarThumb, _categoryUpArrowBtn, _categoryDownArrowBtn, _state, _startIndex, _categoryStartIndex, _currentlyScrolling, _data, _visible, removeMovieClip, startDrag, stopDrag, onEnterFrame, _tabIndex, _characterIndex, _mascotEntryClips, _mascotCategoryClips, _mascotScriptEntryHolderClip, _titleField, _scrollbarBackground, _pixelsPerScrollableUnit, _pixelsPerCategoryScrollableUnit, _categoryScrollbarBackground, _xmouse, _ymouse;
        function MascotScript () {
            super();
            _categoryHolderClip = _categoryDisplayClip._categoryHolderClip;
            _mascotChangeClip.onRelease = com.clubpenguin.util.Delegate.create(this, onChangeMascot);
            _mascotChangeClip.onRollOver = function () {
                this.gotoAndStop("rollover");
            };
            _mascotChangeClip.onRollOut = function () {
                this.gotoAndStop("rollout");
            };
            _mascotChangeClip.onReleaseOutside = function () {
                this.gotoAndStop("rollout");
            };
            _mascotInviteClip.onRelease = com.clubpenguin.util.Delegate.create(this, onInviteRelease);
            _mascotInviteClip.onRollOver = function () {
                this.gotoAndStop("rollover");
            };
            _mascotInviteClip.onRollOut = function () {
                this.gotoAndStop("rollout");
            };
            _mascotInviteClip.onReleaseOutside = function () {
                this.gotoAndStop("rollout");
            };
            _resizeClip.onPress = com.clubpenguin.util.Delegate.create(this, onResize, true);
            _resizeClip.onRelease = com.clubpenguin.util.Delegate.create(this, onResize, false);
            _resizeClip.onReleaseOutside = _resizeClip.onRelease;
            _resizeClip.onRollOver = function () {
                this.gotoAndStop("rollover");
            };
            _resizeClip.onRollOut = function () {
                this.gotoAndStop("rollout");
            };
            _backgroundClip.onPress = com.clubpenguin.util.Delegate.create(this, onDrag, true);
            _backgroundClip.onRelease = com.clubpenguin.util.Delegate.create(this, onDrag, false);
            _backgroundClip.useHandCursor = false;
            _categoryDisplayClip._backgroundClip.onPress = _backgroundClip.onPress;
            _categoryDisplayClip._backgroundClip.onRelease = _backgroundClip.onRelease;
            _categoryDisplayClip._backgroundClip.useHandCursor = false;
            _closeClip.onRollOver = function () {
                this.gotoAndStop("rollover");
            };
            _closeClip.onRollOut = function () {
                this.gotoAndStop("rollout");
            };
            _closeClip.onRelease = com.clubpenguin.util.Delegate.create(this, hide);
            _scrollbarThumb.onPress = com.clubpenguin.util.Delegate.create(this, onDragThumb, true);
            _scrollbarThumb.onRelease = com.clubpenguin.util.Delegate.create(this, onDragThumb, false);
            _scrollbarThumb.onReleaseOutside = _scrollbarThumb.onRelease;
            _scriptUpArrowBtn.onPress = com.clubpenguin.util.Delegate.create(this, onScroll, -1);
            _scriptDownArrowBtn.onPress = com.clubpenguin.util.Delegate.create(this, onScroll, 1);
            _categoryScrollbarThumb.onPress = com.clubpenguin.util.Delegate.create(this, onDragCategoryThumb, true);
            _categoryScrollbarThumb.onRelease = com.clubpenguin.util.Delegate.create(this, onDragCategoryThumb, false);
            _categoryScrollbarThumb.onReleaseOutside = _categoryScrollbarThumb.onRelease;
            _categoryUpArrowBtn.onPress = com.clubpenguin.util.Delegate.create(this, onCategoryScroll, -1);
            _categoryDownArrowBtn.onPress = com.clubpenguin.util.Delegate.create(this, onCategoryScroll, 1);
            _state = STATE_SELECT_MASCOT;
            _startIndex = 0;
            _categoryStartIndex = 0;
            _currentlyScrolling = false;
            _data = _global.getCurrentShell().getMascotMessageArray();
            _SHELL = _global.getCurrentShell();
            _INTERFACE = _global.getCurrentInterface();
            _AIRTOWER = _global.getCurrentAirtower();
            setupMascotCategories();
            setupMascotEntries();
        }
        function show() {
            _visible = true;
        }
        function hide() {
            this.removeMovieClip();
        }
        function onDrag(startDragging) {
            if (startDragging) {
                this.startDrag();
            } else {
                this.stopDrag();
            }
        }
        function onDragThumb(startDragging) {
            if (startDragging) {
                onEnterFrame = updateForScrollbarDrag;
                _currentlyScrolling = true;
            } else {
                onEnterFrame = null;
                _currentlyScrolling = false;
            }
        }
        function onDragCategoryThumb(startDragging) {
            if (startDragging) {
                onEnterFrame = updateForCategoryScrollbarDrag;
                _currentlyScrolling = true;
            } else {
                onEnterFrame = null;
                _currentlyScrolling = false;
            }
        }
        function onScroll(increment) {
            var _local_3 = _startIndex + increment;
            var _local_2 = 0;
            if (_state == STATE_SELECT_MASCOT) {
                _local_2 = _data.length;
            } else if (_state == STATE_SCRIPT) {
                _local_2 = _data[_characterIndex].mascotScript[_tabIndex].script.length;
            }
            if ((_local_3 >= 0) && (_local_3 <= (_local_2 - _mascotEntryClips.length))) {
                _startIndex = _local_3;
                setupMascotEntries();
            }
        }
        function onCategoryScroll(increment) {
            var _local_3 = _categoryStartIndex + increment;
            var _local_2 = 0;
            if (_state == STATE_SELECT_MASCOT) {
                _local_2 = 0;
            } else if (_state == STATE_SCRIPT) {
                var _local_4 = _data[_characterIndex].mascotScript;
                _local_2 = _local_4.length;
            }
            if ((_local_3 >= 0) && (_local_3 <= (_local_2 - _mascotCategoryClips.length))) {
                _categoryStartIndex = _local_3;
                setupMascotCategories();
            }
        }
        function onResize(startResizing) {
            if (startResizing) {
                onEnterFrame = updateForResize;
            } else {
                onEnterFrame = null;
            }
        }
        function onChangeMascot() {
            _state = STATE_SELECT_MASCOT;
            _startIndex = 0;
            _categoryStartIndex = 0;
            setupMascotCategories();
            setupMascotEntries();
        }
        function onInviteRelease() {
            var _local_2 = _SHELL.getMyPlayerObject();
            var _local_4 = _SHELL.getMascotCrumbs();
            var _local_3 = _local_4[_local_2.player_id];
            _local_2.mascot_id = _local_3.mascot_id;
            var _local_1 = new Array();
            _local_1.push(NUM_OF_MASCOT_INVITES);
            _local_1.push(_local_2.mascot_id);
            _AIRTOWER.send(_AIRTOWER.PLAY_EXT, (_AIRTOWER.PLAYER_HANDLER + "#") + MASCOT_INVITE_EXT, _local_1, "str", _SHELL.getCurrentServerRoomId());
        }
        function setupMascotCategories() {
            if (_state == STATE_SELECT_MASCOT) {
                _categoryDisplayClip._visible = false;
            } else if (_state == STATE_SCRIPT) {
                _categoryDisplayClip._visible = true;
                var _local_7 = _mascotCategoryClips.length;
                var _local_3 = 0;
                while (_local_3 < _local_7) {
                    _mascotCategoryClips[_local_3].removeMovieClip();
                    _local_3++;
                }
                var _local_6 = _data[_characterIndex].mascotScript;
                _local_7 = _local_6.length;
                var _local_8 = 0;
                _mascotCategoryClips = new Array();
                _local_3 = 0;
                while (_local_3 < _local_7) {
                    var _local_4 = _local_6[_categoryStartIndex + _local_3].category;
                    var _local_5 = _local_6[_categoryStartIndex + _local_3].categoryActive;
                    if (_local_4 == null) {
                        break;
                    }
                    if (!_local_5) {
                    } else {
                        var _local_2 = _categoryHolderClip.attachMovie("mascotScriptEntryClip", "mascotCategoryEntry" + _local_3, _categoryHolderClip.getNextHighestDepth());
                        _local_2._y = _local_8;
                        _local_2._scriptField.autoSize = true;
                        _local_2._scriptField._width = (_categoryDisplayClip._backgroundClip._width - (2 * _categoryHolderClip._x)) - (2 * _categoryScrollbarThumb._width);
                        _local_2._scriptField.text = _local_4;
                        if (((_local_2._y + _local_2._height) + _categoryHolderClip._y) > _categoryDisplayClip._backgroundClip._height) {
                            _local_2.removeMovieClip();
                            break;
                        }
                        if ((_categoryStartIndex + _local_3) == _tabIndex) {
                            _local_2._scriptField.textColor = SELECTED_CATEGORY_COLOUR;
                        }
                        _local_8 = _local_8 + _local_2._height;
                        _local_2.onRollOver = com.clubpenguin.util.Delegate.create(this, onCategoryHighlight, _local_3, true);
                        _local_2.onRollOut = com.clubpenguin.util.Delegate.create(this, onCategoryHighlight, _local_3, false);
                        _local_2.onRelease = com.clubpenguin.util.Delegate.create(this, onCategoryRelease, _local_3);
                        _mascotCategoryClips[_local_3] = _local_2;
                    }
                    _local_3++;
                }
            }
            if (!_currentlyScrolling) {
                setupCategoryScrollbar();
            }
        }
        function setupMascotEntries() {
            if (_mascotEntryClips != null) {
                var _local_10 = _mascotEntryClips.length;
                var _local_3 = 0;
                while (_local_3 < _local_10) {
                    _mascotEntryClips[_local_3].removeMovieClip();
                    _local_3++;
                }
            }
            _mascotEntryClips = new Array();
            var _local_9 = 0;
            var _local_3 = 0;
            for(;;){
                var _local_4 = "";
                var _local_6 = true;
                var _local_7 = true;
                if (_state == STATE_SELECT_MASCOT) {
                    _local_4 = _data[_startIndex + _local_3].mascotName;
                    _local_6 = _data[_startIndex + _local_3].mascotActive;
                } else if (_state == STATE_SCRIPT) {
                    if (_data[_characterIndex].mascotScript[_tabIndex].sharedScript) {
                        var _local_5 = _data[_characterIndex].mascotScript[_tabIndex].script[_startIndex + _local_3];
                        _local_4 = (_local_5.name + ": ") + _local_5.message;
                        if (_local_5.name != _data[_characterIndex].mascotName) {
                            _local_7 = false;
                        }
                    } else {
                        _local_4 = _data[_characterIndex].mascotScript[_tabIndex].script[_startIndex + _local_3];
                    }
                }
                if ((_local_4 == null) || (_local_4.substr(0, 9) == "undefined")) {
                    break;
                }
                if (!_local_6) {
                } else {
                    var _local_2 = _mascotScriptEntryHolderClip.attachMovie("mascotScriptEntryClip", "mascotScriptEntry" + _local_3, _mascotScriptEntryHolderClip.getNextHighestDepth());
                    _local_2._y = _local_9;
                    _local_2._scriptField.autoSize = true;
                    _local_2._scriptField._width = ((_backgroundClip._width - (2 * _mascotScriptEntryHolderClip._x)) - _scriptUpArrowBtn._width) - _local_2._scriptField._x;
                    _local_2._scriptField.text = _local_4;
                    if (((_local_2._y + _local_2._height) + _mascotScriptEntryHolderClip._y) > _backgroundClip._height) {
                        _local_2.removeMovieClip();
                        break;
                    }
                    var _local_8 = 10;
                    if (_local_2._scriptField.textWidth < _local_2._scriptField._width) {
                        _local_2._scriptField._width = _local_2._scriptField.textWidth + _local_8;
                    }
                    _local_9 = _local_9 + _local_2._height;
                    if (_local_7) {
                        _local_2.onRollOver = com.clubpenguin.util.Delegate.create(this, onScriptHighlight, _local_3, true);
                        _local_2.onRollOut = com.clubpenguin.util.Delegate.create(this, onScriptHighlight, _local_3, false);
                        _local_2.onRelease = com.clubpenguin.util.Delegate.create(this, onScriptRelease, _local_3);
                    } else {
                        _local_2._scriptField.textColor = NON_INTERACTIVE_TEXT_COLOUR;
                    }
                    _mascotEntryClips[_local_3] = _local_2;
                }
                _local_3++;
            };
            if (_state == STATE_SELECT_MASCOT) {
                _titleField.text = "SELECT A MASCOT";
            } else if (_state == STATE_SCRIPT) {
                _titleField.text = _data[_characterIndex].mascotName.toUpperCase() + " SCRIPTS";
            }
            if (!_currentlyScrolling) {
                setupScrollbar();
            }
        }
        function setupScrollbar() {
            var _local_3 = _mascotEntryClips.length;
            var _local_2 = 0;
            if (_state == STATE_SELECT_MASCOT) {
                _local_2 = _data.length;
            } else if (_state == STATE_SCRIPT) {
                _local_2 = _data[_characterIndex].mascotScript[_tabIndex].script.length;
            }
            if (_local_3 >= _local_2) {
                _scrollbarThumb._visible = false;
                _scrollbarBackground._visible = false;
                _scriptUpArrowBtn._visible = false;
                _scriptDownArrowBtn._visible = false;
            } else {
                _scrollbarThumb._visible = true;
                _scrollbarBackground._visible = true;
                _scriptUpArrowBtn._visible = true;
                _scriptDownArrowBtn._visible = true;
                var _local_4 = _local_2 - _local_3;
                _pixelsPerScrollableUnit = (_scrollbarBackground._height - _scrollbarThumb._height) / _local_4;
                _scrollbarThumb._y = _scrollbarBackground._y + (_startIndex * _pixelsPerScrollableUnit);
            }
        }
        function setupCategoryScrollbar() {
            (_pixelsPerCategoryScrollableUnit);// not popped
            var _local_3 = _mascotCategoryClips.length;
            var _local_2 = 0;
            if (_state == STATE_SELECT_MASCOT) {
                _local_2 = 0;
            } else if (_state == STATE_SCRIPT) {
                var _local_5 = _data[_characterIndex].mascotScript;
                _local_2 = _local_5.length;
            }
            if (_local_3 >= _local_2) {
                _categoryScrollbarThumb._visible = false;
                _categoryScrollbarBackground._visible = false;
                _categoryUpArrowBtn._visible = false;
                _categoryDownArrowBtn._visible = false;
            } else {
                _categoryScrollbarThumb._visible = true;
                _categoryScrollbarBackground._visible = true;
                _categoryUpArrowBtn._visible = true;
                _categoryDownArrowBtn._visible = true;
                var _local_4 = _local_2 - _local_3;
                _pixelsPerCategoryScrollableUnit = (_categoryScrollbarBackground._height - _categoryScrollbarThumb._height) / _local_4;
                _categoryScrollbarThumb._y = _categoryScrollbarBackground._y + (_categoryStartIndex * _pixelsPerCategoryScrollableUnit);
            }
        }
        function onScriptHighlight(clipIdx, highlightState) {
            if (highlightState) {
                _mascotEntryClips[clipIdx]._scriptField.textColor = HIGHLIGHTED_SCRIPT_TEXT_COLOUR;
            } else {
                _mascotEntryClips[clipIdx]._scriptField.textColor = UNHIGHLIGHTED_TEXT_COLOUR;
            }
        }
        function onCategoryHighlight(clipIdx, highlightState) {
            if (highlightState) {
                _mascotCategoryClips[clipIdx]._scriptField.textColor = HIGHLIGHTED_CATEGORY_TEXT_COLOUR;
            } else if ((_categoryStartIndex + clipIdx) == _tabIndex) {
                _mascotCategoryClips[clipIdx]._scriptField.textColor = SELECTED_CATEGORY_COLOUR;
            } else {
                _mascotCategoryClips[clipIdx]._scriptField.textColor = UNHIGHLIGHTED_TEXT_COLOUR;
            }
        }
        function onScriptRelease(clipIdx) {
            if (_state == STATE_SELECT_MASCOT) {
                _characterIndex = _startIndex + clipIdx;
                _tabIndex = 0;
                _startIndex = 0;
                _state = STATE_SCRIPT;
                setupMascotCategories();
                setupMascotEntries();
            } else if (_state == STATE_SCRIPT) {
                var _local_4 = _global.getCurrentInterface();
                var _local_3 = getMessageId(_characterIndex, _tabIndex, _startIndex + clipIdx);
                _local_4.sendMascotMessage(_local_3);
            }
        }
        function getMessageId(chosenCharacterIdx, chosenCategoryIdx, scriptIdx) {
            var _local_6 = 0;
            var _local_3 = 0;
            while (_local_3 <= chosenCharacterIdx) {
                var _local_5 = _data[_local_3].mascotScript;
                var _local_7 = _local_5.length;
                var _local_2 = 0;
                while (_local_2 < _local_7) {
                    if ((_local_3 == chosenCharacterIdx) && (_local_2 == chosenCategoryIdx)) {
                        return(_local_6 + scriptIdx);
                    }
                    var _local_4 = _local_5[_local_2].script;
                    _local_6 = _local_6 + _local_4.length;
                    _local_2++;
                }
                _local_3++;
            }
            return(null);
        }
        function onCategoryRelease(clipIdx) {
            var _local_2 = _tabIndex - _categoryStartIndex;
            _mascotCategoryClips[_local_2]._scriptField.textColor = UNHIGHLIGHTED_TEXT_COLOUR;
            _startIndex = 0;
            _tabIndex = _categoryStartIndex + clipIdx;
            setupMascotEntries();
        }
        function updateForResize() {
            _resizeClip._x = _xmouse;
            _resizeClip._y = _ymouse;
            var _local_5 = _resizeClip._x - (_resizeClip._width / 2);
            var _local_4 = _resizeClip._y - (_resizeClip._height / 2);
            if (_local_5 < MIN_WIDTH) {
                _local_5 = MIN_WIDTH;
            }
            if (_local_4 < MIN_HEIGHT) {
                _local_4 = MIN_HEIGHT;
            }
            _resizeClip._x = _local_5;
            _resizeClip._y = _local_4;
            var _local_6 = _backgroundClip._width;
            var _local_7 = _backgroundClip._height;
            _backgroundClip._width = _local_5 + _resizeClip._width;
            _backgroundClip._height = _local_4 + _resizeClip._height;
            var _local_2 = _backgroundClip._width - _local_6;
            var _local_3 = _backgroundClip._height - _local_7;
            _mascotChangeClip._x = _mascotChangeClip._x + _local_2;
            _closeClip._x = _closeClip._x + _local_2;
            _mascotInviteClip._x = _mascotInviteClip._x + _local_2;
            _scriptUpArrowBtn._x = _scriptUpArrowBtn._x + _local_2;
            _scriptDownArrowBtn._x = _scriptDownArrowBtn._x + _local_2;
            _scriptDownArrowBtn._y = _scriptDownArrowBtn._y + _local_3;
            _categoryDisplayClip._backgroundClip._height = _categoryDisplayClip._backgroundClip._height + _local_3;
            _titleField._width = _mascotChangeClip._x;
            _scrollbarBackground._height = _scrollbarBackground._height + _local_3;
            _scrollbarBackground._x = _scrollbarBackground._x + _local_2;
            _scrollbarThumb._x = _scrollbarThumb._x + _local_2;
            _categoryScrollbarBackground._height = _categoryScrollbarBackground._height + _local_3;
            _categoryDownArrowBtn._y = _categoryDownArrowBtn._y + _local_3;
            if ((_local_2 != 0) || (_local_3 != 0)) {
                setupMascotEntries();
                setupMascotCategories();
                setupScrollbar();
                setupCategoryScrollbar();
            }
        }
        function updateForScrollbarDrag() {
            _scrollbarThumb._y = _ymouse - (_scrollbarThumb._height / 2);
            if (_scrollbarThumb._y < _scrollbarBackground._y) {
                _scrollbarThumb._y = _scrollbarBackground._y;
            } else if (_scrollbarThumb._y > ((_scrollbarBackground._y + _scrollbarBackground._height) - _scrollbarThumb._height)) {
                _scrollbarThumb._y = (_scrollbarBackground._y + _scrollbarBackground._height) - _scrollbarThumb._height;
            }
            var _local_2 = Math.round((_scrollbarThumb._y - _scrollbarBackground._y) / _pixelsPerScrollableUnit);
            if (_local_2 != _startIndex) {
                _startIndex = _local_2;
                setupMascotEntries();
            }
        }
        function updateForCategoryScrollbarDrag() {
            _categoryScrollbarThumb._y = _ymouse - (_categoryScrollbarThumb._height / 2);
            if (_categoryScrollbarThumb._y < _categoryScrollbarBackground._y) {
                _categoryScrollbarThumb._y = _categoryScrollbarBackground._y;
            } else if (_categoryScrollbarThumb._y > ((_categoryScrollbarBackground._y + _categoryScrollbarBackground._height) - _categoryScrollbarThumb._height)) {
                _categoryScrollbarThumb._y = (_categoryScrollbarBackground._y + _categoryScrollbarBackground._height) - _categoryScrollbarThumb._height;
            }
            var _local_2 = Math.round((_categoryScrollbarThumb._y - _categoryScrollbarBackground._y) / _pixelsPerCategoryScrollableUnit);
            if (_local_2 != _categoryStartIndex) {
                _categoryStartIndex = _local_2;
                setupMascotCategories();
            }
        }
        static function debugDrawVert(holder, startX, startY, height, label, col, width) {
            holder.lineStyle(1, col);
            holder.moveTo(startX, startY);
            holder.lineTo(startX - width, startY);
            holder.lineTo(startX - width, startY + height);
            holder.lineTo(startX, startY + height);
            holder.moveTo(startX - width, startY + (height / 2));
            holder.lineTo(startX - (width * 2), startY + (height / 2));
        }
        static function debugTrace(msg) {
            if (DEBUG_TRACE_ACTIVE) {
            }
        }
        static var DEBUG_TRACE_ACTIVE = false;
        static var MIN_WIDTH = 100;
        static var MIN_HEIGHT = 100;
        static var STATE_SELECT_MASCOT = 1;
        static var STATE_SCRIPT = 2;
        static var NON_INTERACTIVE_TEXT_COLOUR = 7829367;
        static var UNHIGHLIGHTED_TEXT_COLOUR = 13421772;
        static var HIGHLIGHTED_SCRIPT_TEXT_COLOUR = 13656160;
        static var HIGHLIGHTED_CATEGORY_TEXT_COLOUR = 6316128;
        static var SELECTED_CATEGORY_COLOUR = 1052688;
        static var NUM_OF_MASCOT_INVITES = 10;
        static var MASCOT_INVITE_EXT = "smi";
    }
