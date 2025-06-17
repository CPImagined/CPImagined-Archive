class com.clubpenguin.shell.RoomPuffle
{
    var model, _shell, _isMine, _selfInteract, _interactionEnabled, __get__isWalking, _updateInterval, updateListeners, __set__frame, __get__frame, __get__isMine, __get__interactionEnabled, __set__interactionEnabled, __set__isMine, __set__isWalking, __get__selfInteract;
    function RoomPuffle(shell, model)
    {
        this.model = model;
        this.model.__set__lastAction(com.clubpenguin.shell.RoomPuffle.PLAY_ACTION);
        _shell = shell;
        _isMine = false;
        _selfInteract = false;
        _interactionEnabled = true;
        com.clubpenguin.util.EventDispatcher.initialize(this);
        this.attachListeners();
    } // End of the function
    function attachListeners()
    {
        model.addEventListener(com.clubpenguin.shell.RoomPuffleModel.WALK, handlePuffleWalk, this);
        model.addEventListener(com.clubpenguin.shell.RoomPuffleModel.FRAME, handlePuffleFrame, this);
        model.addEventListener(com.clubpenguin.shell.RoomPuffleModel.MOVE, handlePuffleMove, this);
    } // End of the function
    function startBrain()
    {
        if (!_isMine)
        {
            return;
        } // end if
        if (this.__get__isWalking())
        {
            return;
        } // end if
        if (_updateInterval != null)
        {
            this.stopBrain();
        } // end if
        var _loc2 = 0;
        var _loc5 = com.clubpenguin.shell.RoomPuffle.UPDATE_MODIFIER;
        var _loc3 = Math.round(Math.random() * (_loc5 - _loc2)) + _loc2;
        var _loc4 = Math.round(_loc3 * com.clubpenguin.shell.RoomPuffle.ONE_SECOND_IN_MILLISECONDS);
        _updateInterval = setInterval(this, "handleBrain", _loc4 + com.clubpenguin.shell.RoomPuffle.UPDATE_BASE);
    } // End of the function
    function stopBrain()
    {
        clearInterval(_updateInterval);
        _updateInterval = null;
    } // End of the function
    function handleBrain()
    {
        if (model.__get__lastAction() == com.clubpenguin.shell.RoomPuffle.MOVE_ACTION)
        {
            model.__set__lastAction(com.clubpenguin.shell.RoomPuffle.PLAY_ACTION);
            if (model.mood.hungry && model.__get__notifyHunger())
            {
                this.updateListeners(com.clubpenguin.shell.RoomPuffle.REQUEST_FRAME, {id: model.id, frame: com.clubpenguin.shell.RoomPuffle.PUFFLE_HUNGER_FRAME});
                model.__set__notifyHunger(false);
                return;
            } // end if
            if (model.mood.angry && model.__get__notifyAngry())
            {
                this.updateListeners(com.clubpenguin.shell.RoomPuffle.REQUEST_FRAME, {id: model.id, frame: com.clubpenguin.shell.RoomPuffle.PUFFLE_ANGRY_FRAME});
                model.__set__notifyAngry(false);
                return;
            }
            else if (model.mood.tired && model.__get__notifyTired())
            {
                this.updateListeners(com.clubpenguin.shell.RoomPuffle.REQUEST_FRAME, {id: model.id, frame: com.clubpenguin.shell.RoomPuffle.PUFFLE_REST_FRAME});
                model.__set__notifyTired(false);
                return;
            } // end else if
            model.__set__notifyHunger(true);
            model.__set__notifyAngry(true);
            model.__set__notifyTired(true);
            this.updateListeners(com.clubpenguin.shell.RoomPuffle.REQUEST_MOVE, this);
        }
        else
        {
            model.__set__lastAction(com.clubpenguin.shell.RoomPuffle.MOVE_ACTION);
            if (_interactionEnabled)
            {
                if (com.clubpenguin.shell.RoomPuffle.playInteractionEnabled || com.clubpenguin.shell.RoomPuffle.restInteractionEnabled)
                {
                    if (!model.mood.tired)
                    {
                        var _loc4 = com.clubpenguin.shell.RoomPuffle.getBooleanByPercentage(com.clubpenguin.shell.RoomPuffle.RANDOM_INTERACTION_CHANCE);
                        if (_loc4)
                        {
                            var _loc2 = [];
                            if (com.clubpenguin.shell.RoomPuffle.playInteractionEnabled)
                            {
                                _loc2.push(com.clubpenguin.shell.RoomPuffle.INTERACTION_PLAY);
                            } // end if
                            if (com.clubpenguin.shell.RoomPuffle.restInteractionEnabled)
                            {
                                _loc2.push(com.clubpenguin.shell.RoomPuffle.INTERACTION_REST);
                            } // end if
                            var _loc3 = Math.round(Math.random() * (_loc2.length - 1 - 0)) + 0;
                            var _loc7 = _loc2[_loc3];
                            if (_loc7 != undefined)
                            {
                                _selfInteract = true;
                                this.updateListeners(com.clubpenguin.shell.RoomPuffle.REQUEST_INTERACTION, {id: model.id, interactionType: _loc7});
                                return;
                            } // end if
                        } // end if
                    } // end if
                } // end if
            } // end if
            this.updateListeners(com.clubpenguin.shell.RoomPuffle.REQUEST_MOVE, this);
        } // end else if
        this.startBrain();
    } // End of the function
    function cancelSelfInteraction()
    {
        _selfInteract = false;
        this.updateListeners(com.clubpenguin.shell.RoomPuffle.REQUEST_MOVE, this);
    } // End of the function
    function treat(treatID)
    {
        if (treatID == undefined)
        {
            return;
        } // end if
        if (treatID == com.clubpenguin.shell.RoomPuffle.TREAT_ANGRY)
        {
            this.__set__frame(com.clubpenguin.shell.RoomPuffle.ANGRY_TREAT_FRAME);
        }
        else if (treatID == com.clubpenguin.shell.RoomPuffle.TREAT_COOKIE)
        {
            this.__set__frame(com.clubpenguin.shell.RoomPuffle.COOKIE_TREAT_FRAME);
        }
        else if (treatID == com.clubpenguin.shell.RoomPuffle.TREAT_GUM)
        {
            this.__set__frame(com.clubpenguin.shell.RoomPuffle.GUM_TREAT_FRAME);
        } // end else if
    } // End of the function
    function forceNormalPlay()
    {
        if (model.mood.tired || model.mood.sad)
        {
            this.__set__frame(com.clubpenguin.shell.RoomPuffle.ANGRY_TREAT_FRAME);
            return;
        } // end if
        this.updateListeners(com.clubpenguin.shell.RoomPuffle.REQUEST_PLAY, this);
    } // End of the function
    function play(playID)
    {
        if (playID == undefined)
        {
            return;
        } // end if
        if (playID == com.clubpenguin.shell.RoomPuffle.SUPER_PLAY_TYPE)
        {
            this.__set__frame(com.clubpenguin.shell.RoomPuffle.SUPER_PLAY_FRAME);
        }
        else if (playID == com.clubpenguin.shell.RoomPuffle.GREAT_PLAY_TYPE)
        {
            this.__set__frame(com.clubpenguin.shell.RoomPuffle.GREAT_PLAY_FRAME);
        }
        else if (playID == com.clubpenguin.shell.RoomPuffle.NORMAL_PLAY_TYPE)
        {
            this.__set__frame(com.clubpenguin.shell.RoomPuffle.NORMAL_PLAY_FRAME);
        } // end else if
        this.updateListeners(com.clubpenguin.shell.RoomPuffle.REQUEST_PLAY, this);
    } // End of the function
    function wasPuffleJustAdopted()
    {
        return (_showAdoptionAnimation);
    } // End of the function
    function adoptionAnimationShown()
    {
        _showAdoptionAnimation = false;
    } // End of the function
    function requestStartWalk(showAdoptionAnimation)
    {
        if (this.__get__isWalking() && !showAdoptionAnimation)
        {
            return;
        } // end if
        _showAdoptionAnimation = showAdoptionAnimation;
        this.updateListeners(com.clubpenguin.shell.RoomPuffle.REQUEST_START_WALK, this);
    } // End of the function
    function requestStopWalk()
    {
        if (!this.__get__isWalking())
        {
            return;
        } // end if
        this.updateListeners(com.clubpenguin.shell.RoomPuffle.REQUEST_STOP_WALK, this);
    } // End of the function
    function forceNormalFeed()
    {
        this.updateListeners(com.clubpenguin.shell.RoomPuffle.REQUEST_FEED, this);
    } // End of the function
    function forcePuffleMove()
    {
        this.updateListeners(com.clubpenguin.shell.RoomPuffle.REQUEST_MOVE, this);
    } // End of the function
    function feed()
    {
        this.__set__frame(com.clubpenguin.shell.RoomPuffle.FEED_FRAME);
    } // End of the function
    function bath()
    {
        this.__set__frame(com.clubpenguin.shell.RoomPuffle.BATH_FRAME);
    } // End of the function
    function requestRest()
    {
        if (_interactionEnabled && com.clubpenguin.shell.RoomPuffle.restInteractionEnabled)
        {
            var _loc2 = com.clubpenguin.shell.RoomPuffle.getBooleanByPercentage(com.clubpenguin.shell.RoomPuffle.REST_INTERACTION_CHANCE);
            if (_loc2)
            {
                _selfInteract = false;
                this.updateListeners(com.clubpenguin.shell.RoomPuffle.REQUEST_INTERACTION, {id: model.id, interactionType: com.clubpenguin.shell.RoomPuffle.INTERACTION_REST});
                return;
            } // end if
        } // end if
        this.updateListeners(com.clubpenguin.shell.RoomPuffle.REQUEST_REST, this);
    } // End of the function
    function forceNormalRest()
    {
        this.updateListeners(com.clubpenguin.shell.RoomPuffle.REQUEST_REST, this);
    } // End of the function
    function rest()
    {
        this.__set__frame(com.clubpenguin.shell.RoomPuffle.REST_FRAME);
    } // End of the function
    static function setAllowFeedInteraction(bool)
    {
        feedInteractionEnabled = bool;
    } // End of the function
    static function setAllowRestInteraction(bool)
    {
        restInteractionEnabled = bool;
    } // End of the function
    static function setAllowPlayInteraction(bool)
    {
        playInteractionEnabled = bool;
    } // End of the function
    static function getBooleanByPercentage(chance)
    {
        var _loc1 = Math.round(Math.random() * 99) + 1;
        return (chance >= _loc1);
    } // End of the function
    function startInteraction(allowWalk)
    {
        model.__set__isInteracting(true);
        model.__set__isWalkable(allowWalk);
        this.stopBrain();
    } // End of the function
    function stopInteraction()
    {
        model.__set__isInteracting(false);
        model.__set__isWalkable(true);
        this.startBrain();
    } // End of the function
    function isWalkable()
    {
        //return (model.isWalkable());
    } // End of the function
    function moveTo(xpos, ypos)
    {
        this.startBrain();
        model.setPosition(xpos, ypos);
    } // End of the function
    function get frame()
    {
        //return (model.frame());
    } // End of the function
    function set frame(frame)
    {
        this.startBrain();
        model.__set__frame(frame);
        //return (this.frame());
        null;
    } // End of the function
    function get isWalking()
    {
        //return (model.isWalking());
    } // End of the function
    function set isWalking(isWalking)
    {
        model.__set__isWalking(isWalking);
        if (isWalking)
        {
            this.stopBrain();
            return;
        } // end if
        this.startBrain();
        //return (this.isWalking());
        null;
    } // End of the function
    function set isMine(bool)
    {
        _isMine = bool;
        //return (this.isMine());
        null;
    } // End of the function
    function get selfInteract()
    {
        return (_selfInteract);
    } // End of the function
    function set interactionEnabled(bool)
    {
        _interactionEnabled = bool;
        //return (this.interactionEnabled());
        null;
    } // End of the function
    function cleanUp()
    {
        this.stopBrain();
        model.removeEventListener(com.clubpenguin.shell.RoomPuffleModel.WALK, handlePuffleWalk, this);
        model.removeEventListener(com.clubpenguin.shell.RoomPuffleModel.FRAME, handlePuffleFrame, this);
        model.removeEventListener(com.clubpenguin.shell.RoomPuffleModel.MOVE, handlePuffleMove, this);
        model = null;
    } // End of the function
    function handlePuffleWalk(puffle)
    {
        var _loc3 = puffle.id;
        var _loc4 = puffle.__get__isWalking();
        _shell.updateListeners(_shell.PUFFLE_WALK, {id: _loc3, isWalking: _loc4});
    } // End of the function
    function handlePuffleFrame(puffle)
    {
        var _loc3 = puffle.id;
        var _loc4 = puffle.__get__frame();
        _shell.updateListeners(_shell.PUFFLE_FRAME, {id: _loc3, frame: _loc4});
    } // End of the function
    function handlePuffleMove(puffle)
    {
        var _loc5 = puffle.id;
        var _loc4 = puffle.__get__x();
        var _loc3 = puffle.__get__y();
        var _loc6 = puffle.mood.superHappy;
        _shell.updateListeners(_shell.PUFFLE_MOVE, {id: _loc5, x: _loc4, y: _loc3, superHappy: _loc6});
    } // End of the function
    static var UPDATE_MODIFIER = 10;
    static var UPDATE_BASE = 10000;
    static var ONE_SECOND_IN_MILLISECONDS = 1000;
    static var MOVE_ACTION = "moveAction";
    static var PLAY_ACTION = "playAction";
    static var PUFFLE_HUNGER_FRAME = 32;
    static var PUFFLE_ANGRY_FRAME = 33;
    static var PUFFLE_REST_FRAME = 26;
    static var NORMAL_PLAY_TYPE = 0;
    static var SUPER_PLAY_TYPE = 1;
    static var GREAT_PLAY_TYPE = 2;
    static var SUPER_PLAY_FRAME = 28;
    static var GREAT_PLAY_FRAME = 35;
    static var NORMAL_PLAY_FRAME = 27;
    static var REST_FRAME = 25;
    static var BATH_FRAME = 34;
    static var FEED_FRAME = 31;
    static var TREAT_ANGRY = 0;
    static var TREAT_COOKIE = 1;
    static var TREAT_GUM = 2;
    static var ANGRY_TREAT_FRAME = 33;
    static var GUM_TREAT_FRAME = 29;
    static var COOKIE_TREAT_FRAME = 30;
    static var playInteractionEnabled = false;
    static var restInteractionEnabled = false;
    static var feedInteractionEnabled = false;
    static var PLAY_INTERACTION_CHANCE = 100;
    static var REST_INTERACTION_CHANCE = 100;
    static var FEED_INTERACTION_CHANCE = 100;
    static var RANDOM_INTERACTION_CHANCE = 100;
    static var INTERACTION_PLAY = "playInteraction";
    static var INTERACTION_REST = "restInteraction";
    static var INTERACTION_FEED = "feedInteraction";
    static var REQUEST_MOVE = "requestMove";
    static var REQUEST_FRAME = "requestFrame";
    static var REQUEST_START_WALK = "requestStartWalk";
    static var REQUEST_STOP_WALK = "requestStopWalk";
    static var REQUEST_PLAY = "requestPlay";
    static var REQUEST_FEED = "requestFeed";
    static var REQUEST_BATH = "requestBath";
    static var REQUEST_REST = "requestRest";
    static var REQUEST_INTERACTION = "requestInteraction";
    var _showAdoptionAnimation = false;
} // End of Class
