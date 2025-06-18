//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.smoothie.PrizeRoom extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, _destroyDelegate, _SHELL, _triggerWatcher, handleBuyInventoryDelegate, _chewTrigger, setupNavigationButtons, _opcodeJournal, _triggerWatcherInterval, _ENGINE, _INTERFACE;
        function PrizeRoom (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 170;
            _stage.start_y = 355;
        }
        function init() {
            localize([_stage.background_mc.stairs_mc.date_mc.sign1_mc, _stage.background_mc.stairs_mc.date_mc.sign2_mc]);
            trace(CLASS_NAME + ": init()");
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher(_stage, _SHELL);
            handleBuyInventoryDelegate = com.clubpenguin.util.Delegate.create(this, handleBuyInventory);
            localize([_stage.background_mc.stairs_mc.sign1_mc, _stage.background_mc.stairs_mc.sign2_mc]);
            checkIfPlayerHasPartyItems();
            _chewTrigger = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.feed_mc);
            _chewTrigger.isLocalPlayerOnly();
            _chewTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, validateChewing));
            _triggerWatcher.addTrigger(_chewTrigger);
            _stage.triggers_mc.watermelon_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, getWatermelon);
            _stage.triggers_mc.apple_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, getApple);
            _stage.triggers_mc.pineapple_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, getPineapple);
            _stage.background_mc.faces_mc.apple_mc.button_mc.apple_btn.onRelease = com.clubpenguin.util.Delegate.create(this, moveToApple);
            _stage.background_mc.faces_mc.watermelon_mc.button_mc.watermelon_btn.onRelease = com.clubpenguin.util.Delegate.create(this, moveToWatermelon);
            _stage.background_mc.faces_mc.pineapple_mc.button_mc.pineapple_btn.onRelease = com.clubpenguin.util.Delegate.create(this, moveToPineapple);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.volcano_mc.feed_btn, 565, 340), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.doors_mc.doors_btn, 525, 220)]);
            _stage.pinappleAnim_mc.play();
            _opcodeJournal = new com.clubpenguin.world.rooms2012.smoothie.OpcodeJournal();
            _opcodeJournal.init(_SHELL.getMyPlayerId());
            _SHELL.stampEarned(STUNT_PENGUIN_STAMP);
            _SHELL.addListener(_SHELL.BUY_INVENTORY, handleBuyInventoryDelegate);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
        }
        function moveToPineapple() {
            trace("move to apple");
            _ENGINE.sendPlayerMove(412, 216);
        }
        function moveToWatermelon() {
            trace("move to apple");
            _ENGINE.sendPlayerMove(235, 225);
        }
        function moveToApple() {
            trace("move to apple");
            _ENGINE.sendPlayerMove(335, 209);
        }
        function handleBuyInventory(result) {
            if (result.success) {
                switch (result.item_id) {
                    case com.clubpenguin.world.rooms2012.smoothie.Smoothie.WATERMELON_COSTUME : 
                        _stage.background_mc.faces_mc.watermelon_mc.gotoAndStop("gone");
                        break;
                    case com.clubpenguin.world.rooms2012.smoothie.Smoothie.APPLE_COSTUME : 
                        _stage.background_mc.faces_mc.apple_mc.gotoAndStop("gone");
                        break;
                    case com.clubpenguin.world.rooms2012.smoothie.Smoothie.PINEAPPLE_COSTUME : 
                        _stage.background_mc.faces_mc.pineapple_mc.gotoAndStop("gone");
                        _opcodeJournal.sendOpcode(com.clubpenguin.world.rooms2012.smoothie.OpcodeJournal.TEMPLE_REWARD_EARNED);
                        break;
                }
            }
        }
        function activateFortTrigger() {
            _stage.triggers_mc.forts_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forts", 385, 325);
        }
        function checkIfPlayerHasPartyItems() {
            if (_SHELL.isItemInMyInventory(com.clubpenguin.world.rooms2012.smoothie.Smoothie.WATERMELON_COSTUME)) {
                _stage.background_mc.faces_mc.watermelon_mc.gotoAndStop("gone");
            }
            if (_SHELL.isItemInMyInventory(com.clubpenguin.world.rooms2012.smoothie.Smoothie.APPLE_COSTUME)) {
                _stage.background_mc.faces_mc.apple_mc.gotoAndStop("gone");
            }
            if (_SHELL.isItemInMyInventory(com.clubpenguin.world.rooms2012.smoothie.Smoothie.PINEAPPLE_COSTUME)) {
                _stage.background_mc.faces_mc.pineapple_mc.gotoAndStop("gone");
            }
        }
        function getWatermelon() {
            if (!_SHELL.isItemInMyInventory(com.clubpenguin.world.rooms2012.smoothie.Smoothie.WATERMELON_COSTUME)) {
                _INTERFACE.buyInventory(com.clubpenguin.world.rooms2012.smoothie.Smoothie.WATERMELON_COSTUME);
                _SHELL.stampEarned(SCAVENGER_HUNT_STAMP);
            }
        }
        function getApple() {
            if (_SHELL.server_time.getTime() >= com.clubpenguin.world.rooms2012.smoothie.Smoothie.APPLE_DATE) {
                if (!_SHELL.isItemInMyInventory(com.clubpenguin.world.rooms2012.smoothie.Smoothie.APPLE_COSTUME)) {
                    _INTERFACE.buyInventory(com.clubpenguin.world.rooms2012.smoothie.Smoothie.APPLE_COSTUME);
                    _SHELL.stampEarned(SCAVENGER_HUNT_STAMP);
                }
            }
        }
        function getPineapple() {
            if (_SHELL.server_time.getTime() >= com.clubpenguin.world.rooms2012.smoothie.Smoothie.PINEAPPLE_DATE) {
                if (!_SHELL.isItemInMyInventory(com.clubpenguin.world.rooms2012.smoothie.Smoothie.PINEAPPLE_COSTUME)) {
                    _INTERFACE.buyInventory(com.clubpenguin.world.rooms2012.smoothie.Smoothie.PINEAPPLE_COSTUME);
                    _SHELL.stampEarned(SCAVENGER_HUNT_STAMP);
                }
            }
        }
        function validateChewing() {
            _ENGINE.sendPlayerMove(564, 345);
            var _local_2 = false;
            trace("validate chewing");
            if (!_local_2) {
                if (com.clubpenguin.world.rooms2012.smoothie.Smoothie.hasCollectedScavengerHuntItems()) {
                    _local_2 = true;
                    activateChew();
                } else if (com.clubpenguin.world.rooms2012.smoothie.Smoothie.hasScavengerHuntPin()) {
                    _local_2 = true;
                    activateChew();
                }
            }
        }
        function checkCageDates() {
            var _local_2 = new Date();
            _local_2 = Math.round(_local_2.getTime() / 1000);
            _stage.background_mc.faces_mc.cage1_mc.play();
            if (_local_2 >= com.clubpenguin.world.rooms2012.smoothie.Smoothie.PINEAPPLE_DATE) {
                _stage.background_mc.faces_mc.cage2_mc.play();
                _stage.background_mc.faces_mc.cage3_mc.play();
            } else if (_local_2 >= com.clubpenguin.world.rooms2012.smoothie.Smoothie.APPLE_DATE) {
                _stage.background_mc.faces_mc.cage2_mc.play();
            }
        }
        function activateChew() {
            if (_stage.foreground_mc.fruit_mc._currentframe == 1) {
                _stage.foreground_mc.fruit_mc.play();
                _stage.volcano_mc.anim_mc.chew_mc.play();
                _stage.foreground_mc.beak_mc.play();
                _stage.background_mc.faces_mc.light_mc.play();
                checkCageDates();
                _stage.background_mc.doors_mc.play();
                _stage.volcano_mc.anim_mc.glow_mc.play(2);
                if (_stage.background_mc.faces_mc.watermelon_mc._currentframe == 1) {
                    _stage.background_mc.faces_mc.watermelon_mc.play();
                }
                if (_stage.background_mc.faces_mc.apple_mc._currentframe == 1) {
                    _stage.background_mc.faces_mc.apple_mc.play();
                }
                if (_stage.background_mc.faces_mc.pineapple_mc._currentframe == 1) {
                    _stage.background_mc.faces_mc.pineapple_mc.play();
                }
            }
        }
        function exit(roomName, x, y) {
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "PrizeRoom";
        static var SCAVENGER_HUNT_STAMP = 188;
        static var STUNT_PENGUIN_STAMP = 438;
    }
