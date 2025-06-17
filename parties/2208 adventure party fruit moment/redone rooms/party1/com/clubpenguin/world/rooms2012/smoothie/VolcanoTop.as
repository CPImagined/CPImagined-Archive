//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.smoothie.VolcanoTop extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _numberOfFruitThrown, _destroyDelegate, _SHELL, _snowballCheckDelegate, _currentTeam, _opcodeJournal, _onBuyInventoryDelegate, _INTERFACE;
        function VolcanoTop (stageReference) {
            super(stageReference);
            _stage.start_x = 380;
            _stage.start_y = 330;
        }
        function init() {
            _numberOfFruitThrown = 0;
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _stage.triggers_mc.forts1_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forts", 245, 145);
            _stage.triggers_mc.forts2_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forts", 385, 155);
            _stage.triggers_mc.forts3_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forts", 530, 160);
            _stage.background_mc.volcano_back.help_mc.help_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showHelp);
            _snowballCheckDelegate = com.clubpenguin.util.Delegate.create(this, onSnowballLand);
            _SHELL.addListener(_SHELL.BALL_LAND, _snowballCheckDelegate);
            _currentTeam = _SHELL.getPlayerObjectById(_SHELL.getMyPlayerId()).avatar_id;
            _stage.foreground_mc.prizes.red_prize_door.prize_red.prize_red_button.onRelease = com.clubpenguin.util.Delegate.create(this, awardItem, com.clubpenguin.world.rooms2012.smoothie.Smoothie.RED_TRIBE_BACKGROUND);
            _stage.foreground_mc.prizes.yellow_prize_door.prize_yellow.prize_yellow_button.onRelease = com.clubpenguin.util.Delegate.create(this, awardItem, com.clubpenguin.world.rooms2012.smoothie.Smoothie.YELLOW_TRIBE_BACKGROUND);
            _stage.foreground_mc.prizes.green_prize_door.green_prize.green_prize_button.onRelease = com.clubpenguin.util.Delegate.create(this, awardItem, com.clubpenguin.world.rooms2012.smoothie.Smoothie.GREEN_TRIBE_BACKGROUND);
            _stage.background_mc.grape_prize_cage.purple_prize_button.onRelease = com.clubpenguin.util.Delegate.create(this, awardItem, com.clubpenguin.world.rooms2012.smoothie.Smoothie.GRAPE_COSTUME);
            switch (_currentTeam) {
                case com.clubpenguin.world.rooms2012.smoothie.Smoothie.APPLE_TRIBE : 
                    _stage.foreground_mc.prizes.red_score_txt.text = _numberOfFruitNeeded;
                    _stage.foreground_mc.prizes.yellow_score_txt.text = _numberOfFruitNeeded;
                    _stage.foreground_mc.prizes.green_score_txt.text = _numberOfFruitNeeded;
                    break;
                case com.clubpenguin.world.rooms2012.smoothie.Smoothie.PINEAPPLE_TRIBE : 
                    _stage.foreground_mc.prizes.red_score_txt.text = _numberOfFruitNeeded;
                    _stage.foreground_mc.prizes.yellow_score_txt.text = _numberOfFruitNeeded;
                    _stage.foreground_mc.prizes.green_score_txt.text = _numberOfFruitNeeded;
                    break;
                case com.clubpenguin.world.rooms2012.smoothie.Smoothie.WATERMELON_TRIBE : 
                    _stage.foreground_mc.prizes.red_score_txt.text = _numberOfFruitNeeded;
                    _stage.foreground_mc.prizes.yellow_score_txt.text = _numberOfFruitNeeded;
                    _stage.foreground_mc.prizes.green_score_txt.text = _numberOfFruitNeeded;
                    break;
            }
            _opcodeJournal = new com.clubpenguin.world.rooms2012.smoothie.OpcodeJournal();
            _opcodeJournal.init(_SHELL.getMyPlayerId());
            _onBuyInventoryDelegate = com.clubpenguin.util.Delegate.create(this, checkIfGrapeCostumeUnlocked);
            _SHELL.addListener(_SHELL.BUY_INVENTORY, _onBuyInventoryDelegate);
            checkIfGrapeCostumeUnlocked();
        }
        function checkIfGrapeCostumeUnlocked(result) {
            if (_SHELL.isItemInMyInventory(com.clubpenguin.world.rooms2012.smoothie.Smoothie.GRAPE_COSTUME)) {
                _stage.background_mc.grape_prize_cage.gotoAndStop(2);
                _stage.background_mc.grape_prize_cage.purple_prize_button._visible = false;
                return(undefined);
            }
            if ((_SHELL.isItemInMyInventory(com.clubpenguin.world.rooms2012.smoothie.Smoothie.RED_TRIBE_BACKGROUND) && (_SHELL.isItemInMyInventory(com.clubpenguin.world.rooms2012.smoothie.Smoothie.YELLOW_TRIBE_BACKGROUND))) && (_SHELL.isItemInMyInventory(com.clubpenguin.world.rooms2012.smoothie.Smoothie.GREEN_TRIBE_BACKGROUND))) {
                _stage.background_mc.grape_prize_cage.gotoAndStop(2);
                return(undefined);
            }
            if (!result) {
                return(undefined);
            }
            if (result.success) {
                switch (result.item_id) {
                    case com.clubpenguin.world.rooms2012.smoothie.Smoothie.RED_TRIBE_BACKGROUND : 
                        if (_SHELL.isItemInMyInventory(com.clubpenguin.world.rooms2012.smoothie.Smoothie.YELLOW_TRIBE_BACKGROUND) && (_SHELL.isItemInMyInventory(com.clubpenguin.world.rooms2012.smoothie.Smoothie.GREEN_TRIBE_BACKGROUND))) {
                            _stage.background_mc.grape_prize_cage.gotoAndStop(2);
                        }
                        break;
                    case com.clubpenguin.world.rooms2012.smoothie.Smoothie.YELLOW_TRIBE_BACKGROUND : 
                        if (_SHELL.isItemInMyInventory(com.clubpenguin.world.rooms2012.smoothie.Smoothie.RED_TRIBE_BACKGROUND) && (_SHELL.isItemInMyInventory(com.clubpenguin.world.rooms2012.smoothie.Smoothie.GREEN_TRIBE_BACKGROUND))) {
                            _stage.background_mc.grape_prize_cage.gotoAndStop(2);
                        }
                        break;
                    case com.clubpenguin.world.rooms2012.smoothie.Smoothie.GREEN_TRIBE_BACKGROUND : 
                        if (_SHELL.isItemInMyInventory(com.clubpenguin.world.rooms2012.smoothie.Smoothie.RED_TRIBE_BACKGROUND) && (_SHELL.isItemInMyInventory(com.clubpenguin.world.rooms2012.smoothie.Smoothie.YELLOW_TRIBE_BACKGROUND))) {
                            _stage.background_mc.grape_prize_cage.gotoAndStop(2);
                        }
                        break;
                }
            }
        }
        function awardItem(itemID) {
            if (itemID == com.clubpenguin.world.rooms2012.smoothie.Smoothie.GRAPE_COSTUME) {
                _opcodeJournal.sendOpcode(com.clubpenguin.world.rooms2012.smoothie.OpcodeJournal.KAHUNA_GRAPE_COSTUME_EARNED);
            } else {
                _opcodeJournal.sendOpcode(com.clubpenguin.world.rooms2012.smoothie.OpcodeJournal.KAHUNA_BACKGROUND_EARNED);
            }
            _INTERFACE.buyInventory(itemID);
        }
        function onSnowballLand(snowballInfo) {
            _currentTeam = _SHELL.getPlayerObjectById(_SHELL.getMyPlayerId()).avatar_id;
            if (snowballInfo.player_id != _SHELL.getMyPlayerId()) {
                return(undefined);
            }
            if (_stage.mouth.hitTest(snowballInfo.x, snowballInfo.y, true)) {
                snowballInfo.snowballMC._visible = false;
                _numberOfFruitThrown++;
                var _local_2 = _numberOfFruitNeeded - _numberOfFruitThrown;
                if (_local_2 < 0) {
                    return(undefined);
                }
                var _local_3;
                switch (_currentTeam) {
                    case com.clubpenguin.world.rooms2012.smoothie.Smoothie.APPLE_TRIBE : 
                        _local_3 = _stage.foreground_mc.prizes.red_prize_door;
                        _stage.foreground_mc.prizes.red_score_txt.text = _local_2;
                        break;
                    case com.clubpenguin.world.rooms2012.smoothie.Smoothie.PINEAPPLE_TRIBE : 
                        _local_3 = _stage.foreground_mc.prizes.yellow_prize_door;
                        _stage.foreground_mc.prizes.yellow_score_txt.text = _local_2;
                        break;
                    case com.clubpenguin.world.rooms2012.smoothie.Smoothie.WATERMELON_TRIBE : 
                        _local_3 = _stage.foreground_mc.prizes.green_prize_door;
                        _stage.foreground_mc.prizes.green_score_txt.text = _local_2;
                        break;
                }
                if (_local_2 <= 0) {
                    if (_local_3._currentframe > 2) {
                        return(undefined);
                    }
                    _local_3.gotoAndPlay(2);
                    _stage.mouth.gotoAndStop(2);
                    if ((_SHELL.isItemInMyInventory(com.clubpenguin.world.rooms2012.smoothie.Smoothie.RED_TRIBE_BACKGROUND) && (_SHELL.isItemInMyInventory(com.clubpenguin.world.rooms2012.smoothie.Smoothie.YELLOW_TRIBE_BACKGROUND))) && (_SHELL.isItemInMyInventory(com.clubpenguin.world.rooms2012.smoothie.Smoothie.GREEN_TRIBE_BACKGROUND))) {
                        _stage.background_mc.grape_prize_cage.gotoAndStop(2);
                    }
                }
            }
        }
        function showHelp() {
            _INTERFACE.showContent(com.clubpenguin.world.rooms2012.smoothie.Smoothie.VOLCANO_TOP_HELP);
        }
        function showGrapeHelp() {
            _INTERFACE.showContent(com.clubpenguin.world.rooms2012.smoothie.Smoothie.VOLCANO_TOP_GRAPE_HELP);
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            _SHELL.setAvatarTransformation(0);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _SHELL.removeListener(_SHELL.BUY_INVENTORY, _onBuyInventoryDelegate);
        }
        static var CLASS_NAME = "VolcanoTop";
        var _numberOfFruitNeeded = 15;
    }
