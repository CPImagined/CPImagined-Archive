﻿//Created by Action Script Viewer - https://www.buraks.com/asv
    class mx.managers.SystemManager
    {
        static var _xAddEventListener, addEventListener, __addEventListener, _xRemoveEventListener, removeEventListener, __removeEventListener, form, __screen, dispatchEvent;
        function SystemManager () {
        }
        static function init(Void) {
            if (_initialized == false) {
                _initialized = true;
                mx.events.EventDispatcher.initialize(mx.managers.SystemManager);
                Mouse.addListener(mx.managers.SystemManager);
                Stage.addListener(mx.managers.SystemManager);
                _xAddEventListener = addEventListener;
                addEventListener = __addEventListener;
                _xRemoveEventListener = removeEventListener;
                removeEventListener = __removeEventListener;
            }
        }
        static function addFocusManager(f) {
            form = f;
            f.focusManager.activate();
        }
        static function removeFocusManager(f) {
        }
        static function onMouseDown(Void) {
            var _local_1 = form;
            _local_1.focusManager._onMouseDown();
        }
        static function onResize(Void) {
            var _local_7 = Stage.width;
            var _local_6 = Stage.height;
            var _local_9 = _global.origWidth;
            var _local_8 = _global.origHeight;
            var _local_3 = Stage.align;
            var _local_5 = (_local_9 - _local_7) / 2;
            var _local_4 = (_local_8 - _local_6) / 2;
            if (_local_3 == "T") {
                _local_4 = 0;
            } else if (_local_3 == "B") {
                _local_4 = _local_8 - _local_6;
            } else if (_local_3 == "L") {
                _local_5 = 0;
            } else if (_local_3 == "R") {
                _local_5 = _local_9 - _local_7;
            } else if (_local_3 == "LT") {
                _local_4 = 0;
                _local_5 = 0;
            } else if (_local_3 == "TR") {
                _local_4 = 0;
                _local_5 = _local_9 - _local_7;
            } else if (_local_3 == "LB") {
                _local_4 = _local_8 - _local_6;
                _local_5 = 0;
            } else if (_local_3 == "RB") {
                _local_4 = _local_8 - _local_6;
                _local_5 = _local_9 - _local_7;
            }
            if (__screen == undefined) {
                __screen = new Object();
            }
            __screen.x = _local_5;
            __screen.y = _local_4;
            __screen.width = _local_7;
            __screen.height = _local_6;
            _root.focusManager.relocate();
            dispatchEvent({type:"resize"});
        }
        static function get screen() {
            init();
            if (__screen == undefined) {
                mx.managers.SystemManager.onResize();
            }
            return(__screen);
        }
        static var _initialized = false;
        static var idleFrames = 0;
        static var isMouseDown = false;
        static var forms = new Array();
    }
