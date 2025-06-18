dynamic class com.clubpenguin.world.rooms.cavemine.CaveMineDigging
{
    
    
    /**
    
        this class constants
    
    */
    public static var INVALID_TIMEOUT_ID: Number = -1;
    public static var DANCE_FRAME: Number = 26;
    public static var SHOVEL_ID = [342, 5177];
    public static var HARD_HAT_ID = [403, 429, 674, 1133, 10403, 10429, 11133, 21118];
    public static var MAXIMUM_DIGS_IN_ONE_SPOT: Number = 8;
    public static var REWARD_REQUEST_FREQUENCY: Number = 2000;
    public static var PIN_ID_NUMBER: Number = 7012;
    public static var COIN_X_OFFSET: Number = 0;
    public static var COIN_Y_OFFSET: Number = -25;
    public static var COIN_JACKPOT_X_OFFSET: Number = -17;
    public static var COIN_JACKPOT_Y_OFFSET: Number = -68;
    public static var COIN_DEPTH: Number = 1000000;
    public static var MIN_COINS_FOR_JACKPOT_AWARD_ANIMATION: Number = 100;
    
    /**
        Public Fields
    */
    
    public var lastDigSpot = null;
    public var consecutiveDigCount: Number = 0;
    public var timeoutID = INVALID_TIMEOUT_ID;
    
    /**
        Private fields
    */
    
    private var _ENGINE;
    private var _SHELL;
    private var _stageReference;


    // constructor
    function CaveMineDigging(stageReference, shellMC, engineMC)
    {
        this._stageReference = stageReference;
        this._SHELL = shellMC;
        this._ENGINE = engineMC;
        this.addEventListeners();
        this._stageReference.coinAnimHolderClip._visible = false;
    }

    
    // add _SHELL event listeners
    function addEventListeners()
    {
        this._SHELL.addListener(this._SHELL.PLAYER_MOVE, com.clubpenguin.util.Delegate.create(this, this.handleUpdatePlayer)); 
        this._SHELL.addListener(this._SHELL.PLAYER_FRAME, com.clubpenguin.util.Delegate.create(this, this.handleUpdatePlayer));
        this._SHELL.addListener(this._SHELL.UPDATE_PLAYER, com.clubpenguin.util.Delegate.create(this, this.handleUpdatePlayer));
        this._SHELL.addListener(this._SHELL.ROOM_DESTROYED, com.clubpenguin.util.Delegate.create(this, this.handleRoomDestroyed));
        this._SHELL.addListener(this._SHELL.COIN_DIG_UPDATE, com.clubpenguin.util.Delegate.create(this, this.handleCoinReward));
    }

    // remove _SHELL event listeners
    function removeEventListeners()
    {
        this._SHELL.removeListener(this._SHELL.PLAYER_MOVE, com.clubpenguin.util.Delegate.create(this, this.handleUpdatePlayer));
        this._SHELL.removeListener(this._SHELL.PLAYER_FRAME, com.clubpenguin.util.Delegate.create(this, this.handleUpdatePlayer));
        this._SHELL.removeListener(this._SHELL.UPDATE_PLAYER, com.clubpenguin.util.Delegate.create(this, this.handleUpdatePlayer));
        this._SHELL.removeListener(this._SHELL.ROOM_DESTROYED, com.clubpenguin.util.Delegate.create(this, this.handleRoomDestroyed));
        this._SHELL.removeListener(this._SHELL.COIN_DIG_UPDATE, com.clubpenguin.util.Delegate.create(this, this.handleCoinReward));
    }

    function handleUpdatePlayer(event)
    {
        if (this._SHELL.getMyPlayerId() == event.player_id) 
        {
            var __reg3 = false;
            var __reg2 = this._SHELL.getPlayerObjectById(event.player_id);
            if (this._stageReference.dig_area_mc.hitTest(__reg2.x, __reg2.y)) 
            {
                var __reg5 = this._SHELL.getSecretFrame(__reg2.player_id, __reg2.frame);
                if (__reg2.frame == DANCE_FRAME && __reg5 != __reg2.frame) 
                {
                    if (__reg2.hand == SHOVEL_ID[0] || __reg2.hand == SHOVEL_ID[1] || __reg2.head == HARD_HAT_ID[0] || __reg2.head == HARD_HAT_ID[1] || __reg2.head == HARD_HAT_ID[2] || __reg2.head == HARD_HAT_ID[3] || __reg2.head == HARD_HAT_ID[4] || __reg2.head == HARD_HAT_ID[5] || __reg2.head == HARD_HAT_ID[6] || __reg2.head == HARD_HAT_ID[7]) 
                    {
                        __reg3 = true;
                    }
                }
            }
            if (__reg3 && this.timeoutID == INVALID_TIMEOUT_ID) 
            {
                var rewardRequestDelegate = com.clubpenguin.util.Delegate.create(this, this.checkForReward);
                this.timeoutID = setInterval(rewardRequestDelegate, REWARD_REQUEST_FREQUENCY);
                return;
            }
            if (!__reg3 && this.timeoutID != INVALID_TIMEOUT_ID) 
            {
                clearInterval(this.timeoutID);
                this.timeoutID = INVALID_TIMEOUT_ID;
            }
        }
    }

    function checkForReward()
    {
        var __reg2 = this._ENGINE.getPlayerMovieClip(this._SHELL.getMyPlayerId());
        if (__reg2.hitTest(this.lastDigSpot.x, this.lastDigSpot.y)) 
        {
            ++this.consecutiveDigCount;
            if (this.consecutiveDigCount >= MAXIMUM_DIGS_IN_ONE_SPOT) 
            {
                return undefined;
            }
        }
        else 
        {
            this.consecutiveDigCount = 0;
        }
        this.lastDigSpot = {x: __reg2._x, y: __reg2._y};
        this._SHELL.sendGetCoinReward();
    }

    function handleCoinReward(event)
    {
        if (isNaN(event.numCoins) || event.numCoins < 1) 
        {
            return undefined;
        }
        if (!this._stageReference.coinAnimHolderClip._visible) 
        {
            this._stageReference.coinAnimHolderClip._visible = true;
            this._stageReference.coinAnimHolderClip.swapDepths(COIN_DEPTH);
        }
        var __reg2 = undefined;
        if (event.numCoins >= MIN_COINS_FOR_JACKPOT_AWARD_ANIMATION) 
        {
            this._stageReference.coinAnimHolderClip.coinRewardAnimClip._visible = false;
            this._stageReference.coinAnimHolderClip.superCoinRewardAnimClip._visible = true;
            __reg2 = this._stageReference.coinAnimHolderClip.superCoinRewardAnimClip;
        }
        else 
        {
            this._stageReference.coinAnimHolderClip.coinRewardAnimClip._visible = true;
            this._stageReference.coinAnimHolderClip.superCoinRewardAnimClip._visible = false;
            __reg2 = this._stageReference.coinAnimHolderClip.coinRewardAnimClip;
        }
        __reg2.gotoAndPlay("animate");
        __reg2.coinRewardClip.gotoAndPlay("animate");
        if (event.numCoins < MIN_COINS_FOR_JACKPOT_AWARD_ANIMATION) 
        {
            var label_mc = __reg2.coinRewardClip.labelClip;
            label_mc.labelField.text = event.numCoins;
            label_mc.labelField._visible = true;
            __reg2._x = this.lastDigSpot.x + COIN_X_OFFSET;
            __reg2._y = this.lastDigSpot.y + COIN_Y_OFFSET;
            return;
        }
        __reg2._x = this.lastDigSpot.x + COIN_JACKPOT_X_OFFSET;
        __reg2._y = this.lastDigSpot.y + COIN_JACKPOT_Y_OFFSET;
    }

    function handleRoomDestroyed()
    {
        if (this.timeoutID != INVALID_TIMEOUT_ID) 
        {
            clearInterval(this.timeoutID);
            this.timeoutID = INVALID_TIMEOUT_ID;
        }
        this.removeEventListeners();
    }

}