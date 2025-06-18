dynamic class com.clubpenguin.world.rooms.Plaza extends com.clubpenguin.world.rooms.BaseRoom
{
    static var CLASS_NAME: String = "Plaza";
    var UNDERGROUND_STAMP_ID: Number = 10;
    var _SHELL;
    var _abductionDelegate;
    var _destroyDelegate;
    var _stage;
    var aliendAbduction;
    var localize;
    var setupNavigationButtons;

    function Plaza(stageReference)
    {
        super(stageReference);
        trace(com.clubpenguin.world.rooms.Plaza.CLASS_NAME + "() !!!!!!!!");
        this._stage.start_x = 380;
        this._stage.start_y = 350;
        if (!this._SHELL) 
        {
            this.init();
        }
        this.localize([this._stage.petSign, this._stage.hotelSign, this._stage.mallSign, this._stage.pizzaSign, this._stage.background_mc.parkGate.gateOn.signText, this._stage.background_mc.parkGate.gateOff.signText]);
        this.setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.forts_btn, 35, 290), new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.park_btn, 85, 265), new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.navPet, 213, 245), new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.navHotel, 330, 237), new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.manhole_mc.manhole_btn, 270, 275), new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.navMall, 468, 220), new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.navPizza, 627, 245), new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.forest_btn, 720, 280)]);
        this._stage.forts_btn.useHandCursor = false;
        this._stage.forest_btn.useHandCursor = false;
        this._stage.background_mc.cannon_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, this.cannonAnimate);
        this._stage.background_mc.cannon_btn.useHandCursor = false;
        this._stage.park_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, this.parkRollOver);
        this._stage.park_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, this.parkRollOut);
        this._stage.manhole_mc.manhole_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, this.manholeRollOver);
        this._stage.manhole_mc.manhole_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, this.manholeRollOut);
        this._stage.navPizza.onRollOver = com.clubpenguin.util.Delegate.create(this, this.pizzaDoorRollOver);
        this._stage.navPizza.onRollOut = com.clubpenguin.util.Delegate.create(this, this.pizzaDoorRollOut);
        this._stage.navMall.onRollOver = com.clubpenguin.util.Delegate.create(this, this.mallDoorRollOver);
        this._stage.navMall.onRollOut = com.clubpenguin.util.Delegate.create(this, this.mallDoorRollOut);
        this._stage.navHotel.onRollOver = com.clubpenguin.util.Delegate.create(this, this.hotelDoorRollOver);
        this._stage.navHotel.onRollOut = com.clubpenguin.util.Delegate.create(this, this.hotelDoorRollOut);
        this._stage.navPet.onRollOver = com.clubpenguin.util.Delegate.create(this, this.petDoorRollOver);
        this._stage.navPet.onRollOut = com.clubpenguin.util.Delegate.create(this, this.petDoorRollOut);
        this._stage.triggers_mc.forts_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, this.exit, "forts", 655, 235);
        this._stage.triggers_mc.park_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, this.exit, "park", 335, 145);
        this._stage.triggers_mc.pet_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, this.exit, "pet", 380, 210);
        this._stage.triggers_mc.hotel_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, this.exit, "hotellobby", 380, 210);
        this._stage.triggers_mc.cave_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, this.exit, "cave", 590, 307);
        this._stage.triggers_mc.mall_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, this.exit, "mall", 150, 370);
        this._stage.triggers_mc.pizza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, this.exit, "pizza", 365, 195);
        this._stage.triggers_mc.forest_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, this.exit, "forest", 135, 215);
    }

    function cannonAnimate()
    {
        this._stage.foreground_mc.cannonpuffle_mc.gotoAndPlay(2);
        this._stage.background_mc.cannonsmoke_mc.gotoAndPlay(2);
        this._stage.background_mc.cannon_mc.gotoAndPlay(2);
    }

    function manholeRollOver()
    {
        this._stage.manhole_mc.gotoAndPlay("lidOpen");
    }

    function manholeRollOut()
    {
        this._stage.manhole_mc.gotoAndPlay("lidClose");
    }

    function parkRollOver()
    {
        this._stage.background_mc.parkGate.gotoAndStop("on");
    }

    function parkRollOut()
    {
        this._stage.background_mc.parkGate.gotoAndStop("off");
    }

    function pizzaDoorRollOver()
    {
        this._stage.pizzaDoor.gotoAndStop(2);
    }

    function pizzaDoorRollOut()
    {
        this._stage.pizzaDoor.gotoAndStop(1);
    }

    function mallDoorRollOver()
    {
        this._stage.mallDoor_mc_gay.gotoAndStop(2);
    }

    function mallDoorRollOut()
    {
        this._stage.mallDoor_mc_gay.gotoAndStop(1);
    }

    function hotelDoorRollOver()
    {
        this._stage.hotelDoor.gotoAndStop(2);
    }

    function hotelDoorRollOut()
    {
        this._stage.hotelDoor.gotoAndStop(1);
    }

    function petDoorRollOver()
    {
        this._stage.petDoor.gotoAndStop(2);
    }

    function petDoorRollOut()
    {
        this._stage.petDoor.gotoAndStop(1);
    }

    function exit(name, x, y)
    {
        trace(com.clubpenguin.world.rooms.Plaza.CLASS_NAME + ": exit() - name : " + name);
        if (name == "cave") 
        {
            this._SHELL.stampEarned(this.UNDERGROUND_STAMP_ID);
        }
        this._SHELL.sendJoinRoom(name, x, y);
    }

    function init()
    {
        trace(com.clubpenguin.world.rooms.Plaza.CLASS_NAME + ": init()");
        this._destroyDelegate = com.clubpenguin.util.Delegate.create(this, this.destroy);
        this._SHELL.addListener(this._SHELL.ROOM_DESTROYED, this._destroyDelegate);
        this._abductionDelegate = com.clubpenguin.util.Delegate.create(this, this.abductPenguin);
        _global.getCurrentAirtower().addListener("beamup", this._abductionDelegate);
    }

    function abductPenguin(data)
    {
        trace(com.clubpenguin.world.rooms.Plaza.CLASS_NAME + "abductPenguin() - data : " + data);
        var __reg4 = data[1];
        var __reg3 = _global.getCurrentEngine().getPlayerMovieClip(__reg4);
        this._stage.attachMovie("TractorBeam", "tractorBeam_mc", this._stage.getNextHighestDepth());
        this._stage.tractorBeam_mc.swapDepths(__reg3);
        this._stage.tractorBeam_mc._x = __reg3._x;
        this._stage.tractorBeam_mc._y = __reg3._y - 1;
        this.aliendAbduction = new com.clubpenguin.world.rooms.aliens.AlienAbduction();
        this.aliendAbduction.abductPlayer(__reg4, this._stage, this);
    }

    function abductedPlayerGoToUFO(player_id)
    {
        trace(com.clubpenguin.world.rooms.Plaza.CLASS_NAME + "abductedPlayerGoToUFO() - player_id !!!!!! : " + player_id);
        this._stage.tractorBeam_mc.removeMovieClip();
        if (this._SHELL.isMyPlayer(player_id)) 
        {
            trace("IS MY PLAYER - SEND JOIN ROOM");
            _global.getCurrentAirtower().removeListener("beamup", this._abductionDelegate);
            this._abductionDelegate = null;
            this._SHELL.sendJoinRoom("ufo", 380, 320);
        }
    }

    function destroy()
    {
        trace(com.clubpenguin.world.rooms.Plaza.CLASS_NAME + ": destroy()");
        this._SHELL.removeListener(this._SHELL.ROOM_DESTROYED, this._destroyDelegate);
        _global.getCurrentAirtower().removeListener("beamup", this._abductionDelegate);
        this._abductionDelegate = null;
    }

}
