//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.enums.resource
{
    import com.clubpenguin.lib.enums.Enum;
    import com.clubpenguin.lib.util.StringUtils;

    public class CacheTypeEnum extends Enum 
    {

        public static const CLIENT:CacheTypeEnum = new CacheTypeEnum("client", "clientVersion");
        public static const CONTENT:CacheTypeEnum = new CacheTypeEnum("content", "contentVersion");
        public static const MINIGAME:CacheTypeEnum = new CacheTypeEnum("games", "minigameVersion");
        public static const CONFIG:CacheTypeEnum = new CacheTypeEnum("config", "configVersion");
        public static const CACHE_TYPE_ENUM_LIST:Array = Enum.createList(CacheTypeEnum);

        public var type:String;
        public var stringType:String;
        public var cacheValue:String;

        public function CacheTypeEnum(_arg_1:String, stringType:String, cacheValue:String="")
        {
            this.type = _arg_1;
            this.stringType = stringType;
            this.cacheValue = cacheValue;
        }

        public static function getCacheTypeByType(cacheType:String):CacheTypeEnum
        {
            var i:int;
            while (i < CACHE_TYPE_ENUM_LIST.length)
            {
                if (CacheTypeEnum(CACHE_TYPE_ENUM_LIST[i]).type == cacheType)
                {
                    return (CacheTypeEnum(CACHE_TYPE_ENUM_LIST[i]));
                };
                i++;
            };
            return (null);
        }

        public static function getCacheAsStringByType(cacheType:String):String
        {
            var i:int;
            while (i < CACHE_TYPE_ENUM_LIST.length)
            {
                if (CacheTypeEnum(CACHE_TYPE_ENUM_LIST[i]).type == cacheType)
                {
                    return ((CacheTypeEnum(CACHE_TYPE_ENUM_LIST[i]).cacheValue == "") ? "" : ((("?" + CacheTypeEnum(CACHE_TYPE_ENUM_LIST[i]).stringType) + "=") + CacheTypeEnum(CACHE_TYPE_ENUM_LIST[i]).cacheValue));
                };
                i++;
            };
            return ("");
        }


        public function toString():String
        {
            return (StringUtils.classVariablesDescription(this));
        }


    }
}//package com.clubpenguin.lib.enums.resource
