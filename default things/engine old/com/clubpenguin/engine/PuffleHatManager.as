class com.clubpenguin.engine.PuffleHatManager
{
    function PuffleHatManager(shell, puffleCanvas, puffleHatVO, hatLocEnum)
    {
        _shell = shell;
        _puffleCanvas = puffleCanvas;
        _puffleHatVO = puffleHatVO;
        _hatLocation = hatLocEnum != undefined ? (hatLocEnum) : (com.clubpenguin.engine.PuffleHatLocEnum.NULL_HAT_LOC);
        this.init();
    } // End of the function
    function init()
    {
        if (_hatLocation == com.clubpenguin.engine.PuffleHatLocEnum.NULL_HAT_LOC)
        {
            return;
        } // end if
        _hatForeground = _puffleCanvas[com.clubpenguin.engine.PuffleHatManager.HAT_FOREGROUND];
        _hatBackground = _puffleCanvas[com.clubpenguin.engine.PuffleHatManager.HAT_BACKGROUND];
        this.setHatPath();
        this.hideHat();
        this.loadHatFront();
    } // End of the function
    function setHatPath()
    {
        switch (_hatLocation)
        {
            case com.clubpenguin.engine.PuffleHatLocEnum.IGLOO_HAT_LOC:
            {
                _hatPath = _shell.getGlobalContentPath() + com.clubpenguin.engine.PuffleHatManager.PUFFLE_HATS + com.clubpenguin.engine.PuffleHatManager.IGLOO;
                break;
            } 
            case com.clubpenguin.engine.PuffleHatLocEnum.PLAYER_CARD_HAT_LOC:
            {
                _hatPath = _shell.getGlobalContentPath() + com.clubpenguin.engine.PuffleHatManager.PUFFLE_HATS + com.clubpenguin.engine.PuffleHatManager.PLAYER_CARD;
                break;
            } 
            case com.clubpenguin.engine.PuffleHatLocEnum.WORLD_HAT_LOC:
            default:
            {
                _hatPath = _shell.getGlobalContentPath() + com.clubpenguin.engine.PuffleHatManager.PUFFLE_HATS + com.clubpenguin.engine.PuffleHatManager.ROOM;
                break;
            } 
        } // End of switch
    } // End of the function
    function loadHatFront()
    {
        var _loc2 = _hatPath + _puffleHatVO.hatFrontAsset;
        _frontLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
        _frontLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadHatFront));
        _frontLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, onLoadErrorHat));
        _frontLoader.loadClip(_loc2, _hatForeground, "PuffleHatManager.as loadHatFront()");
    } // End of the function
    function loadHatBack()
    {
        var _loc2 = _hatPath + _puffleHatVO.hatBackAsset;
        _backLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
        _backLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadHatBack));
        _backLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, onLoadErrorHat));
        _backLoader.loadClip(_loc2, _hatBackground, "PuffleHatManager.as loadHatBack()");
    } // End of the function
    function onLoadHatFront(event)
    {
        this.loadHatBack();
        this.removeFrontLoadListeners();
    } // End of the function
    function onLoadHatBack(event)
    {
        this.removeBackLoadListeners();
        this.showHat();
        if (_hatLocation != com.clubpenguin.engine.PuffleHatLocEnum.PLAYER_CARD_HAT_LOC)
        {
            this.setupHatTracking();
        } // end if
    } // End of the function
    function onLoadErrorHat(event)
    {
        for (var _loc3 in event)
        {
        } // end of for...in
        this.removeFrontLoadListeners();
        this.removeBackLoadListeners();
    } // End of the function
    function removeFrontLoadListeners()
    {
        _frontLoader.removeEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadHatFront));
        _frontLoader.removeEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, onLoadErrorHat));
    } // End of the function
    function removeBackLoadListeners()
    {
        _backLoader.removeEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadHatBack));
        _backLoader.removeEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_ERROR, com.clubpenguin.util.Delegate.create(this, onLoadErrorHat));
    } // End of the function
    function hideHat()
    {
        _hatForeground._visible = false;
        _hatBackground._visible = false;
    } // End of the function
    function showHat()
    {
        _hatForeground._visible = true;
        _hatBackground._visible = true;
    } // End of the function
    function setupHatTracking()
    {
        _puffleCanvas.onEnterFrame = com.clubpenguin.util.Delegate.create(this, syncHatToPuffle);
    } // End of the function
    function syncHatToPuffle()
    {
        var _loc2 = _puffleCanvas._currentFrame;
        _hatForeground.gotoAndStop(_loc2);
        _hatBackground.gotoAndStop(_loc2);
        if (_puffleCanvas._width <= 0 || _puffleCanvas._width == undefined || _puffleCanvas._width == null || _loc2 <= 0 || isNaN(_loc2))
        {
            this.doGarbageCollection();
        } // end if
    } // End of the function
    function doGarbageCollection()
    {
        this.removeFrontLoadListeners();
        this.removeBackLoadListeners();
        _puffleCanvas = null;
        _puffleHatVO = null;
        _hatForeground = null;
        _hatBackground = null;
        _shell = null;
        _fullyLoaded = false;
        _frontLoader = null;
        _backLoader = null;
        _puffleCanvas.onEnterFrame = null;
    } // End of the function
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
} // End of Class
