//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.card.Card extends com.clubpenguin.games.card.BaseObject
    {
        var _id, _type, _atr, _pt, _col, _glow, _pow, _lock, _mc, _state, _face, _loaded, dispatchEvent, addEventListener;
        function Card (cardStr) {
            super();
            var _local_3 = new Array();
            _local_3 = cardStr.split("|");
            _id = _local_3[0];
            _type = _local_3[1];
            _atr = _local_3[2];
            _pt = _local_3[3];
            switch (_local_3[4]) {
                case "r" : 
                    _col = 14826534 /* 0xE23C26 */;
                    _glow = {ra:45, rb:153, ga:45, gb:30, ba:45, bb:5, aa:80, ab:0};
                    break;
                case "g" : 
                    _col = 6404422 /* 0x61B946 */;
                    _glow = {ra:50, rb:49, ga:50, gb:93, ba:50, bb:35, aa:80, ab:0};
                    break;
                case "b" : 
                    _col = 1132705 /* 0x1148A1 */;
                    _glow = {ra:55, rb:12, ga:55, gb:41, ba:55, bb:158, aa:80, ab:0};
                    break;
                case "p" : 
                    _col = 10721738 /* 0xA399CA */;
                    _glow = {ra:45, rb:102, ga:45, gb:77, ba:45, bb:101, aa:80, ab:0};
                    break;
                case "o" : 
                    _col = 16225579 /* 0xF7952B */;
                    _glow = {ra:45, rb:153, ga:45, gb:86, ba:45, bb:15, aa:80, ab:0};
                    break;
                case "y" : 
                    _col = 16509741 /* 0xFBEB2D */;
                    _glow = {ra:35, rb:150, ga:35, gb:153, ba:35, bb:15, aa:80, ab:0};
                    break;
            }
            _pow = _local_3[5];
            _lock = true;
            mx.events.EventDispatcher.initialize(this);
        }
        function get id() {
            return(_id);
        }
        function get type() {
            return(_type);
        }
        function get atr() {
            return(_atr);
        }
        function get pt() {
            return(_pt);
        }
        function get col() {
            return(_col);
        }
        function get pow() {
            return(_pow);
        }
        function get mc() {
            return(_mc);
        }
        function get lock() {
            return(_lock);
        }
        function set lock(lock) {
            _lock = lock;
            if (!lock) {
                setState("front");
            }
            //return(this.lock);
        }
        function createGraphic(parent, seat, show) {
            _mc = parent.attachMovie("card", (("card_" + seat) + "_") + _id, parent.getNextHighestDepth(), {_x:com.clubpenguin.games.card.Layout.POS_CARD_OFFSCREEN.x, _y:com.clubpenguin.games.card.Layout.POS_CARD_OFFSCREEN.y, useHandCursor:false});
            if (show) {
                setState("front", com.clubpenguin.games.card.Layout.SCALE_CARD_NORMAL);
                _mc.onPress = com.clubpenguin.util.Delegate.create(this, onPick);
                _mc.onRollOver = com.clubpenguin.util.Delegate.create(this, onRollOver);
                _mc.onRollOut = com.clubpenguin.util.Delegate.create(this, onRollOut);
            } else {
                setState("back", com.clubpenguin.games.card.Layout.SCALE_CARD_BACK);
            }
        }
        function setState(state, scale) {
            _state = state;
            _mc.gotoAndStop(state);
            if (scale != undefined) {
                _mc._xscale = (_mc._yscale = scale);
            }
            switch (state) {
                case "front" : 
                case "thumbnail" : 
                    _face = true;
                    _mc.mc_atr.gotoAndStop(_atr);
                    _mc.mc_pt.cacheAsBitmap = false;
                    _mc.mc_pt.tf_pt.text = _pt;
                    _mc.mc_pt.cacheAsBitmap = true;
                    new Color(_mc.mc_col).setRGB(_col);
                    _mc.mc_art._visible = true;
                    ((_pow != 0) ? (glow(true)) : (glow(false)));
                    if (!_loaded) {
                        loadArt(true);
                    }
                    break;
                case "back" : 
                    _face = false;
                    _lock = true;
                    break;
                default : 
                    break;
            }
        }
        function disable() {
            _lock = true;
            setState("disabled");
        }
        function glow(enable) {
            if (!enable) {
                _mc.mc_glow._visible = false;
            } else {
                _mc.mc_glow._visible = true;
                var _local_2 = new Color(_mc.mc_glow);
                _local_2.setTransform(_glow);
            }
        }
        function tweenTo(x, y, time) {
            gs.TweenMax.to(_mc, time, {_x:x, _y:y, onComplete:com.clubpenguin.util.Delegate.create(this, tweened)});
        }
        function tweened() {
            dispatchEvent({target:this, type:CARD_TWEENED});
        }
        function tweenToDealtSlots(dir, slots, pos) {
            var _local_2 = 0;
            while (_local_2 < slots.length) {
                if (slots[_local_2] == null) {
                    var _local_3 = ((_state == "front") ? (com.clubpenguin.games.card.Layout.DEALT_FRONT_SPACER) : (com.clubpenguin.games.card.Layout.DEALT_BACK_SPACER));
                    ((dir == 0) ? (tweenTo(pos.x + (_local_3 * _local_2), pos.y, 0.5)) : (tweenTo((pos.x - _local_3) - (_local_3 * _local_2), pos.y, 0.5)));
                    slots[_local_2] = this;
                    return(undefined);
                }
                _local_2++;
            }
            com.clubpenguin.util.Debug.log("CANNOT FIND AVAILABLE SLOTS...", "ERROR");
        }
        function onRollOver() {
            if (_lock) {
                return(undefined);
            }
            _mc.swapDepths(com.clubpenguin.games.card.GameEngine.root_mc.getNextHighestDepth());
            if (_pow != 0) {
                setState("pow");
                _mc.pow_msg.text = com.clubpenguin.util.LocaleText.getText("pow_" + _pow);
                _mc.pow_mc.gotoAndStop(_pow);
            } else {
                setState("over");
            }
        }
        function onRollOut() {
            if (_lock) {
                return(undefined);
            }
            setState("front");
        }
        function onPick() {
            if (_lock) {
                return(undefined);
            }
            dispatchEvent({target:this, type:CARD_PICKED, id:_id});
            _mc.onPress = (_mc.onRollOver = (_mc.onRollOut = null));
        }
        function flip(time) {
            loadArt(false);
            addEventListener(CARD_LOADED, com.clubpenguin.util.Delegate.create(this, onFlipInit, time));
        }
        function onFlipInit(target, time) {
            gs.TweenMax.sequence(_mc, [{time:time, _xscale:0, _x:_mc._x + (_mc._width / 2), blurFilter:{blurX:10, quality:2}}, {time:time, _xscale:com.clubpenguin.games.card.Layout.SCALE_CARD_FLIP, _x:_mc._x, blurFilter:{blurX:0, quality:2}, onStart:com.clubpenguin.util.Delegate.create(this, setState), onStartParams:["front", com.clubpenguin.games.card.Layout.SCALE_CARD_FLIP], onComplete:com.clubpenguin.util.Delegate.create(this, onFlipComplete)}]);
        }
        function onFlipComplete() {
            dispatchEvent({target:this, type:CARD_FLIPPED});
        }
        function loadArt(show) {
            var _local_3 = new MovieClipLoader();
            var _local_2 = new Object();
            _local_2.onLoadStart = com.clubpenguin.util.Delegate.create(this, onLoadStart);
            _local_2.onLoadInit = com.clubpenguin.util.Delegate.create(this, onLoadInit, show, _local_3, _local_2);
            _local_2.onLoadProgress = com.clubpenguin.util.Delegate.create(this, onLoadProgress);
            _local_2.onLoadError = com.clubpenguin.util.Delegate.create(this, onLoadError);
            _local_3.addListener(_local_2);
            _local_3.loadClip((CARD_FILE_PATH + _type) + ".swf", _mc.mc_art);
        }
        function onLoadStart(target) {
        }
        function onLoadInit(target, show, loader, listener) {
            _loaded = true;
            _mc.mc_art._visible = show;
            loader.removeListener(listener);
            dispatchEvent({target:this, type:CARD_LOADED});
        }
        function onLoadProgress(target, progress, total) {
        }
        function onLoadError(target, error) {
            com.clubpenguin.util.Debug.log("Error Loading: " + error, "ERROR");
        }
        function destroy() {
            var _local_2 = _mc.attachMovie("explosion", "mc_explosion", _mc.getNextHighestDepth());
            if (_state == "thumbnail") {
                _local_2._xscale = 50;
                _local_2._yscale = 50;
            }
            _local_2.explosed = com.clubpenguin.util.Delegate.create(this, terminate);
        }
        function terminate() {
            for (var _local_2 in this) {
                var _local_2 = null;
            }
            _mc.removeMovieClip();
        }
        function toString() {
            return(((((((((((("[" + _id) + "|") + _type) + "|") + _atr) + "|") + _pt) + "|") + _col) + "|") + _pow) + "]");
        }
        static var CLASS_PACKAGE = "com.clubpenguin.games.card";
        static var CLASS_NAME = "Card";
        static var CARD_FILE_PATH = _global.getCurrentShell().getGameContentPath() + "/card/icons/";
        static var CARD_LOADED = "onCardLoaded";
        static var CARD_PICKED = "onCardPicked";
        static var CARD_FLIPPED = "onCardFlipped";
        static var CARD_TWEENED = "onCardTweened";
        var __classPackage = CLASS_PACKAGE;
        var __className = CLASS_NAME;
    }
