class com.clubpenguin.engine.puffles.effects.PuffleEffectEnum
{
    var _assetPath, _layeringType, _effectTypeId;
    function PuffleEffectEnum(assetPath, layeringType, effectTypeId)
    {
        _assetPath = assetPath;
        _layeringType = layeringType;
        _effectTypeId = effectTypeId;
        com.clubpenguin.engine.puffles.effects.PuffleEffectEnum.PUFFLE_EFFECT_ENUMS_LIST.push(this);
    } // End of the function
    function getAssetPath()
    {
        return (_assetPath);
    } // End of the function
    function getLayeringType()
    {
        return (_layeringType);
    } // End of the function
    function getEffectTypeId()
    {
        return (_effectTypeId);
    } // End of the function
    static function getPuffleEffectByTypeId(typeId)
    {
        for (var _loc1 = 0; _loc1 < com.clubpenguin.engine.puffles.effects.PuffleEffectEnum.PUFFLE_EFFECT_ENUMS_LIST.length; ++_loc1)
        {
            if (typeId == com.clubpenguin.engine.puffles.effects.PuffleEffectEnum.PUFFLE_EFFECT_ENUMS_LIST[_loc1].getEffectTypeId())
            {
                return (com.clubpenguin.engine.puffles.effects.PuffleEffectEnum.PUFFLE_EFFECT_ENUMS_LIST[_loc1]);
            } // end if
        } // end of for
        return (null);
    } // End of the function
    static var GOLD_STATE_ASSET_PATH = "w.puffle.effects.goldstate";
    static var WATER_SPLASH_ASSET_PATH = "";
    static var PUFFLE_EFFECT_ENUMS_LIST = new Array();
    static var HAS_FRONT_ASSET = 0;
    static var HAS_BACK_ASSET = 1;
    static var HAS_BOTH_ASSETS = 2;
    static var NO_EFFECT = new com.clubpenguin.engine.puffles.effects.PuffleEffectEnum("", null, 0);
    static var GOLD_STATE = new com.clubpenguin.engine.puffles.effects.PuffleEffectEnum(com.clubpenguin.engine.puffles.effects.PuffleEffectEnum.GOLD_STATE_ASSET_PATH, com.clubpenguin.engine.puffles.effects.PuffleEffectEnum.HAS_BOTH_ASSETS, 1);
    static var WATER_SPLASH_EFFECT = new com.clubpenguin.engine.puffles.effects.PuffleEffectEnum(com.clubpenguin.engine.puffles.effects.PuffleEffectEnum.WATER_SPLASH_ASSET_PATH, com.clubpenguin.engine.puffles.effects.PuffleEffectEnum.HAS_BOTH_ASSETS, 2);
} // End of Class
