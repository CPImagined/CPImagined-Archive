//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.vo
{
    import org.osflash.signals.Signal;
    import com.clubpenguin.main.model.ActiveQuestsModel;
    import com.clubpenguin.lib.vo.quest.QuestVO;
    import com.clubpenguin.lib.util.collection.Bag;
    import com.clubpenguin.lib.vo.puffle.PuffleVO;
    import com.clubpenguin.lib.vo.puffle.CareItemVO;
    import com.clubpenguin.lib.enums.puffle.CareItemInventoryTypeEnum;
    import com.clubpenguin.lib.util.StringUtils;
    import com.clubpenguin.lib.util.collection.ICollection;

    public class PlayerVO implements IPlayerVO 
    {

        public const voUpdated:Signal = new Signal();

        public var nickname:String;
        public var username:String;
        public var player_id:int = -1;
        public var player_swid:String = "{not_set}";
        public var coins:int;
        public var is_epf_agent:Boolean;
        public var buddyList:Array = [];
        public var isEPFAgent:Boolean;
        public var membershipEnum:int = 0;
        public var is_member:Boolean;
        public var choseSafeChatWorld:Boolean;
        public var activeKey:String;
        public var hasAccessedPuffleCare:Boolean = false;
        public var colour_id:Number = 0;
        public var hasSeenPuffleTreasureInfographic:Boolean;
        public var hasSwappedPuffle:Boolean;
        public var hasSeenBackyard:Boolean;
        public var hasSeenIglooFull:Boolean;
        public var currentRoom:Number;
        public var quests:ActiveQuestsModel = new ActiveQuestsModel(QuestVO);
        public var puffles:Bag = new Bag(PuffleVO);
        public var puffleFoodInventory:Bag = new Bag(CareItemVO);
        public var pufflePlayInventory:Bag = new Bag(CareItemVO);
        public var puffleCareInventory:Bag = new Bag(CareItemVO);
        public var puffleSleepInventory:Bag = new Bag(CareItemVO);
        public var puffleHeadInventory:Bag = new Bag(CareItemVO);
        public var loginDataRaw:String;
        public var friendLoginKey:String;
        public var confirmationHash:String;
        public var remaining_hours:int;
        public var max_grace_hours:int;
        public var trialMax:int;
        public var emailAddress:String;
        public var _is_safemode:String = "";
        public var hasSeenPartyLogin:Boolean = false;


        public function destroy():void
        {
            this.voUpdated.removeAll();
            this.puffles.destroy(true);
            this.puffles = null;
            this.buddyList = null;
        }

        public function update():void
        {
            this.voUpdated.dispatch();
        }

        public function getCareItemInventoryByCategory(category:CareItemInventoryTypeEnum):Bag
        {
            switch (category)
            {
                case CareItemInventoryTypeEnum.FOOD:
                    return (this.puffleFoodInventory);
                case CareItemInventoryTypeEnum.PLAY:
                    return (this.pufflePlayInventory);
                case CareItemInventoryTypeEnum.CARE:
                    return (this.puffleCareInventory);
                case CareItemInventoryTypeEnum.SLEEP:
                    return (this.puffleSleepInventory);
                case CareItemInventoryTypeEnum.HEAD:
                    return (this.puffleHeadInventory);
                case CareItemInventoryTypeEnum.GAME:
                default:
                    return (null);
            };
        }

        public function toString():String
        {
            return (StringUtils.classVariablesDescription(this));
        }

        public function getNickname():String
        {
            return (this.nickname);
        }

        public function getPlayerId():int
        {
            return (this.player_id);
        }

        public function getPlayerSwid():String
        {
            return (this.player_swid);
        }

        public function getIsEpfAgent():Boolean
        {
            return (this.is_epf_agent);
        }

        public function getIsMember():Boolean
        {
            return (this.is_member);
        }

        public function getMembershipEnum():int
        {
            return (this.membershipEnum);
        }

        public function getCoins():int
        {
            return (this.coins);
        }

        public function setNickname(value:String):void
        {
            this.nickname = value;
        }

        public function setUsername(value:String):void
        {
            this.username = value;
        }

        public function setPlayerId(value:int):void
        {
            this.player_id = value;
        }

        public function setIsEpfAgent(value:Boolean):void
        {
            this.is_epf_agent = value;
        }

        public function setMembershipEnum(value:int):void
        {
            this.membershipEnum = value;
        }

        public function setIsMember(value:Boolean):void
        {
            this.is_member = value;
        }

        public function setCoins(value:int):void
        {
            this.coins = value;
        }

        public function getIsSafeMode():Boolean
        {
            var returnBoolean:Boolean;
            switch (this._is_safemode)
            {
                case "true":
                case "1":
                    returnBoolean = true;
                    break;
                case "false":
                case "0":
                    returnBoolean = false;
                    break;
                default:
                    throw (new Error("PlayerVO received a 'is_safemode' value that wasn't valid."));
            };
            return (returnBoolean);
        }

        public function getChoseSafeChatWorld():Boolean
        {
            return (this.choseSafeChatWorld);
        }

        public function set is_safemode(safeModeString:String):void
        {
            this._is_safemode = safeModeString;
        }

        public function getPuffles():ICollection
        {
            var array:Array;
            var i:uint;
            var filteredPuffles:Bag = new Bag(PuffleVO);
            if (this.currentRoom == 957)
            {
                array = this.puffles.getAllItems();
                i = 0;
                while (i < array.length)
                {
                    if ((((!(array[i].type.id == 10)) && (!(array[i].type.id == 11))) && (!(array[i].isWild))))
                    {
                        filteredPuffles.add(array[i]);
                    };
                    i++;
                };
            }
            else
            {
                filteredPuffles = this.puffles;
            };
            return (filteredPuffles);
        }

        public function getColorID():Number
        {
            return (this.colour_id);
        }

        public function getSWID():String
        {
            return (this.getPlayerSwid());
        }

        public function getRemainingHours():int
        {
            return (this.remaining_hours);
        }

        public function getMaxGraceHours():int
        {
            return (this.max_grace_hours);
        }

        public function getConfirmationHash():String
        {
            return (this.confirmationHash);
        }

        public function getLoginDataRaw():String
        {
            return (this.loginDataRaw);
        }

        public function getEmailAddress():String
        {
            return (this.emailAddress);
        }


    }
}//package com.clubpenguin.lib.vo
