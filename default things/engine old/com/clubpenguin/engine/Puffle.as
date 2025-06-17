class com.clubpenguin.engine.Puffle extends com.clubpenguin.util.EventDispatcher
{
    var _clip, _id, _shell, _clickable, _onReleaseEnabled, _isWalking, _isSpringInStep, _isStartingInteraction, _isEndingInteraction, _puffleHatCollection, _puffleModel, _showEmoteStatus, _isTweenWalking, _loader, __get__clip, _artClip, __get__clickable, updateListeners, __get__isWalking, __get__interactionClip, __get__position, __set__frame, _path, __get__x, __get__y, __set__clickable, __set__isStartingInteraction, __set__isEndingInteraction, __get__lastSafeZonePoint, _lastTraveledPath, _lastSafeZonePoint, __get__path, __get__id, _type, __get__typeID, _subType, __get__subTypeID, __get__isSpringInStep, __get__isStartingInteraction, __get__isEndingInteraction, _interactionClip, _depth, __get__depth, __get__frame, __set__depth, __set__id, __set__interactionClip, __set__isSpringInStep, __get__isTweenWalking, __set__isWalking, __set__lastSafeZonePoint, __get__lastTraveledPath, __set__path, __set__subTypeID, __set__typeID;
    function Puffle(clip, id, shell)
    {
        super();
        _clip = clip;
        _id = id;
        _shell = shell;
        _clickable = false;
        _onReleaseEnabled = false;
        _isWalking = false;
        _isSpringInStep = false;
        _isStartingInteraction = false;
        _isEndingInteraction = false;
        _puffleHatCollection = _shell.getPuffleHatCollection();
        _puffleModel = _shell.puffleManager.getMyPuffleById(_id);
        _showEmoteStatus = false;
        _isTweenWalking = false;
        _loader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
        _loader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_START, com.clubpenguin.util.Delegate.create(this, onLoadStart));
        _loader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadInit));
    } // End of the function
    function enableOnRelease()
    {
        this.__get__clip().onPress = com.clubpenguin.util.Delegate.create(this, onPress);
        _clickable = true;
        _onReleaseEnabled = true;
    } // End of the function
    function loadArtAsset(url)
    {
        if (_artClip == undefined)
        {
            _artClip = this.__get__clip().createEmptyMovieClip("artClip", this.__get__clip().getNextHighestDepth());
        } // end if
        var _loc2 = com.clubpenguin.util.URLUtils.getCacheResetURL(url);
        _loader.loadClip(_loc2, _artClip, "Puffle.as loadArtAsset()");
    } // End of the function
    function onPress()
    {
        if (!this.__get__clickable())
        {
            return;
        } // end if
        this.updateListeners(com.clubpenguin.engine.Puffle.ON_CLICK, this);
    } // End of the function
    function onLoadStart(target)
    {
        target._visible = false;
    } // End of the function
    function onLoadInit(target)
    {
        target._visible = true;
        if (this.__get__isWalking())
        {
            this.hide();
        } // end if
        _loader.removeEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_START, com.clubpenguin.util.Delegate.create(this, onLoadStart));
        _loader.removeEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadInit));
        this.setPuffleStats();
        this.checkForPuffleHat();
    } // End of the function
    function updateStats(_stats)
    {
        _puffleModel.stats = _stats;
    } // End of the function
    function setPuffleStats()
    {
        if (!_global.getCurrentEngine().isRoomMyBackyard())
        {
            var _loc5 = _shell.isMyIgloo();
            var _loc3 = _global.getCurrentEngine().puffleCareEmoteManager;
            var _loc4 = [com.clubpenguin.shell.PuffleStatsVO.FOOD, com.clubpenguin.shell.PuffleStatsVO.REST, com.clubpenguin.shell.PuffleStatsVO.PLAY, com.clubpenguin.shell.PuffleStatsVO.CLEAN];
            if (_loc5)
            {
                _loc3.showEmote(_puffleModel, _artClip, _loc4, com.clubpenguin.engine.Puffle.LOW_STAT_EMOTE_THRESHOLD);
            }
            else
            {
                var _loc6 = _shell.puffleManager.getRoomPuffleById(_id);
                var _loc7 = _loc6.model;
                _loc3.showEmote(_loc7, _artClip, _loc4, com.clubpenguin.engine.Puffle.LOW_STAT_EMOTE_THRESHOLD);
            } // end if
        } // end else if
    } // End of the function
    function checkForPuffleHat()
    {
        var _loc2 = _shell.isMyIgloo();
        if (_loc2)
        {
            this.checkForPlayerHat();
        }
        else
        {
            this.checkForFriendHat();
        } // end else if
    } // End of the function
    function checkForPlayerHat()
    {
        var _loc2 = _shell.puffleManager.getMyPuffleById(_id);
        if (_loc2.hasHat())
        {
            var _loc3 = _loc2.hat;
            this.loadPuffleHat(_loc3);
        } // end if
    } // End of the function
    function checkForFriendHat()
    {
        var _loc3 = _shell.puffleManager.getRoomPuffleById(_id);
        var _loc4 = _loc3.model;
        var _loc2 = _loc4.hat;
        var _loc5 = _loc2.id != com.clubpenguin.shell.puffle.PuffleHatVO.getEmptyHatVO().id ? (true) : (false);
        if (_loc5)
        {
            this.loadPuffleHat(_loc2);
        } // end if
    } // End of the function
    function loadPuffleHat(puffleHatVO)
    {
        var _loc2 = new com.clubpenguin.engine.PuffleHatManager(_shell, _artClip, puffleHatVO, com.clubpenguin.engine.PuffleHatLocEnum.IGLOO_HAT_LOC);
        _artClip.puffleClass = this;
    } // End of the function
    function animationCompleted()
    {
        var _loc2 = _shell.puffleManager.getRoomPuffleById(_id);
        _loc2.forcePuffleMove();
    } // End of the function
    function hide()
    {
        this.__get__clip()._visible = false;
    } // End of the function
    function show()
    {
        if (this.__get__isWalking() || this.__get__interactionClip().interactionActive)
        {
            return;
        } // end if
        this.__get__clip()._visible = true;
    } // End of the function
    function moveToPoint(to)
    {
        var _loc5 = flash.geom.Point.distance(this.__get__position(), to);
        var _loc6 = com.clubpenguin.math.MathHelper.getAngleBetweenPoints(this.__get__position(), to);
        var _loc2 = com.clubpenguin.math.MathHelper.get8DirectionByAngle(_loc6);
        if (_isSpringInStep)
        {
            this.__set__frame(_loc2 + 16);
        }
        else
        {
            this.__set__frame(_loc2 + 8);
        } // end else if
        var _loc3 = Math.round(_loc5 / 4);
        if (isNaN(_loc3))
        {
            return;
        } // end if
        _isTweenWalking = true;
        com.clubpenguin.engine.tweener.Tweener.addTween(this.__get__clip(), {transition: "linear", time: _loc3, _x: to.x, _y: to.y, useFrames: true, onUpdate: handleMoveUpdate, onUpdateScope: this, onComplete: handleMoveComplete, onCompleteScope: this, onCompleteParams: [_loc2]});
    } // End of the function
    function moveOnPath()
    {
        if (_path[0].x == this.__get__x() && _path[0].y == this.__get__y())
        {
            _path.shift();
        } // end if
        this.moveToPoint(_path[0]);
        _path.shift();
    } // End of the function
    function handleMoveComplete(directionFrame)
    {
        this.__set__frame(directionFrame);
        if (_path.length > 0)
        {
            this.moveOnPath();
        }
        else
        {
            _isTweenWalking = false;
            this.updateListeners(com.clubpenguin.engine.Puffle.ON_MOVE_COMPLETE, this);
        } // end else if
    } // End of the function
    function handleMoveUpdate()
    {
        this.updateListeners(com.clubpenguin.engine.Puffle.ON_MOVE, this);
    } // End of the function
    function cancelInteraction()
    {
        com.clubpenguin.engine.tweener.Tweener.removeTweens(this.__get__clip());
        this.__set__clickable(true);
        this.__get__interactionClip().stopInteract();
        this.__get__interactionClip().interactionActive = false;
        this.__set__isStartingInteraction(false);
        this.__set__isEndingInteraction(false);
        this.__set__frame(1);
        this.__get__clip()._x = this.__get__lastSafeZonePoint().x;
        this.__get__clip()._y = this.__get__lastSafeZonePoint().y;
    } // End of the function
    function putOnHat(puffleHatVO)
    {
        this.loadPuffleHat(puffleHatVO);
    } // End of the function
    function takeOffHat()
    {
        var _loc2 = _artClip[com.clubpenguin.engine.PuffleHatManager.HAT_FOREGROUND];
        var _loc3 = _artClip[com.clubpenguin.engine.PuffleHatManager.HAT_BACKGROUND];
        _loc2.unloadMovie();
        _loc3.unloadMovie();
    } // End of the function
    function get clip()
    {
        return (_clip);
    } // End of the function
    function get position()
    {
        //return (new flash.geom.Point(this.x(), this.__get__y()));
    } // End of the function
    function get lastTraveledPath()
    {
        return (_lastTraveledPath);
    } // End of the function
    function get lastSafeZonePoint()
    {
        return (_lastSafeZonePoint);
    } // End of the function
    function set lastSafeZonePoint(value)
    {
        _lastSafeZonePoint = value;
        //return (this.lastSafeZonePoint());
        null;
    } // End of the function
    function set path(value)
    {
        _path = value.concat();
        _lastTraveledPath = value.concat();
        //return (this.path());
        null;
    } // End of the function
    function get id()
    {
        return (_id);
    } // End of the function
    function set id(value)
    {
        _id = value;
        //return (this.id());
        null;
    } // End of the function
    function get typeID()
    {
        return (_type);
    } // End of the function
    function set typeID(value)
    {
        _type = value;
        //return (this.typeID());
        null;
    } // End of the function
    function get subTypeID()
    {
        return (_subType);
    } // End of the function
    function set subTypeID(value)
    {
        _subType = value;
        //return (this.subTypeID());
        null;
    } // End of the function
    function get isWalking()
    {
        return (_isWalking);
    } // End of the function
    function set isWalking(value)
    {
        _isWalking = value;
        if (_isWalking)
        {
            this.hide();
        }
        else
        {
            _artClip.gotoAndStop(1);
            this.show();
        } // end else if
        //return (this.isWalking());
        null;
    } // End of the function
    function get clickable()
    {
        return (_clickable);
    } // End of the function
    function set clickable(value)
    {
        if (!_onReleaseEnabled)
        {
            return;
        } // end if
        _clickable = value;
        this.__get__clip().useHandCursor = value;
        //return (this.clickable());
        null;
    } // End of the function
    function get isSpringInStep()
    {
        return (_isSpringInStep);
    } // End of the function
    function set isSpringInStep(value)
    {
        _isSpringInStep = value;
        //return (this.isSpringInStep());
        null;
    } // End of the function
    function get isStartingInteraction()
    {
        return (_isStartingInteraction);
    } // End of the function
    function set isStartingInteraction(value)
    {
        _isStartingInteraction = value;
        //return (this.isStartingInteraction());
        null;
    } // End of the function
    function get isEndingInteraction()
    {
        return (_isEndingInteraction);
    } // End of the function
    function set isEndingInteraction(value)
    {
        _isEndingInteraction = value;
        //return (this.isEndingInteraction());
        null;
    } // End of the function
    function get interactionClip()
    {
        return (_interactionClip);
    } // End of the function
    function set interactionClip(clip)
    {
        _interactionClip = clip;
        //return (this.interactionClip());
        null;
    } // End of the function
    function get x()
    {
        //return (this.clip()._x);
    } // End of the function
    function get y()
    {
        //return (this.clip()._y);
    } // End of the function
    function get depth()
    {
        return (_depth);
    } // End of the function
    function set depth(value)
    {
        _depth = value;
        //return (this.depth());
        null;
    } // End of the function
    function set frame(frame)
    {
        _artClip.gotoAndStop(1);
        _artClip.gotoAndStop(frame);
        //return (this.frame());
        null;
    } // End of the function
    function get isTweenWalking()
    {
        return (_isTweenWalking);
    } // End of the function
    static var LOW_STAT_EMOTE_THRESHOLD = 20;
    static var PATH_KEY_PREFIX = "puffle";
    static var ON_CLICK = "onClick";
    static var ON_MOVE = "onMove";
    static var ON_MOVE_COMPLETE = "onMoveComplete";
} // End of Class
