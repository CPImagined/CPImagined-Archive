//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.ui.PaperDoll
    {
        var __get__shell, __get__ui, __get__isInteractive, __get__fadeAfterLoad;
        function PaperDoll (playerID) {
            _playerID = ((playerID != undefined) ? (playerID) : null);
            _testContainer = _paperDollClip;
            _puffleHatCollection = com.clubpenguin.shell.PuffleHatCollection.getInstance();
        }
        function duplicate(target) {
            if ((paperDollClip == null) || (target.paperDollClip == null)) {
                return(undefined);
            }
            target.colourID = colourID;
            target.flagID = flagID;
            target.backgroundID = backgroundID;
            for (var _local_4 in _paperDollClip) {
                if ((typeof(_paperDollClip[_local_4]) == "movieclip") && (_local_4.substr(0, ATTACH_PREFIX.length) == ATTACH_PREFIX)) {
                    var _local_2 = _paperDollClip[_local_4];
                    target.addItem(_local_2.type, _local_2.id);
                }
            }
        }
        function clear() {
            if (paperDollClip == null) {
                return(undefined);
            }
            for (var _local_3 in _paperDollClip) {
                if ((typeof(_paperDollClip[_local_3]) == "movieclip") && (_local_3.substr(0, ATTACH_PREFIX.length) == ATTACH_PREFIX)) {
                    var _local_2 = _paperDollClip[_local_3];
                    _local_2.removeMovieClip();
                }
            }
            flagID = (0);
            backgroundID = (0);
        }
        function set flagID(id) {
            if (_flagClip == undefined) {
                return;
            }
            if ((id != undefined) && (id != _flagClip.flag_id)) {
                removeMovieClip(_flagClip[ART_CLIP_NAME]);
                if (id > 0) {
                    _flagClip.createEmptyMovieClip(ART_CLIP_NAME, 1);
                    _flagClip[ART_CLIP_NAME]._xscale = FLAG_SCALE;
                    _flagClip[ART_CLIP_NAME]._yscale = FLAG_SCALE;
                    var _local_4 = (flagPath + id) + ".swf";
                    var _local_3 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
                    _local_3.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, itemLoadInit));
                    _local_3.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_START, com.clubpenguin.util.Delegate.create(this, itemLoadStart));
                    _local_3.loadClip(_local_4, _flagClip[ART_CLIP_NAME], "PaperDoll.as flagID()");
                }
                _flagClip.flag_id = id;
            }
            updateFlagInteractivity();
            //return(flagID);
        }
        function get flagID() {
            return(_flagClip.flag_id);
        }
        function set backgroundID(id) {
            if (_backgroundClip == undefined) {
                return;
            }
            if ((id != undefined) && (id != _backgroundClip.photo_id)) {
                removeMovieClip(_backgroundClip[ART_CLIP_NAME]);
                if (id > 0) {
                    _backgroundClip.createEmptyMovieClip(ART_CLIP_NAME, 1);
                    var _local_4 = (backgroundPath + id) + ".swf";
                    var _local_3 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
                    _local_3.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, itemLoadInit));
                    _local_3.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_START, com.clubpenguin.util.Delegate.create(this, itemLoadStart));
                    _local_3.loadClip(_local_4, _backgroundClip[ART_CLIP_NAME], "PaperDoll.as backgroundID()");
                    if (com.clubpenguin.hybrid.AS3Manager.isUnderAS3()) {
                        _backgroundClip[ART_CLIP_NAME]._visible = true;
                        _backgroundClip[ART_CLIP_NAME]._alpha = 100;
                    }
                }
                _backgroundClip.photo_id = id;
            }
            updateBackgroundInteractivity();
            //return(backgroundID);
        }
        function get backgroundID() {
            return(_backgroundClip.photo_id);
        }
        function addItem(type, id) {
            if (((_paperDollClip == null) || (type == null)) || (id == null)) {
                return(undefined);
            }
            var _local_4 = _paperDollClip[(ATTACH_PREFIX + type) + ATTACH_SUFFIX];
            var _local_8 = _local_4.id;
            if (id == _local_8) {
                return(undefined);
            }
            var _local_10 = _shell.getInventoryCrumbsObject();
            var _local_7;
            if (type == BACK_LAYER_NAME) {
                _local_7 = _shell.PAPERDOLLDEPTH_BACK_LAYER;
            } else {
                _local_7 = _local_10[id].layer;
            }
            _local_4.removeMovieClip();
            _local_4 = _paperDollClip.createEmptyMovieClip((ATTACH_PREFIX + type) + ATTACH_SUFFIX, _local_7);
            var _local_11 = _local_4.createEmptyMovieClip("itemClip", _local_4.getNextHighestDepth());
            _local_4.type = type;
            _local_4.id = id;
            if ((type != BACK_LAYER_NAME) && (_shell.getInventoryObjectById(id).is_back)) {
                addItem(BACK_LAYER_NAME, id);
                var _local_9 = _paperDollClip[(ATTACH_PREFIX + BACK_LAYER_NAME) + ATTACH_SUFFIX];
                _local_9.parentType = type;
            } else if ((type != BACK_LAYER_NAME) && (_shell.getInventoryObjectById(_local_8).is_back)) {
                addItem(BACK_LAYER_NAME, 0);
            }
            if (id > 0) {
                var _local_6;
                if (type == BACK_LAYER_NAME) {
                    _local_6 = id + "_back.swf";
                } else {
                    _local_6 = id + ".swf";
                }
                var _local_5 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
                if (type == HAND) {
                    _local_5.setCompleteParams({item_id:id, item_type:type});
                }
                _local_5.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, itemLoadInit));
                _local_5.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_START, com.clubpenguin.util.Delegate.create(this, itemLoadStart));
                _local_5.loadClip(paperdollPath + _local_6, _local_11, "PaperDoll.as addItem()");
            }
            updateItemInteractivity(type);
        }
        function itemLoadInit(event) {
            var _local_2 = event.target;
            var _local_5 = (((event.completeParams.item_id != undefined) && (event.completeParams.item_id > 0)) ? (event.completeParams.item_id) : 0);
            var _local_6 = ((event.completeParams.item_type == HAND) ? true : false);
            if (_fadeAfterLoad) {
                fadePlayerItem(_local_2);
            } else {
                _local_2._alpha = 100;
            }
            var _local_4 = _shell.getLanguageAbbriviation();
            if (_local_4 == _shell.RU_ABBR) {
                _local_2.icon_mc.gotoAndStop("ru");
            }
        }
        function fadePlayerItem(targetClip) {
            targetClip._alpha = FADE_IN_ALPHA_START;
            targetClip.onEnterFrame = function () {
                targetClip._alpha = targetClip._alpha + com.clubpenguin.ui.PaperDoll.FADE_IN_ALPHA_STEP;
                if (targetClip._alpha >= com.clubpenguin.ui.PaperDoll.FADE_IN_ALPHA_END) {
                    delete targetClip.onEnterFrame;
                }
            };
        }
        function loadPuffleItem(puffleColor, puffleId, puffleSubTypeID, hatVO) {
            var _local_2 = _paperDollClip[(ATTACH_PREFIX + puffleId) + ATTACH_SUFFIX];
            if (puffleId == _local_2.puffleId) {
                return(undefined);
            }
            if (_local_2 != undefined) {
                _local_2.removeMovieClip();
            }
            var _local_7 = getClothingDepth("puffle");
            _local_2 = _paperDollClip.createEmptyMovieClip((ATTACH_PREFIX + puffleId) + ATTACH_SUFFIX, _local_7);
            var _local_8 = _local_2.createEmptyMovieClip("itemClip", _local_2.getNextHighestDepth());
            var _local_4 = _shell.getPath("w.puffle.paper");
            _local_4 = com.clubpenguin.shell.PuffleModel.formatAssetURL(_local_4, puffleColor, puffleSubTypeID);
            var _local_6 = new MovieClipLoader();
            var _local_3 = new Object();
            _local_3.onLoadStart = com.clubpenguin.util.Delegate.create(this, itemLoadStart);
            _local_3.onLoadInit = com.clubpenguin.util.Delegate.create(this, puffleItemLoadInit, puffleColor, hatVO);
            _local_6.addListener(_local_3);
            _local_6.loadClip(_local_4, _local_8);
            if (_shell.getPlayerObjectById(_playerID)) {
                updatePuffleItemInteractivity(puffleId);
            }
        }
        function puffleItemLoadInit(targetClip, puffleColor, hatVO) {
            var _local_5 = ((((hatVO != undefined) && (hatVO != null)) && (hatVO.id != com.clubpenguin.shell.puffle.PuffleHatVO.getEmptyHatVO().id)) ? true : false);
            if (_local_5) {
                var _local_4 = ((puffleColor == "white") ? true : false);
                loadPuffleHat(targetClip, hatVO, _local_4);
            }
            if (_fadeAfterLoad) {
                fadePlayerItem(targetClip);
            } else {
                targetClip._alpha = 100;
            }
        }
        function loadPuffleHat(targetClip, puffleHatVO, isWhitePuffle) {
            var _local_2 = targetClip[PUFFLE_MC];
            var _local_3 = new com.clubpenguin.engine.PuffleHatManager(_shell, _local_2, puffleHatVO, com.clubpenguin.engine.PuffleHatLocEnum.PLAYER_CARD_HAT_LOC, isWhitePuffle);
        }
        function itemLoadStart(event) {
            event.target._alpha = 0;
        }
        function getClothingDepth(type) {
            var _local_2 = _layerDepths[type];
            if (_local_2 == null) {
                _shell.$e("[login] getClothingDepth() -> Invalid clothing type");
                _local_2 = _layerDepths.body;
            }
            return(_local_2);
        }
        function set shell(currentShell) {
            _shell = currentShell;
            _layerDepths = _shell.PAPERDOLL_DEFAULT_LAYER_DEPTHS;
            //return(__get__shell());
        }
        function set ui(currentInterface) {
            _interface = currentInterface;
            //return(__get__ui());
        }
        function set colourID(id) {
            if (_paperDollClip != null) {
                _colourID = id;
                var _local_2 = Number(_shell.getPlayerHexFromId(id));
                if (_local_2 != -1) {
                    _shell.setColourFromHex(_paperDollClip.body, Number(_local_2));
                }
            }
            //return(colourID);
        }
        function get colourID() {
            if (_paperDollClip != null) {
                return(_colourID);
            }
            return(null);
        }
        function get flagClip() {
            return(_flagClip);
        }
        function set flagClip(targetClip) {
            if (_flagClip != targetClip) {
                _flagClip = targetClip;
            }
            //return(flagClip);
        }
        function get backgroundClip() {
            return(_backgroundClip);
        }
        function set backgroundClip(targetClip) {
            if (_backgroundClip != targetClip) {
                _backgroundClip = targetClip;
            }
            //return(backgroundClip);
        }
        function set isInteractive(interactive) {
            if (_isInteractive == interactive) {
                return;
            }
            _isInteractive = interactive;
            updateFlagInteractivity();
            updateBackgroundInteractivity();
            updateAllItemsInteractivity();
            //return(__get__isInteractive());
        }
        function updateFlagInteractivity() {
            if (_flagClip == undefined) {
                return(undefined);
            }
            if (_isInteractive && (_flagClip.flag_id > 0)) {
                _flagClip.useHandCursor = true;
                _flagClip.onRelease = com.clubpenguin.util.Delegate.create(this, onRemoveItem, "flag_id");
            } else {
                _flagClip.useHandCursor = false;
                _flagClip.onRelease = null;
            }
        }
        function updateBackgroundInteractivity() {
            if (_backgroundClip == undefined) {
                return(undefined);
            }
            if (_isInteractive && (_backgroundClip.photo_id > 0)) {
                _backgroundClip.useHandCursor = true;
                _backgroundClip.onRelease = com.clubpenguin.util.Delegate.create(this, onRemoveItem, "photo_id");
                _paperDollClip.body.useHandCursor = false;
                _paperDollClip.body.onRelease = function () {
                };
                _paperDollClip.outline.useHandCursor = false;
                _paperDollClip.outline.onRelease = function () {
                };
            } else {
                _backgroundClip.useHandCursor = false;
                _backgroundClip.onRelease = null;
            }
        }
        function updateItemInteractivity(type) {
            if (paperDollClip == null) {
                return(undefined);
            }
            var _local_2 = _paperDollClip[(ATTACH_PREFIX + type) + ATTACH_SUFFIX];
            if (_local_2 == null) {
                return(undefined);
            }
            if (_isInteractive) {
                _local_2.onRelease = com.clubpenguin.util.Delegate.create(this, onRemoveItem, type);
            } else {
                delete _local_2.onRelease;
            }
        }
        function updatePuffleItemInteractivity(puffleId) {
            if (paperDollClip == null) {
                return(undefined);
            }
            if (!_isInteractive) {
                return(undefined);
            }
            var _local_2 = _paperDollClip[(ATTACH_PREFIX + puffleId) + ATTACH_SUFFIX];
            if (_local_2 == null) {
                return(undefined);
            }
            _local_2.onRelease = com.clubpenguin.util.Delegate.create(this, onRemovePuffleItem, "puffle");
        }
        function updateAllItemsInteractivity() {
            if (paperDollClip == null) {
                return(undefined);
            }
            for (var _local_4 in _paperDollClip) {
                if ((typeof(_paperDollClip[_local_4]) == "movieclip") && (_local_4.substr(0, ATTACH_PREFIX.length) == ATTACH_PREFIX)) {
                    var _local_2 = _paperDollClip[_local_4];
                    if (_isInteractive) {
                        var _local_3 = _local_4.substr(ATTACH_PREFIX.length, (_local_4.length - ATTACH_PREFIX.length) - ATTACH_SUFFIX.length);
                        _local_2.onRelease = com.clubpenguin.util.Delegate.create(this, onRemoveItem, _local_3);
                    } else {
                        delete _local_2.onRelease;
                    }
                }
            }
        }
        function onRemoveItem(type) {
            if (type == BACK_LAYER_NAME) {
                var _local_3 = _paperDollClip[(ATTACH_PREFIX + BACK_LAYER_NAME) + ATTACH_SUFFIX];
                type = _local_3.parentType;
            }
            if (type != null) {
                _interface.clickPlayerWidgetRemoveItem(type);
                doTestForBackgrounds(type);
            }
        }
        function onRemovePuffleItem(type) {
            _puffleIDToBeRemoved = String(_shell.getPlayerObjectById(_playerID).attachedPuffle.id);
            _shell.puffleManager.stopAllPufflesWalking();
            _shell.removeListener(_shell.UPDATE_PLAYER, _handleUpdatePlayerDelegate);
            _handleUpdatePlayerDelegate = com.clubpenguin.util.Delegate.create(this, handleUpdatePlayer);
            _shell.addListener(_shell.UPDATE_PLAYER, _handleUpdatePlayerDelegate);
        }
        function onRemovePuffleItemByID(puffleId) {
            var _local_2 = _paperDollClip[(ATTACH_PREFIX + puffleId) + ATTACH_SUFFIX];
            _local_2.removeMovieClip();
        }
        function handleUpdatePlayer(playerVO) {
            _shell.removeListener(_shell.UPDATE_PLAYER, _handleUpdatePlayerDelegate);
            if (!com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(playerVO, com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE)) {
                var _local_2 = _paperDollClip[(ATTACH_PREFIX + _puffleIDToBeRemoved) + ATTACH_SUFFIX];
                _local_2.removeMovieClip();
            }
        }
        function doTestForBackgrounds(type) {
            if (com.clubpenguin.hybrid.AS3Manager.isUnderAS3() && ((type == PHOTO_ID) || (type == FLAG_ID))) {
                var _local_2 = ((type == PHOTO_ID) ? (_backgroundClip[ART_CLIP_NAME]) : (_flagClip[ART_CLIP_NAME]));
                _local_2._alpha = 0;
                _local_2._visible = false;
            }
        }
        function get paperDollClip() {
            return(_paperDollClip);
        }
        function set paperDollClip(targetClip) {
            if (_paperDollClip != targetClip) {
                _paperDollClip = targetClip;
                _colourID = null;
            }
            //return(paperDollClip);
        }
        function set fadeAfterLoad(fadeIn) {
            _fadeAfterLoad = fadeIn;
            //return(__get__fadeAfterLoad());
        }
        function get paperdollPath() {
            if (_paperdollPath == null) {
                _paperdollPath = _shell.getPath("clothing_paper");
            }
            return(_paperdollPath);
        }
        function get flagPath() {
            if (_flagPath == null) {
                _flagPath = _shell.getPath("clothing_icons");
            }
            return(_flagPath);
        }
        function get backgroundPath() {
            if (_backgroundPath == null) {
                _backgroundPath = _shell.getPath("clothing_photos");
            }
            return(_backgroundPath);
        }
        static var ATTACH_PREFIX = "pd_";
        static var ATTACH_SUFFIX = "Clip";
        static var ART_CLIP_NAME = "art_mc";
        static var BACK_LAYER_NAME = "back";
        static var FLAG_SCALE = 66;
        static var FADE_IN_ALPHA_START = 0;
        static var FADE_IN_ALPHA_END = 100;
        static var FADE_IN_ALPHA_STEP = 20;
        static var PAPER_DOLL_IN_GAME = "paper_doll_mc";
        static var PHOTO_ID = "photo_id";
        static var FLAG_ID = "flag_id";
        static var HAND = "hand";
        static var PUFFLE_MC = "puffle_mc";
        var _paperDollClip = null;
        var _flagClip = null;
        var _backgroundClip = null;
        var _paperdollPath = null;
        var _flagPath = null;
        var _backgroundPath = null;
        var _fadeAfterLoad = false;
        var _isInteractive = false;
        var _shell = null;
        var _interface = null;
        var _colourID = null;
        var _layerDepths = null;
        var _loadInterval = null;
        var _iterations = null;
        var _mcl = null;
        var _listener = null;
        var _delayInterval = null;
        var _testContainer = null;
        var _playerID = null;
        var _puffleHatCollection = null;
        var _puffleIDToBeRemoved = null;
        var _handleUpdatePlayerDelegate = null;
    }
