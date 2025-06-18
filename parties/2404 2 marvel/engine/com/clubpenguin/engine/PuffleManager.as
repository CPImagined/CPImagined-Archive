//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.PuffleManager
    {
        var _shell, _engine, _interface, _puffles, _pathEngine, _displayWidgetOnMoveComplete, _puffleIDForWidgetDisplay, _puffleWidgetQueued;
        function PuffleManager (shell, engine, _interface) {
            _shell = shell;
            _engine = engine;
            this._interface = _interface;
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
        function addPuffleData(object) {
            if (object.roomPuffleModel) {
                object.id = object.roomPuffleModel.id;
                object.typeID = object.roomPuffleModel.typeID;
                object.subTypeID = object.roomPuffleModel.subTypeID;
                object.hat = object.roomPuffleModel.hat;
                object.x = object.roomPuffleModel.x;
                object.y = object.roomPuffleModel.y;
                object.stats = object.roomPuffleModel.stats;
                object["color"] = object.roomPuffleModel["color"];
            }
            var _local_3 = 0;
            while (_local_3 < _puffles.length) {
                if (_puffles[_local_3].id == object.id) {
                    return(undefined);
                }
                _local_3++;
            }
            var _local_7;
            if ((!object.x) || (!object.y)) {
                _local_7 = getRandomSafeZonePoint();
            } else {
                _local_7 = new flash.geom.Point(object.x, object.y);
            }
            var _local_8 = _engine.addPlayerDepth("puffle" + object.id);
            var _local_5 = _shell.getPath("w.puffle.sprite.igloo");
            _local_5 = com.clubpenguin.shell.PuffleModel.formatAssetURL(_local_5, object["color"], object.subTypeID);
            var _local_10 = _engine.getRoomMovieClip();
            var _local_6 = _local_10.createEmptyMovieClip("puffle" + object.id, _local_8);
            _local_6._x = _local_7.x;
            _local_6._y = _local_7.y;
            _engine.updatePuffleDepth(_local_6, _local_8);
            var _local_4 = new com.clubpenguin.engine.Puffle(_local_6, object.id, _shell);
            _local_4.depth = _local_8;
            _local_4.typeID = object.typeID;
            _local_4.subTypeID = object.subTypeID;
            _local_4.isWalking = object.isWalking;
            _local_4.loadArtAsset(_local_5);
            _local_4.lastSafeZonePoint = _local_7;
            _local_4.updateStats(object.stats);
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
        function movePuffleToPointByID(id, point, superHappy) {
            var _local_4 = _engine.getRoomBlockMovieClip();
            if (_local_4.hitTest(point.x, point.y, true)) {
                return(undefined);
            }
            var _local_2 = getPuffleByID(id);
            if (superHappy) {
                _local_2.isSpringInStep = true;
            }
            _local_2.path = [point];
            _local_2.lastSafeZonePoint = point;
            _local_2.moveOnPath();
        }
        function makePuffleInteractWithFurnitureByID(id, furnitureItem) {
            var _local_2 = getPuffleByID(id);
            var _local_3 = _pathEngine.getPathBetween(_local_2.position, new flash.geom.Point(furnitureItem.x, furnitureItem.y));
            if (_local_3 == undefined) {
                _shell.sendPuffleInteraction(false, id, furnitureItem.interactive);
                return(undefined);
            }
            _local_3[_local_3.length - 1].y = _local_3[_local_3.length - 1].y + DEPTH_SORTING_Y_PADDING;
            _local_2.isStartingInteraction = true;
            _local_2.clickable = false;
            _local_2.interactionClip = furnitureItem.mc.item;
            _local_2.interactionClip.interactionActive = true;
            _local_2.path = _local_3;
            _local_2.moveOnPath();
        }
        function handlePuffleMove(puffle) {
            _engine.updatePuffleDepth(puffle.clip, puffle.depth);
        }
        function handlePuffleMoveComplete(puffle) {
            var _local_3 = _displayWidgetOnMoveComplete && (_puffleIDForWidgetDisplay == puffle.id);
            if (_local_3) {
                displayPuffleWidget(puffle);
            }
            if (puffle.isStartingInteraction && (!_local_3)) {
                puffle.hide();
                puffle.interactionClip.puffleID = puffle.id;
                puffle.interactionClip.interactionCompleteCallback = com.clubpenguin.util.Delegate.create(this, handlePuffleInteractionComplete);
                puffle.interactionClip.interact(getPuffleColorByTypeID(puffle.typeID));
            } else if (puffle.isEndingInteraction || (_local_3)) {
                _shell.setPuffleInteractionCompleteById(puffle.id);
                puffle.isEndingInteraction = false;
                puffle.clickable = true;
            }
        }
        function handlePuffleInteractionComplete(id) {
            var _local_2 = getPuffleByID(id);
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
        function showPuffleByID(id) {
            var _local_2 = getPuffleByID(id);
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
        function walkPuffleByID(id) {
            var _local_2 = getPuffleByID(id);
            _local_2.isWalking = true;
        }
        function stopWalkingPuffleByID(id) {
            var _local_2 = getPuffleByID(id);
            _local_2.isWalking = false;
        }
        function hidePuffleByID(id) {
            var _local_2 = getPuffleByID(id);
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
        function getPuffleByID(id) {
            var _local_3 = 0;
            var _local_4 = _puffles.length;
            while (_local_3 < _local_4) {
                var _local_2 = com.clubpenguin.engine.Puffle(_puffles[_local_3]);
                if (_local_2.id == id) {
                    return(_local_2);
                }
                _local_3++;
            }
        }
        function hatAdded(puffleID) {
            var _local_2 = getPuffleByID(puffleID);
            var _local_4 = _shell.puffleManager.getMyPuffleById(puffleID);
            var _local_3 = _local_4.hat;
            _local_2.putOnHat(_local_3);
        }
        function visitorHatAdded(puffleID) {
            var _local_2 = getPuffleByID(puffleID);
            var _local_3 = _shell.puffleManager.getRoomPuffleById(puffleID);
            var _local_5 = _local_3.model;
            var _local_4 = _local_5.hat;
            _local_2.putOnHat(_local_4);
        }
        function hatRemoved(puffleID) {
            var _local_2 = getPuffleByID(puffleID);
            _local_2.takeOffHat();
        }
        function getPuffleColorByTypeID(typeID) {
            var _local_2 = _shell.getPuffleCrumbs();
            var _local_3 = _local_2[typeID].colour;
            if (!isNaN(_local_3)) {
                return(_local_3);
            }
            return(_local_2[0].colour);
        }
        function updatePuffleFrameByID(id, frame) {
            var _local_2 = getPuffleByID(id);
            com.clubpenguin.engine.tweener.Tweener.removeTweens(_local_2.clip);
            _local_2.frame = frame;
        }
        function handlePuffleClick(puffle) {
            if (!_global.getCurrentShell().playerModel.isPlayerStealthModerator()) {
                if (!_puffleWidgetQueued) {
                    _puffleWidgetQueued = true;
                    if (puffle.isTweenWalking) {
                        _displayWidgetOnMoveComplete = true;
                        _puffleIDForWidgetDisplay = puffle.id;
                    } else {
                        displayPuffleWidget(puffle);
                    }
                }
            }
        }
        function displayPuffleWidget(puffle) {
            _displayWidgetOnMoveComplete = false;
            _puffleIDForWidgetDisplay = null;
            var _local_5 = false;
            var _local_4 = new flash.geom.Point(puffle.clip._x, puffle.clip._y);
            var _local_6 = puffle.typeID;
            var _local_3 = _shell.puffleManager.getRoomPuffleById(puffle.id);
            _local_3.stopBrain();
            _engine.puffleUIWidgetController.displayPuffleWidget(puffle.id, _local_5, _local_4, _local_6, "radialMenuWidget", null);
        }
        function removePuffle(dataObject) {
            var _local_2 = getPuffleByID(Number(dataObject.id));
            if (_local_2) {
                _local_2.clip.removeMovieClip();
                _local_2.removeEventListener(com.clubpenguin.engine.Puffle.ON_MOVE, handlePuffleMove, this);
                _local_2.removeEventListener(com.clubpenguin.engine.Puffle.ON_MOVE_COMPLETE, handlePuffleMoveComplete, this);
                if (_shell.isMyIgloo()) {
                    _local_2.removeEventListener(com.clubpenguin.engine.Puffle.ON_CLICK, handlePuffleClick, this);
                }
            }
        }
        function swapPuffle(dataObject) {
            var _local_2 = getPuffleByID(Number(dataObject.id));
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
