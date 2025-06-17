class com.clubpenguin.engine.PuffleManager
{
    var _shell, _engine, _interface, _puffles, _pathEngine, _displayWidgetOnMoveComplete, _puffleIDForWidgetDisplay, _puffleWidgetQueued;
    function PuffleManager(shell, engine, _interface)
    {
        _shell = shell;
        _engine = engine;
        this._interface = _interface;
        _puffles = [];
        _pathEngine = new com.clubpenguin.engine.pathfinding.PathEngine();
    } // End of the function
    function setupPathEngine()
    {
        _pathEngine.__set__blockedAreaClip(_engine.getRoomBlockMovieClip());
        _pathEngine.__set__waypointsClip(_engine.getRoomWaypointsClip());
    } // End of the function
    function clearPuffles()
    {
        _puffles = [];
    } // End of the function
    function addPuffleData(object)
    {
        if (object.roomPuffleModel)
        {
            object.id = object.roomPuffleModel.id;
            object.typeID = object.roomPuffleModel.typeID;
            object.subTypeID = object.roomPuffleModel.subTypeID;
            object.hat = object.roomPuffleModel.hat;
            object.x = object.roomPuffleModel.x;
            object.y = object.roomPuffleModel.y;
            object.stats = object.roomPuffleModel.stats;
            object.color = object.roomPuffleModel.color;
        } // end if
        for (var _loc3 = 0; _loc3 < _puffles.length; ++_loc3)
        {
            if (_puffles[_loc3].id == object.id)
            {
                return;
            } // end if
        } // end of for
        var _loc7;
        if (!object.x || !object.y)
        {
            _loc7 = this.getRandomSafeZonePoint();
        }
        else
        {
            _loc7 = new flash.geom.Point(object.x, object.y);
        } // end else if
        var _loc8 = _engine.addPlayerDepth("puffle" + object.id);
        var _loc5 = _shell.getPath("w.puffle.sprite.igloo");
        _loc5 = com.clubpenguin.shell.PuffleModel.formatAssetURL(_loc5, object.color, object.subTypeID);
        var _loc10 = _engine.getRoomMovieClip();
        var _loc6 = _loc10.createEmptyMovieClip("puffle" + object.id, _loc8);
        _loc6._x = _loc7.x;
        _loc6._y = _loc7.y;
        _engine.updatePuffleDepth(_loc6, _loc8);
        var _loc4 = new com.clubpenguin.engine.Puffle(_loc6, object.id, _shell);
        _loc4.__set__depth(_loc8);
        _loc4.__set__typeID(object.typeID);
        _loc4.__set__subTypeID(object.subTypeID);
        _loc4.__set__isWalking(object.isWalking);
        _loc4.loadArtAsset(_loc5);
        _loc4.__set__lastSafeZonePoint(_loc7);
        _loc4.updateStats(object.stats);
        _loc4.addEventListener(com.clubpenguin.engine.Puffle.ON_MOVE, handlePuffleMove, this);
        _loc4.addEventListener(com.clubpenguin.engine.Puffle.ON_MOVE_COMPLETE, handlePuffleMoveComplete, this);
        var _loc9 = _shell.isMyIgloo() && _shell.getIsRoomIgloo();
        if (_loc9 || _engine.isRoomMyBackyard())
        {
            _loc4.enableOnRelease();
            _loc4.addEventListener(com.clubpenguin.engine.Puffle.ON_CLICK, handlePuffleClick, this);
        } // end if
        _puffles.push(_loc4);
    } // End of the function
    function getRandomSafeZonePoint()
    {
        var _loc2 = _engine.getPuffleSafeZoneClip();
        if (_loc2 == undefined)
        {
            var _loc3 = _engine.getRoomMovieClip();
            return (new flash.geom.Point(_loc3.start_x, _loc3.start_y));
        } // end if
        return (_pathEngine.getRandomPointInCircleWithClip(_loc2));
    } // End of the function
    function movePuffleToPointByID(id, point, superHappy)
    {
        var _loc4 = _engine.getRoomBlockMovieClip();
        if (_loc4.hitTest(point.x, point.y, true))
        {
            return;
        } // end if
        var _loc2 = this.getPuffleByID(id);
        if (superHappy)
        {
            _loc2.__set__isSpringInStep(true);
        } // end if
        _loc2.__set__path([point]);
        _loc2.__set__lastSafeZonePoint(point);
        _loc2.moveOnPath();
    } // End of the function
    function makePuffleInteractWithFurnitureByID(id, furnitureItem)
    {
        var _loc2 = this.getPuffleByID(id);
        var _loc3 = _pathEngine.getPathBetween(_loc2.__get__position(), new flash.geom.Point(furnitureItem.x, furnitureItem.y));
        if (_loc3 == undefined)
        {
            _shell.sendPuffleInteraction(false, id, furnitureItem.interactive);
            return;
        } // end if
        _loc3[_loc3.length - 1].y = _loc3[_loc3.length - 1].y + com.clubpenguin.engine.PuffleManager.DEPTH_SORTING_Y_PADDING;
        _loc2.__set__isStartingInteraction(true);
        _loc2.__set__clickable(false);
        _loc2.__set__interactionClip(furnitureItem.mc.item);
        _loc2.__get__interactionClip().interactionActive = true;
        _loc2.__set__path(_loc3);
        _loc2.moveOnPath();
    } // End of the function
    function handlePuffleMove(puffle)
    {
        _engine.updatePuffleDepth(puffle.__get__clip(), puffle.__get__depth());
    } // End of the function
    function handlePuffleMoveComplete(puffle)
    {
        var _loc3 = _displayWidgetOnMoveComplete && _puffleIDForWidgetDisplay == puffle.__get__id();
        if (_loc3)
        {
            this.displayPuffleWidget(puffle);
        } // end if
        if (puffle.__get__isStartingInteraction() && !_loc3)
        {
            puffle.hide();
            puffle.__get__interactionClip().puffleID = puffle.id;
            puffle.__get__interactionClip().interactionCompleteCallback = com.clubpenguin.util.Delegate.create(this, handlePuffleInteractionComplete);
            puffle.__get__interactionClip().interact(this.getPuffleColorByTypeID(puffle.__get__typeID()));
        }
        else if (puffle.__get__isEndingInteraction() || _loc3)
        {
            _shell.setPuffleInteractionCompleteById(puffle.__get__id());
            puffle.__set__isEndingInteraction(false);
            puffle.__set__clickable(true);
        } // end else if
    } // End of the function
    function handlePuffleInteractionComplete(id)
    {
        var _loc2 = this.getPuffleByID(id);
        _loc2.__set__isStartingInteraction(false);
        _loc2.__set__isEndingInteraction(true);
        _loc2.__get__interactionClip().interactionActive = false;
        _loc2.show();
        var _loc3 = _loc2.__get__lastTraveledPath().concat();
        _loc3.reverse();
        _loc2.__set__path(_loc3);
        _loc2.moveOnPath();
    } // End of the function
    function cancelAllPuffleInteractions()
    {
        var _loc3 = 0;
        var _loc4 = _puffles.length;
        while (_loc3 < _loc4)
        {
            var _loc2 = (com.clubpenguin.engine.Puffle)(_puffles[_loc3]);
            if (_loc2.__get__isStartingInteraction() || _loc2.__get__isEndingInteraction())
            {
                _loc2.cancelInteraction();
            } // end if
            ++_loc3;
        } // end while
    } // End of the function
    function showPuffleByID(id)
    {
        var _loc2 = this.getPuffleByID(id);
        _loc2.show();
    } // End of the function
    function showAllPuffles()
    {
        var _loc2 = 0;
        var _loc3 = _puffles.length;
        while (_loc2 < _loc3)
        {
            (com.clubpenguin.engine.Puffle)(_puffles[_loc2]).show();
            ++_loc2;
        } // end while
    } // End of the function
    function walkPuffleByID(id)
    {
        var _loc2 = this.getPuffleByID(id);
        _loc2.__set__isWalking(true);
    } // End of the function
    function stopWalkingPuffleByID(id)
    {
        var _loc2 = this.getPuffleByID(id);
        _loc2.__set__isWalking(false);
    } // End of the function
    function hidePuffleByID(id)
    {
        var _loc2 = this.getPuffleByID(id);
        _loc2.hide();
    } // End of the function
    function hideAllPuffles()
    {
        var _loc2 = 0;
        var _loc3 = _puffles.length;
        while (_loc2 < _loc3)
        {
            (com.clubpenguin.engine.Puffle)(_puffles[_loc2]).hide();
            ++_loc2;
        } // end while
    } // End of the function
    function getPuffleByID(id)
    {
        var _loc3 = 0;
        var _loc4 = _puffles.length;
        while (_loc3 < _loc4)
        {
            var _loc2 = (com.clubpenguin.engine.Puffle)(_puffles[_loc3]);
            if (_loc2.__get__id() == id)
            {
                return (_loc2);
            } // end if
            ++_loc3;
        } // end while
    } // End of the function
    function hatAdded(puffleID)
    {
        var _loc2 = this.getPuffleByID(puffleID);
        var _loc4 = _shell.puffleManager.getMyPuffleById(puffleID);
        var _loc3 = _loc4.hat;
        _loc2.putOnHat(_loc3);
    } // End of the function
    function visitorHatAdded(puffleID)
    {
        var _loc2 = this.getPuffleByID(puffleID);
        var _loc3 = _shell.puffleManager.getRoomPuffleById(puffleID);
        var _loc5 = _loc3.model;
        var _loc4 = _loc5.hat;
        _loc2.putOnHat(_loc4);
    } // End of the function
    function hatRemoved(puffleID)
    {
        var _loc2 = this.getPuffleByID(puffleID);
        _loc2.takeOffHat();
    } // End of the function
    function getPuffleColorByTypeID(typeID)
    {
        var _loc2 = _shell.getPuffleCrumbs();
        var _loc3 = _loc2[typeID].colour;
        if (!isNaN(_loc3))
        {
            return (_loc3);
        } // end if
        return (_loc2[0].colour);
    } // End of the function
    function updatePuffleFrameByID(id, frame)
    {
        var _loc2 = this.getPuffleByID(id);
        com.clubpenguin.engine.tweener.Tweener.removeTweens(_loc2.__get__clip());
        _loc2.__set__frame(frame);
    } // End of the function
    function handlePuffleClick(puffle)
    {
        if (!_global.getCurrentShell().playerModel.isPlayerStealthModerator())
        {
            if (!_puffleWidgetQueued)
            {
                _puffleWidgetQueued = true;
                if (puffle.__get__isTweenWalking())
                {
                    _displayWidgetOnMoveComplete = true;
                    _puffleIDForWidgetDisplay = puffle.id;
                }
                else
                {
                    this.displayPuffleWidget(puffle);
                } // end if
            } // end if
        } // end else if
    } // End of the function
    function displayPuffleWidget(puffle)
    {
        _displayWidgetOnMoveComplete = false;
        _puffleIDForWidgetDisplay = null;
        var _loc5 = false;
        var _loc4 = new flash.geom.Point(puffle.__get__clip()._x, puffle.__get__clip()._y);
        var _loc6 = puffle.__get__typeID();
        var _loc3 = _shell.puffleManager.getRoomPuffleById(puffle.__get__id());
        _loc3.stopBrain();
        _engine.puffleUIWidgetController.displayPuffleWidget(puffle.__get__id(), _loc5, _loc4, _loc6, "radialMenuWidget", null);
    } // End of the function
    function removePuffle(dataObject)
    {
        var _loc2 = this.getPuffleByID(Number(dataObject.id));
        if (_loc2)
        {
            _loc2.__get__clip().removeMovieClip();
            _loc2.removeEventListener(com.clubpenguin.engine.Puffle.ON_MOVE, handlePuffleMove, this);
            _loc2.removeEventListener(com.clubpenguin.engine.Puffle.ON_MOVE_COMPLETE, handlePuffleMoveComplete, this);
            if (_shell.isMyIgloo())
            {
                _loc2.removeEventListener(com.clubpenguin.engine.Puffle.ON_CLICK, handlePuffleClick, this);
            } // end if
        } // end if
    } // End of the function
    function swapPuffle(dataObject)
    {
        var _loc2 = this.getPuffleByID(Number(dataObject.id));
        if (_loc2)
        {
            var _loc4 = new com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader(_shell.getMyPlayerId(), _loc2.__get__id(), _shell, _engine, false);
            var _loc3 = _shell.getPath(com.clubpenguin.engine.PuffleManager.POOF_ANIMATION_PATH);
            _loc4.playPuffleAnimation(_loc3, true);
        } // end if
    } // End of the function
    function completePuffleRadialMenu()
    {
        _puffleWidgetQueued = false;
    } // End of the function
    static var DEPTH_SORTING_Y_PADDING = 2;
    static var POOF_ANIMATION_PATH = "w.puffle.sprite.poof";
} // End of Class
