﻿//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.shell.RoomPuffle
    {
        var model, _shell, _isMine, _selfInteract, _interactionEnabled, _updateInterval, updateListeners, __get__isMine, __get__interactionEnabled;
        function RoomPuffle (shell, model) {
            this.model = model;
            this.model.lastAction = PLAY_ACTION;
            _shell = shell;
            _isMine = false;
            _selfInteract = false;
            _interactionEnabled = true;
            trace("MODEL STATS ARE: " + model.stats);
            trace("MODEL STATS ARE: " + model.stats.playStat);
            com.clubpenguin.util.EventDispatcher.initialize(this);
            attachListeners();
        }
        function attachListeners() {
            model.addEventListener(com.clubpenguin.shell.RoomPuffleModel.WALK, handlePuffleWalk, this);
            model.addEventListener(com.clubpenguin.shell.RoomPuffleModel.FRAME, handlePuffleFrame, this);
            model.addEventListener(com.clubpenguin.shell.RoomPuffleModel.MOVE, handlePuffleMove, this);
        }
        function startBrain() {
            if (!_isMine) {
                return(undefined);
            }
            if (isWalking) {
                return(undefined);
            }
            if (_updateInterval != null) {
                stopBrain();
            }
            var _local_2 = 0;
            var _local_5 = UPDATE_MODIFIER;
            var _local_3 = Math.round(Math.random() * (_local_5 - _local_2)) + _local_2;
            var _local_4 = Math.round(_local_3 * ONE_SECOND_IN_MILLISECONDS);
            _updateInterval = setInterval(this, "handleBrain", _local_4 + UPDATE_BASE);
        }
        function stopBrain() {
            clearInterval(_updateInterval);
            _updateInterval = null;
        }
        function handleBrain() {
            if (model.lastAction == MOVE_ACTION) {
                model.lastAction = PLAY_ACTION;
                if (model.mood.hungry && (model.notifyHunger)) {
                    updateListeners(REQUEST_FRAME, {id:model.id, frame:PUFFLE_HUNGER_FRAME});
                    model.notifyHunger = false;
                    return(undefined);
                }
                if (model.mood.angry && (model.notifyAngry)) {
                    updateListeners(REQUEST_FRAME, {id:model.id, frame:PUFFLE_ANGRY_FRAME});
                    model.notifyAngry = false;
                    return(undefined);
                } else if (model.mood.tired && (model.notifyTired)) {
                    updateListeners(REQUEST_FRAME, {id:model.id, frame:PUFFLE_REST_FRAME});
                    model.notifyTired = false;
                    return(undefined);
                }
                model.notifyHunger = true;
                model.notifyAngry = true;
                model.notifyTired = true;
                updateListeners(REQUEST_MOVE, this);
            } else {
                model.lastAction = MOVE_ACTION;
                if (_interactionEnabled) {
                    if (playInteractionEnabled || (restInteractionEnabled)) {
                        if (!model.mood.tired) {
                            var _local_4 = getBooleanByPercentage(RANDOM_INTERACTION_CHANCE);
                            if (_local_4) {
                                var _local_2 = [];
                                if (playInteractionEnabled) {
                                    _local_2.push(INTERACTION_PLAY);
                                }
                                if (restInteractionEnabled) {
                                    _local_2.push(INTERACTION_REST);
                                }
                                var _local_3 = Math.round(Math.random() * ((_local_2.length - 1) - 0)) + 0;
                                var _local_7 = _local_2[_local_3];
                                if (_local_7 != undefined) {
                                    _selfInteract = true;
                                    updateListeners(REQUEST_INTERACTION, {id:model.id, interactionType:_local_7});
                                    return(undefined);
                                }
                            }
                        }
                    }
                }
                updateListeners(REQUEST_MOVE, this);
            }
            startBrain();
        }
        function cancelSelfInteraction() {
            _selfInteract = false;
            updateListeners(REQUEST_MOVE, this);
        }
        function treat(treatID) {
            if (treatID == undefined) {
                return(undefined);
            }
            if (treatID == TREAT_ANGRY) {
                frame = (ANGRY_TREAT_FRAME);
            } else if (treatID == TREAT_COOKIE) {
                frame = (COOKIE_TREAT_FRAME);
            } else if (treatID == TREAT_GUM) {
                frame = (GUM_TREAT_FRAME);
            }
        }
        function forceNormalPlay() {
            if (model.mood.tired || (model.mood.sad)) {
                frame = (ANGRY_TREAT_FRAME);
                return(undefined);
            }
            updateListeners(REQUEST_PLAY, this);
        }
        function play(playID) {
            if (playID == undefined) {
                return(undefined);
            }
            if (playID == SUPER_PLAY_TYPE) {
                frame = (SUPER_PLAY_FRAME);
            } else if (playID == GREAT_PLAY_TYPE) {
                frame = (GREAT_PLAY_FRAME);
            } else if (playID == NORMAL_PLAY_TYPE) {
                frame = (NORMAL_PLAY_FRAME);
            }
            updateListeners(REQUEST_PLAY, this);
        }
        function wasPuffleJustAdopted() {
            return(_showAdoptionAnimation);
        }
        function adoptionAnimationShown() {
            _showAdoptionAnimation = false;
        }
        function requestStartWalk(showAdoptionAnimation) {
            if (isWalking && (!showAdoptionAnimation)) {
                return(undefined);
            }
            _showAdoptionAnimation = showAdoptionAnimation;
            updateListeners(REQUEST_START_WALK, this);
        }
        function requestStopWalk() {
            if (!isWalking) {
                return(undefined);
            }
            updateListeners(REQUEST_STOP_WALK, this);
        }
        function forceNormalFeed() {
            updateListeners(REQUEST_FEED, this);
        }
        function forcePuffleMove() {
            updateListeners(REQUEST_MOVE, this);
        }
        function feed() {
            frame = (FEED_FRAME);
        }
        function bath() {
            frame = (BATH_FRAME);
        }
        function requestRest() {
            if (_interactionEnabled && (restInteractionEnabled)) {
                var _local_2 = getBooleanByPercentage(REST_INTERACTION_CHANCE);
                if (_local_2) {
                    _selfInteract = false;
                    updateListeners(REQUEST_INTERACTION, {id:model.id, interactionType:INTERACTION_REST});
                    return(undefined);
                }
            }
            updateListeners(REQUEST_REST, this);
        }
        function forceNormalRest() {
            updateListeners(REQUEST_REST, this);
        }
        function rest() {
            frame = (REST_FRAME);
        }
        static function setAllowFeedInteraction(bool) {
            feedInteractionEnabled = bool;
        }
        static function setAllowRestInteraction(bool) {
            restInteractionEnabled = bool;
        }
        static function setAllowPlayInteraction(bool) {
            playInteractionEnabled = bool;
        }
        static function getBooleanByPercentage(chance) {
            var _local_1 = Math.round(Math.random() * 99) + 1;
            return(chance >= _local_1);
        }
        function startInteraction(allowWalk) {
            model.isInteracting = true;
            model.isWalkable = allowWalk;
            stopBrain();
        }
        function stopInteraction() {
            model.isInteracting = false;
            model.isWalkable = true;
            startBrain();
        }
        function isWalkable() {
            return(model.isWalkable);
        }
        function moveTo(xpos, ypos) {
            startBrain();
            model.setPosition(xpos, ypos);
        }
        function get frame() {
            return(model.frame);
        }
        function set frame(frame) {
            startBrain();
            model.frame = frame;
            //return(this.frame);
        }
        function get isWalking() {
            return(model.isWalking);
        }
        function set isWalking(isWalking) {
            model.isWalking = isWalking;
            if (isWalking) {
                stopBrain();
                return;
            }
            startBrain();
            //return(this.isWalking);
        }
        function set isMine(bool) {
            _isMine = bool;
            //return(__get__isMine());
        }
        function get selfInteract() {
            return(_selfInteract);
        }
        function set interactionEnabled(bool) {
            _interactionEnabled = bool;
            //return(__get__interactionEnabled());
        }
        function cleanUp() {
            stopBrain();
            model.removeEventListener(com.clubpenguin.shell.RoomPuffleModel.WALK, handlePuffleWalk, this);
            model.removeEventListener(com.clubpenguin.shell.RoomPuffleModel.FRAME, handlePuffleFrame, this);
            model.removeEventListener(com.clubpenguin.shell.RoomPuffleModel.MOVE, handlePuffleMove, this);
            model = null;
        }
        function handlePuffleWalk(puffle) {
            var _local_3 = puffle.id;
            var _local_4 = puffle.isWalking;
            _shell.updateListeners(_shell.PUFFLE_WALK, {id:_local_3, isWalking:_local_4});
        }
        function handlePuffleFrame(puffle) {
            var _local_3 = puffle.id;
            var _local_4 = puffle.frame;
            _shell.updateListeners(_shell.PUFFLE_FRAME, {id:_local_3, frame:_local_4});
        }
        function handlePuffleMove(puffle) {
            var _local_5 = puffle.id;
            var _local_4 = puffle.x;
            var _local_3 = puffle.y;
            var _local_6 = puffle.mood.superHappy;
            _shell.updateListeners(_shell.PUFFLE_MOVE, {id:_local_5, x:_local_4, y:_local_3, superHappy:_local_6});
        }
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
    }
