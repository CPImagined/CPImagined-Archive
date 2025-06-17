//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.vo.puffle
{
    import com.clubpenguin.lib.vo.IVO;
    import org.osflash.signals.Signal;
    import com.clubpenguin.managers.resource.ResourceManager;
    import com.clubpenguin.lib.enums.puffle.PuffleTypeEnum;
    import com.clubpenguin.lib.enums.puffle.PuffleSubTypeEnum;
    import com.clubpenguin.lib.util.collection.Bag;
    import com.clubpenguin.lib.util.StringUtils;

    public class PuffleVO implements IVO 
    {

        public static const REGULAR_PLAY:int = 0;
        public static const SUPER_PLAY:int = 1;

        public const voUpdated:Signal = new Signal();

        [Inject]
        public var resourceManager:ResourceManager;
        public var statsVO:StatsVO = new StatsVO();
        public var moodVO:MoodVO = new MoodVO();
        public var type:PuffleTypeEnum;
        public var subType:PuffleSubTypeEnum;
        public var name:String = "";
        public var adoptionDate:Date;
        private var _id:int;
        private var _hatVO:CareItemVO = CareItemVO.getEmptyHatVO();


        public function destroy():void
        {
            this.voUpdated.removeAll();
            this.statsVO.destroy();
            this.moodVO.destroy();
            this.statsVO = null;
            this.moodVO = null;
            this.type = null;
            this.name = null;
            this.adoptionDate = null;
        }

        public function get hatVO():CareItemVO
        {
            return (this._hatVO);
        }

        public function set hatVO(hatVO:CareItemVO):void
        {
            this._hatVO = hatVO;
        }

        public function setHatVOByID(id:int):void
        {
            var masterInventoryCollection:Bag = this.resourceManager.getPuffleCareItemCollection();
            var hatVO:CareItemVO = (masterInventoryCollection.getItem(id) as CareItemVO);
            this._hatVO = hatVO;
        }

        public function get isWild():Boolean
        {
            return ((this.subType) && (this.subType.id > 0));
        }

        public function sendUpdate():void
        {
            this.voUpdated.dispatch();
        }

        public function update(vo:IVO):void
        {
            this.voUpdated.dispatch();
        }

        public function equals(vo:IVO):Boolean
        {
            return (this.id == vo.id);
        }

        public function set id(value:int):void
        {
            this._id = value;
            this.statsVO.puffleID = this._id;
            this.moodVO.puffleID = this._id;
        }

        public function get id():int
        {
            return (this._id);
        }

        public function get price():uint
        {
            if (this.isWild)
            {
                return (this.subType.price);
            };
            return (this.type.price);
        }

        public function get uniqueId():uint
        {
            if (this.isWild)
            {
                return (this.subType.id);
            };
            return (this.type.id);
        }

        public function get typeName():String
        {
            if (this.isWild)
            {
                return (this.subType.name);
            };
            return (this.type.colorName);
        }

        public function get description():String
        {
            if (this.isWild)
            {
                return (this.subType.description);
            };
            return (this.type.description);
        }

        public function toString():String
        {
            return (("id:" + this.id) + StringUtils.classVariablesDescription(this));
        }


    }
}//package com.clubpenguin.lib.vo.puffle
