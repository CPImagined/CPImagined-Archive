//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.PuffleManager
    {
        var _shell, _engine, _interface, _puffles, _pathEngine, _displayWidgetOnMoveComplete, _puffleIDForWidgetDisplay, _puffleWidgetQueued;
        function PuffleManager (_arg_3, _arg_4, _arg_2) {
            _shell = _arg_3;
            _engine = _arg_4;
            _interface = _arg_2;
            _puffles = [];
            _pathEngine = new com.clubpenguin.engine.pathfinding.PathEngine();
        }
        function setupPathEngine() {
            _pathEngine.blockedAreaClip = _engine.getRoomBlockMovieClip();
            _pathEngine.waypointsClip = _engine.getRoomWaypointsClip();
        }
        function clearPuffles() {
            _puffles = [];
        }
        function addPuffleData(_arg_2) {
            if (_arg_2.roomPuffleModel) {
                _arg_2.id = _arg_2.roomPuffleModel.id;
                _arg_2.typeID = _arg_2.roomPuffleModel.typeID;
                _arg_2.subTypeID = _arg_2.roomPuffleModel.subTypeID;
                _arg_2.hat = _arg_2.roomPuffleModel.hat;
                _arg_2.x = _arg_2.roomPuffleModel.x;
                _arg_2.y = _arg_2.roomPuffleModel.y;
                _arg_2.stats = _arg_2.roomPuffleModel.stats;
                _arg_2["color"] = _arg_2.roomPuffleModel["color"];
            }
            var _local_3 = 0;
            while (_local_3 < _puffles.length) {
                if (_puffles[_local_3].id == _arg_2.id) {
                    return(undefined);
                }
                _local_3++;
            }
            var _local_7;
            if ((!_arg_2.x) || (!_arg_2.y)) {
                _local_7 = getRandomSafeZonePoint();
            } else {
                _local_7 = new flash.geom.Point(_arg_2.x, _arg_2.y);
            }
            var _local_8 = _engine.addPlayerDepth("puffle" + _arg_2.id);
            var _local_5 = _shell.getPath("w.puffle.sprite.igloo");
            _local_5 = com.clubpenguin.shell.PuffleModel.formatAssetURL(_local_5, _arg_2["color"], _arg_2.subTypeID);
            var _local_10 = _engine.getRoomMovieClip();
            var _local_6 = _local_10.createEmptyMovieClip("puffle" + _arg_2.id, _local_8);
            _local_6._x = _local_7.x;
            _local_6._y = _local_7.y;
            _engine.updatePuffleDepth(_local_6, _local_8);
            var _local_4 = new com.clubpenguin.engine.Puffle(_local_6, _arg_2.id, _shell);
            _local_4.depth = _local_8;
            _local_4.typeID = _arg_2.typeID;
            _local_4.subTypeID = _arg_2.subTypeID;
            _local_4.isWalking = _arg_2.isWalking;
            _local_4.loadArtAsset(_local_5);
            _local_4.lastSafeZonePoint = _local_7;
            _local_4.updateStats(_arg_2.stats);
            _local_4.addEventListener(com.clubpenguin.engine.Puffle.ON_MOVE, handlePuffleMove, this);
            _local_4.addEventListener(com.clubpenguin.engine.Puffle.ON_MOVE_COMPLETE, handlePuffleMoveComplete, this);
            var _local_9 = _shell.isMyIgloo() && (_shell.getIsRoomIgloo());
            if (_local_9 || (_engine.isRoomMyBackyard())) {
                _local_4.enableOnRelease();
                _local_4.addEventListener(com.clubpenguin.engine.Puffle.ON_CLICK, handlePuffleClick, this);
            }
            _puffles.push(_local_4);
        }
        function getRandomSafeZonePoint() {
            var _local_2 = _engine.getPuffleSafeZoneClip();
            if (_local_2 == undefined) {
                var _local_3 = _engine.getRoomMovieClip();
                return(new flash.geom.Point(_local_3.start_x, _local_3.start_y));
            }
            return(_pathEngine.getRandomPointInCircleWithClip(_local_2));
        }
        function movePuffleToPointByID(_arg_5, _arg_3, _arg_6) {
            var _local_4 = _engine.getRoomBlockMovieClip();
            if (_local_4.hitTest(_arg_3.x, _arg_3.y, true)) {
                return(undefined);
            }
            var _local_2 = getPuffleByID(_arg_5);
            if (_arg_6) {
                _local_2.isSpringInStep = true;
            }
            _local_2.path = [_arg_3];
            _local_2.lastSafeZonePoint = _arg_3;
            _local_2.moveOnPath();
        }
        function makePuffleInteractWithFurnitureByID(_arg_5, _arg_4) {
            var _local_2 = getPuffleByID(_arg_5);
            var _local_3 = _pathEngine.getPathBetween(_local_2.position, new flash.geom.Point(_arg_4.x, _arg_4.y));
            if (_local_3 == undefined) {
                _shell.sendPuffleInteraction(false, _arg_5, _arg_4.interactive);
                return(undefined);
            }
            _local_3[_local_3.length - 1].y = _local_3[_local_3.length - 1].y + DEPTH_SORTING_Y_PADDING;
            _local_2.isStartingInteraction = true;
            _local_2.clickable = false;
            _local_2.interactionClip = _arg_4.mc.item;
            _local_2.interactionClip.interactionActive = true;
            _local_2.path = _local_3;
            _local_2.moveOnPath();
        }
        function handlePuffleMove(_arg_2) {
            _engine.updatePuffleDepth(_arg_2.clip, _arg_2.depth);
        }
        function handlePuffleMoveComplete(_arg_2) {
            var _local_3 = _displayWidgetOnMoveComplete && (_puffleIDForWidgetDisplay == _arg_2.id);
            if (_local_3) {
                displayPuffleWidget(_arg_2);
            }
            if (_arg_2.isStartingInteraction && (!_local_3)) {
                _arg_2.hide();
                _arg_2.interactionClip.puffleID = _arg_2.id;
                _arg_2.interactionClip.interactionCompleteCallback = com.clubpenguin.util.Delegate.create(this, handlePuffleInteractionComplete);
                _arg_2.interactionClip.interact(getPuffleColorByTypeID(_arg_2.typeID));
            } else if (_arg_2.isEndingInteraction || (_local_3)) {
                _shell.setPuffleInteractionCompleteById(_arg_2.id);
                _arg_2.isEndingInteraction = false;
                _arg_2.clickable = true;
            }
        }
        function handlePuffleInteractionComplete(_arg_4) {
            var _local_2 = getPuffleByID(_arg_4);
            _local_2.isStartingInteraction = false;
            _local_2.isEndingInteraction = true;
            _local_2.interactionClip.interactionActive = false;
            _local_2.show();
            var _local_3 = _local_2.lastTraveledPath.concat();
            _local_3.reverse();
            _local_2.path = _local_3;
            _local_2.moveOnPath();
        }
        function cancelAllPuffleInteractions() {
            var _local_3 = 0;
            var _local_4 = _puffles.length;
            while (_local_3 < _local_4) {
                var _local_2 = com.clubpenguin.engine.Puffle(_puffles[_local_3]);
                if (_local_2.isStartingInteraction || (_local_2.isEndingInteraction)) {
                    _local_2.cancelInteraction();
                }
                _local_3++;
            }
        }
        function showPuffleByID(_arg_3) {
            var _local_2 = getPuffleByID(_arg_3);
            _local_2.show();
        }
        function showAllPuffles() {
            var _local_2 = 0;
            var _local_3 = _puffles.length;
            while (_local_2 < _local_3) {
                com.clubpenguin.engine.Puffle(_puffles[_local_2]).show();
                _local_2++;
            }
        }
        function walkPuffleByID(_arg_3) {
            var _local_2 = getPuffleByID(_arg_3);
            _local_2.isWalking = true;
        }
        function stopWalkingPuffleByID(_arg_3) {
            var _local_2 = getPuffleByID(_arg_3);
            _local_2.isWalking = false;
        }
        function hidePuffleByID(_arg_3) {
            var _local_2 = getPuffleByID(_arg_3);
            _local_2.hide();
        }
        function hideAllPuffles() {
            var _local_2 = 0;
            var _local_3 = _puffles.length;
            while (_local_2 < _local_3) {
                com.clubpenguin.engine.Puffle(_puffles[_local_2]).hide();
                _local_2++;
            }
        }
        function getPuffleByID(_arg_5) {
            var _local_3 = 0;
            var _local_4 = _puffles.length;
            while (_local_3 < _local_4) {
                var _local_2 = com.clubpenguin.engine.Puffle(_puffles[_local_3]);
                if (_local_2.id == _arg_5) {
                    return(_local_2);
                }
                _local_3++;
            }
        }
        function hatAdded(_arg_5) {
            var _local_2 = getPuffleByID(_arg_5);
            var _local_4 = _shell.puffleManager.getMyPuffleById(_arg_5);
            var _local_3 = _local_4.hat;
            _local_2.putOnHat(_local_3);
        }
        function visitorHatAdded(_arg_6) {
            var _local_2 = getPuffleByID(_arg_6);
            var _local_3 = _shell.puffleManager.getRoomPuffleById(_arg_6);
            var _local_5 = _local_3.model;
            var _local_4 = _local_5.hat;
            _local_2.putOnHat(_local_4);
        }
        function hatRemoved(_arg_3) {
            var _local_2 = getPuffleByID(_arg_3);
            _local_2.takeOffHat();
        }
        function getPuffleColorByTypeID(_arg_4) {
            var _local_2 = _shell.getPuffleCrumbs();
            var _local_3 = _local_2[_arg_4].colour;
            if (!isNaN(_local_3)) {
                return(_local_3);
            }
            return(_local_2[0].colour);
        }
        function updatePuffleFrameByID(_arg_3, _arg_4) {
            var _local_2 = getPuffleByID(_arg_3);
            com.clubpenguin.engine.tweener.Tweener.removeTweens(_local_2.clip);
            _local_2.frame = _arg_4;
        }
        function handlePuffleClick(_arg_3) {
            if (!_global.getCurrentShell().playerModel.isPlayerStealthModerator()) {
                if (!_puffleWidgetQueued) {
                    _puffleWidgetQueued = true;
                    if (_arg_3.isTweenWalking) {
                        _displayWidgetOnMoveComplete = true;
                        _puffleIDForWidgetDisplay = _arg_3.id;
                    } else {
                        displayPuffleWidget(_arg_3);
                    }
                }
            }
        }
        function displayPuffleWidget(_arg_2) {
            _displayWidgetOnMoveComplete = false;
            _puffleIDForWidgetDisplay = null;
            var _local_5 = false;
            var _local_4 = new flash.geom.Point(_arg_2.clip._x, _arg_2.clip._y);
            var _local_6 = _arg_2.typeID;
            var _local_3 = _shell.puffleManager.getRoomPuffleById(_arg_2.id);
            _local_3.stopBrain();
            _engine.puffleUIWidgetController.displayPuffleWidget(_arg_2.id, _local_5, _local_4, _local_6, "radialMenuWidget", null);
        }
        function removePuffle(_arg_3) {
            var _local_2 = getPuffleByID(Number(_arg_3.id));
            if (_local_2) {
                _local_2.clip.removeMovieClip();
                _local_2.removeEventListener(com.clubpenguin.engine.Puffle.ON_MOVE, handlePuffleMove, this);
                _local_2.removeEventListener(com.clubpenguin.engine.Puffle.ON_MOVE_COMPLETE, handlePuffleMoveComplete, this);
                if (_shell.isMyIgloo()) {
                    _local_2.removeEventListener(com.clubpenguin.engine.Puffle.ON_CLICK, handlePuffleClick, this);
                }
            }
        }
        function swapPuffle(_arg_5) {
            var _local_2 = getPuffleByID(Number(_arg_5.id));
            if (_local_2) {
                var _local_4 = new com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader(_shell.getMyPlayerId(), _local_2.id, _shell, _engine, false);
                var _local_3 = _shell.getPath(POOF_ANIMATION_PATH);
                _local_4.playPuffleAnimation(_local_3, true);
            }
        }
        function completePuffleRadialMenu() {
            _puffleWidgetQueued = false;
        }
        static var DEPTH_SORTING_Y_PADDING = 2;
        static var POOF_ANIMATION_PATH = "w.puffle.sprite.poof";
    }
