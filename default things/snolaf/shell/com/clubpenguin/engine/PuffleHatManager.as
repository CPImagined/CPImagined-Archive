//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.PuffleHatManager
    {
        function PuffleHatManager (shell, puffleCanvas, puffleHatVO, hatLocEnum) {
            _shell = shell;
            _puffleCanvas = puffleCanvas;
            _puffleHatVO = puffleHatVO;
            _hatLocation = ((hatLocEnum != undefined) ? (hatLocEnum) : (com.clubpenguin.engine.PuffleHatLocEnum.NULL_HAT_LOC));
            init();
        }
        function init() {
            if (_hatLocation == com.clubpenguin.engine.PuffleHatLocEnum.NULL_HAT_LOC) {
                return(undefined);
            }
            _hatForeground = _puffleCanvas[HAT_FOREGROUND];
            _hatBackground = _puffleCanvas[HAT_BACKGROUND];
            setHatPath();
            hideHat();
            loadHatFront();
        }
        function setHatPath() {
            switch (_hatLocation) {
                case com.clubpenguin.engine.PuffleHatLocEnum.IGLOO_HAT_LOC : 
                    _hatPath = (_shell.getGlobalContentPath() + PUFFLE_HATS) + IGLOO;
                    break;
                case com.clubpenguin.engine.PuffleHatLocEnum.PLAYER_CARD_HAT_LOC : 
                    _hatPath = (_shell.getGlobalContentPath() + PUFFLE_HATS) + PLAYER_CARD;
                    break;
                case com.clubpenguin.engine.PuffleHatLocEnum.WORLD_HAT_LOC : 
                default : 
                    _hatPath = (_shell.getGlobalContentPath() + PUFFLE_HATS) + ROOM;
                    break;
            }
        }
        function loadHatFront() {
            var _local_2 = _hatPath + _puffleHatVO.hatFrontAsset;
            _frontLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            _frontLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadHatFront));
            _frontLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, onLoadErrorHat));
            _frontLoader.loadClip(_local_2, _hatForeground, "PuffleHatManager.as loadHatFront()");
        }
        function loadHatBack() {
            var _local_2 = _hatPath + _puffleHatVO.hatBackAsset;
            _backLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            _backLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadHatBack));
            _backLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, onLoadErrorHat));
            _backLoader.loadClip(_local_2, _hatBackground, "PuffleHatManager.as loadHatBack()");
        }
        function onLoadHatFront(event) {
            loadHatBack();
            removeFrontLoadListeners();
        }
        function onLoadHatBack(event) {
            removeBackLoadListeners();
            showHat();
            if (_hatLocation != com.clubpenguin.engine.PuffleHatLocEnum.PLAYER_CARD_HAT_LOC) {
                setupHatTracking();
            }
        }
        function onLoadErrorHat(event) {
            for (var _local_3 in event) {
            }
            removeFrontLoadListeners();
            removeBackLoadListeners();
        }
        function removeFrontLoadListeners() {
            _frontLoader.removeEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadHatFront));
            _frontLoader.removeEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, onLoadErrorHat));
        }
        function removeBackLoadListeners() {
            _backLoader.removeEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadHatBack));
            _backLoader.removeEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, onLoadErrorHat));
        }
        function hideHat() {
            _hatForeground._visible = false;
            _hatBackground._visible = false;
        }
        function showHat() {
            _hatForeground._visible = true;
            _hatBackground._visible = true;
        }
        function setupHatTracking() {
            _puffleCanvas.onEnterFrame = com.clubpenguin.util.Delegate.create(this, syncHatToPuffle);
        }
        function syncHatToPuffle() {
            var _local_2 = _puffleCanvas._currentFrame;
            _hatForeground.gotoAndStop(_local_2);
            _hatBackground.gotoAndStop(_local_2);
            if (((((_puffleCanvas._width <= 0) || (_puffleCanvas._width == undefined)) || (_puffleCanvas._width == null)) || (_local_2 <= 0)) || (isNaN(_local_2))) {
                doGarbageCollection();
            }
        }
        function doGarbageCollection() {
            removeFrontLoadListeners();
            removeBackLoadListeners();
            _puffleCanvas = null;
            _puffleHatVO = null;
            _hatForeground = null;
            _hatBackground = null;
            _shell = null;
            _fullyLoaded = false;
            _frontLoader = null;
            _backLoader = null;
            _puffleCanvas.onEnterFrame = null;
        }
        static var HAT_FOREGROUND = "hatForeground_mc";
        static var HAT_BACKGROUND = "hatBackground_mc";
        static var COUNT_AMOUNT = 2000;
        static var INTERVAL_RATE = 40;
        static var CLOTHING_SPRITES = "clothing_sprites";
        static var CLOTHING_PAPER = "clothing_paper";
        static var HAT = "_hat";
        static var FRONT = "_front";
        static var BACK = "_back";
        static var SWF = ".swf";
        static var PUFFLE_HATS = "puffle/hats/";
        static var IGLOO = "igloo/";
        static var ROOM = "room/";
        static var PLAYER_CARD = "player_card/";
        var _puffleCanvas = null;
        var _puffleHatVO = null;
        var _hatForeground = null;
        var _hatBackground = null;
        var _shell = null;
        var _fullyLoaded = false;
        var _frontLoader = null;
        var _backLoader = null;
        var _hatLocation = null;
        var _hatPath = null;
    }
