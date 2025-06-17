//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.Puffle extends com.clubpenguin.util.EventDispatcher
    {
        var _clip, _id, _shell, _clickable, _onReleaseEnabled, _isWalking, _isSpringInStep, _isStartingInteraction, _isEndingInteraction, _puffleHatCollection, _puffleModel, _showEmoteStatus, _isTweenWalking, _loader, _artClip, updateListeners, _path, _lastTraveledPath, _lastSafeZonePoint, __get__path, _type, _subType, _interactionClip, _depth, __get__frame;
        function Puffle (clip, id, shell) {
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
        }
        function enableOnRelease() {
            clip.onPress = com.clubpenguin.util.Delegate.create(this, onPress);
            _clickable = true;
            _onReleaseEnabled = true;
        }
        function loadArtAsset(url) {
            if (_artClip == undefined) {
                _artClip = clip.createEmptyMovieClip("artClip", clip.getNextHighestDepth());
            }
            var _local_2 = com.clubpenguin.util.URLUtils.getCacheResetURL(url);
            _loader.loadClip(_local_2, _artClip, "Puffle.as loadArtAsset()");
        }
        function onPress() {
            if (!clickable) {
                return(undefined);
            }
            updateListeners(ON_CLICK, this);
        }
        function onLoadStart(target) {
            target._visible = false;
        }
        function onLoadInit(target) {
            target._visible = true;
            if (isWalking) {
                this.hide();
            }
            _loader.removeEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_START, com.clubpenguin.util.Delegate.create(this, onLoadStart));
            _loader.removeEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadInit));
            setPuffleStats();
            checkForPuffleHat();
        }
        function updateStats(_stats) {
            _puffleModel.stats = _stats;
        }
        function setPuffleStats() {
            if (!_global.getCurrentEngine().isRoomMyBackyard()) {
                var _local_5 = _shell.isMyIgloo();
                var _local_3 = _global.getCurrentEngine().puffleCareEmoteManager;
                var _local_4 = [com.clubpenguin.shell.PuffleStatsVO.FOOD, com.clubpenguin.shell.PuffleStatsVO.REST, com.clubpenguin.shell.PuffleStatsVO.PLAY, com.clubpenguin.shell.PuffleStatsVO.CLEAN];
                if (_local_5) {
                    _local_3.showEmote(_puffleModel, _artClip, _local_4, LOW_STAT_EMOTE_THRESHOLD);
                } else {
                    var _local_6 = _shell.puffleManager.getRoomPuffleById(_id);
                    var _local_7 = _local_6.model;
                    _local_3.showEmote(_local_7, _artClip, _local_4, LOW_STAT_EMOTE_THRESHOLD);
                }
            }
        }
        function checkForPuffleHat() {
            var _local_2 = _shell.isMyIgloo();
            if (_local_2) {
                checkForPlayerHat();
            } else {
                checkForFriendHat();
            }
        }
        function checkForPlayerHat() {
            var _local_2 = _shell.puffleManager.getMyPuffleById(_id);
            if (_local_2.hasHat()) {
                var _local_3 = _local_2.hat;
                loadPuffleHat(_local_3);
            }
        }
        function checkForFriendHat() {
            var _local_3 = _shell.puffleManager.getRoomPuffleById(_id);
            var _local_4 = _local_3.model;
            var _local_2 = _local_4.hat;
            var _local_5 = ((_local_2.id != com.clubpenguin.shell.puffle.PuffleHatVO.getEmptyHatVO().id) ? true : false);
            if (_local_5) {
                loadPuffleHat(_local_2);
            }
        }
        function loadPuffleHat(puffleHatVO) {
            var _local_2 = new com.clubpenguin.engine.PuffleHatManager(_shell, _artClip, puffleHatVO, com.clubpenguin.engine.PuffleHatLocEnum.IGLOO_HAT_LOC);
            _artClip.puffleClass = this;
        }
        function animationCompleted() {
            var _local_2 = _shell.puffleManager.getRoomPuffleById(_id);
            _local_2.forcePuffleMove();
        }
        function hide() {
            clip._visible = false;
        }
        function show() {
            if (isWalking || (interactionClip.interactionActive)) {
                return(undefined);
            }
            clip._visible = true;
        }
        function moveToPoint(to) {
            var _local_5 = flash.geom.Point.distance(position, to);
            var _local_6 = com.clubpenguin["math"].MathHelper.getAngleBetweenPoints(position, to);
            var _local_2 = com.clubpenguin["math"].MathHelper.get8DirectionByAngle(_local_6);
            if (_isSpringInStep) {
                frame = (_local_2 + 16);
            } else {
                frame = (_local_2 + 8);
            }
            var _local_3 = Math.round(_local_5 / 4);
            if (isNaN(_local_3)) {
                return(undefined);
            }
            _isTweenWalking = true;
            com.clubpenguin.engine.tweener.Tweener.addTween(clip, {transition:"linear", time:_local_3, _x:to.x, _y:to.y, useFrames:true, onUpdate:handleMoveUpdate, onUpdateScope:this, onComplete:handleMoveComplete, onCompleteScope:this, onCompleteParams:[_local_2]});
        }
        function moveOnPath() {
            if ((_path[0].x == x) && (_path[0].y == y)) {
                _path.shift();
            }
            moveToPoint(_path[0]);
            _path.shift();
        }
        function handleMoveComplete(directionFrame) {
            frame = (directionFrame);
            if (_path.length > 0) {
                moveOnPath();
            } else {
                _isTweenWalking = false;
                updateListeners(ON_MOVE_COMPLETE, this);
            }
        }
        function handleMoveUpdate() {
            updateListeners(ON_MOVE, this);
        }
        function cancelInteraction() {
            com.clubpenguin.engine.tweener.Tweener.removeTweens(clip);
            clickable = (true);
            interactionClip.stopInteract();
            interactionClip.interactionActive = false;
            isStartingInteraction = (false);
            isEndingInteraction = (false);
            frame = (1);
            clip._x = lastSafeZonePoint.x;
            clip._y = lastSafeZonePoint.y;
        }
        function putOnHat(puffleHatVO) {
            loadPuffleHat(puffleHatVO);
        }
        function takeOffHat() {
            var _local_2 = _artClip[com.clubpenguin.engine.PuffleHatManager.HAT_FOREGROUND];
            var _local_3 = _artClip[com.clubpenguin.engine.PuffleHatManager.HAT_BACKGROUND];
            _local_2.unloadMovie();
            _local_3.unloadMovie();
        }
        function get clip() {
            return(_clip);
        }
        function get position() {
            return(new flash.geom.Point(x, y));
        }
        function get lastTraveledPath() {
            return(_lastTraveledPath);
        }
        function get lastSafeZonePoint() {
            return(_lastSafeZonePoint);
        }
        function set lastSafeZonePoint(value) {
            _lastSafeZonePoint = value;
            //return(lastSafeZonePoint);
        }
        function set path(value) {
            _path = value.concat();
            _lastTraveledPath = value.concat();
            //return(__get__path());
        }
        function get id() {
            return(_id);
        }
        function set id(value) {
            _id = value;
            //return(id);
        }
        function get typeID() {
            return(_type);
        }
        function set typeID(value) {
            _type = value;
            //return(typeID);
        }
        function get subTypeID() {
            return(_subType);
        }
        function set subTypeID(value) {
            _subType = value;
            //return(subTypeID);
        }
        function get isWalking() {
            return(_isWalking);
        }
        function set isWalking(value) {
            _isWalking = value;
            if (_isWalking) {
                this.hide();
            } else {
                _artClip.gotoAndStop(1);
                this.show();
            }
            //return(isWalking);
        }
        function get clickable() {
            return(_clickable);
        }
        function set clickable(value) {
            if (!_onReleaseEnabled) {
                return;
            }
            _clickable = value;
            clip.useHandCursor = value;
            //return(clickable);
        }
        function get isSpringInStep() {
            return(_isSpringInStep);
        }
        function set isSpringInStep(value) {
            _isSpringInStep = value;
            //return(isSpringInStep);
        }
        function get isStartingInteraction() {
            return(_isStartingInteraction);
        }
        function set isStartingInteraction(value) {
            _isStartingInteraction = value;
            //return(isStartingInteraction);
        }
        function get isEndingInteraction() {
            return(_isEndingInteraction);
        }
        function set isEndingInteraction(value) {
            _isEndingInteraction = value;
            //return(isEndingInteraction);
        }
        function get interactionClip() {
            return(_interactionClip);
        }
        function set interactionClip(clip) {
            _interactionClip = clip;
            //return(interactionClip);
        }
        function get x() {
            return(clip._x);
        }
        function get y() {
            return(clip._y);
        }
        function get depth() {
            return(_depth);
        }
        function set depth(value) {
            _depth = value;
            //return(depth);
        }
        function set frame(frame) {
            _artClip.gotoAndStop(1);
            _artClip.gotoAndStop(frame);
            //return(__get__frame());
        }
        function get isTweenWalking() {
            return(_isTweenWalking);
        }
        static var LOW_STAT_EMOTE_THRESHOLD = 20;
        static var PATH_KEY_PREFIX = "puffle";
        static var ON_CLICK = "onClick";
        static var ON_MOVE = "onMove";
        static var ON_MOVE_COMPLETE = "onMoveComplete";
    }
