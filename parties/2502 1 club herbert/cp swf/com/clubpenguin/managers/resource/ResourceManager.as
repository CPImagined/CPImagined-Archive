//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.managers.resource
{
    import com.clubpenguin.lib.managers.resource.IResourceManager;
    import flash.utils.Dictionary;
    import com.clubpenguin.lib.util.collection.Bag;
    import com.clubpenguin.lib.enums.resource.ResourceTypeEnum;
    import com.clubpenguin.lib.vo.resource.ClothingVO;
    import com.clubpenguin.lib.vo.resource.FurnitureVO;
    import com.clubpenguin.lib.vo.resource.ResourceVO;
    import com.clubpenguin.lib.enums.resource.ClothingTypeEnum;
    import com.clubpenguin.lib.vo.EnvironmentDataVO;
    import com.clubpenguin.lib.vo.PathsVO;
    import com.clubpenguin.lib.enums.resource.FurnitureTypeEnum;
    import com.clubpenguin.lib.enums.resource.FurnitureSortTypeEnum;

    public class ResourceManager implements IResourceManager 
    {

        private var _resourceVOCollection:Dictionary = new Dictionary();
        private var _puffleItemVOCollection:Bag;

        public function ResourceManager():void
        {
            this.init();
        }

        private function init():void
        {
            this._resourceVOCollection[ResourceTypeEnum.CLOTHING] = new Bag(ClothingVO);
            this._resourceVOCollection[ResourceTypeEnum.FURNITURE] = new Bag(FurnitureVO);
        }

        public function getResourceVO(_arg_1:ResourceTypeEnum, id:int):ResourceVO
        {
            return (ResourceVO(Bag(this._resourceVOCollection[_arg_1]).getItem(id)));
        }

        public function setPuffleCareItemCollection(puffleItemVOCollection:Bag):void
        {
            this._puffleItemVOCollection = puffleItemVOCollection;
        }

        public function getPuffleCareItemCollection():Bag
        {
            return (this._puffleItemVOCollection);
        }

        public function setClothingData(data:Object, environmentData:EnvironmentDataVO, pathsVO:PathsVO):void
        {
            var item:Object;
            var clothingVO:ClothingVO;
            var typeIndex:int;
            for each (item in data)
            {
                clothingVO = new ClothingVO();
                typeIndex = (int(item.type) - 1);
                clothingVO.id = int(item.paper_item_id);
                clothingVO.type = ClothingTypeEnum.getClothingTypeEnumByIndex(typeIndex);
                clothingVO.cost = int(item.cost);
                clothingVO.isMember = Boolean(item.is_member);
                clothingVO.localizedName = String(item.prompt);
                clothingVO.filePath = new Dictionary();
                clothingVO.filePath[ResourceVO.FILE_TYPE_ICONS] = ((pathsVO.getGlobalPath("clothing_icons") + clothingVO.id) + ".swf");
                clothingVO.filePath[ResourceVO.FILE_TYPE_PAPER] = ((pathsVO.getGlobalPath("clothing_paper") + clothingVO.id) + ".swf");
                clothingVO.filePath[ResourceVO.FILE_TYPE_PHOTOS] = ((pathsVO.getGlobalPath("clothing_photos") + clothingVO.id) + ".swf");
                clothingVO.filePath[ResourceVO.FILE_TYPE_SPRITES] = ((pathsVO.getGlobalPath("clothing_sprites") + clothingVO.id) + ".swf");
                Bag(this._resourceVOCollection[ResourceTypeEnum.CLOTHING]).add(clothingVO);
            };
        }

        public function setFurnitureData(data:Object, environmentData:EnvironmentDataVO, pathsVO:PathsVO):void
        {
            var item:Object;
            var furnitureVO:FurnitureVO;
            var typeIndex:int;
            var sortIndex:int;
            for each (item in data)
            {
                furnitureVO = new FurnitureVO();
                typeIndex = (int(item.type) - 1);
                sortIndex = (int(item.sort) - 1);
                furnitureVO.id = int(item.furniture_item_id);
                furnitureVO.type = FurnitureTypeEnum.getFurnitureTypeEnumByIndex(typeIndex);
                furnitureVO.sortType = FurnitureSortTypeEnum.getFurnitureSortEnumByIndex(sortIndex);
                furnitureVO.cost = int(item.cost);
                furnitureVO.isMember = (int(item.is_member_only) == 1);
                furnitureVO.localizedName = String(item.prompt);
                furnitureVO.filePath = new Dictionary();
                furnitureVO.filePath[ResourceVO.FILE_TYPE_ICONS] = ((pathsVO.getGlobalPath("furniture_icons") + furnitureVO.id) + ".swf");
                furnitureVO.filePath[ResourceVO.FILE_TYPE_SPRITES] = ((pathsVO.getGlobalPath("furniture_sprites") + furnitureVO.id) + ".swf");
                Bag(this._resourceVOCollection[ResourceTypeEnum.FURNITURE]).add(furnitureVO);
            };
        }


    }
}//package com.clubpenguin.managers.resource
