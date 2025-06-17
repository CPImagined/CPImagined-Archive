//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.vo.resource
{
    import com.clubpenguin.lib.vo.IVO;
    import flash.utils.Dictionary;
    import com.clubpenguin.lib.util.StringUtils;

    public class ResourceVO implements IVO 
    {

        public static const FILE_TYPE_ICONS:String = "icons";
        public static const FILE_TYPE_SPRITES:String = "sprites";
        public static const FILE_TYPE_PHOTOS:String = "photos";
        public static const FILE_TYPE_PAPER:String = "paper";

        public var localizedName:String;
        public var filePath:Dictionary;
        public var cost:int;
        public var isMember:Boolean;
        private var _id:int;


        public function set id(value:int):void
        {
            this._id = value;
        }

        public function get id():int
        {
            return (this._id);
        }

        public function destroy():void
        {
        }

        public function update(vo:IVO):void
        {
        }

        public function equals(vo:IVO):Boolean
        {
            return (this._id == vo.id);
        }

        public function toString():String
        {
            return (StringUtils.classVariablesDescription(this));
        }


    }
}//package com.clubpenguin.lib.vo.resource
