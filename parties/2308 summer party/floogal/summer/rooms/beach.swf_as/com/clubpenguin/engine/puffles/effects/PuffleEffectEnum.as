dynamic class com.clubpenguin.engine.puffles.effects.PuffleEffectEnum
{
    static var GOLD_STATE_ASSET_PATH: String = "w.puffle.effects.goldstate";
    static var WATER_SPLASH_ASSET_PATH: String = "";
    static var PUFFLE_EFFECT_ENUMS_LIST = new Array();
    static var HAS_FRONT_ASSET: Number = 0;
    static var HAS_BACK_ASSET: Number = 1;
    static var HAS_BOTH_ASSETS: Number = 2;
    static var NO_EFFECT = new com.clubpenguin.engine.puffles.effects.PuffleEffectEnum("", null, 0);
    static var GOLD_STATE = new com.clubpenguin.engine.puffles.effects.PuffleEffectEnum(com.clubpenguin.engine.puffles.effects.PuffleEffectEnum.GOLD_STATE_ASSET_PATH, com.clubpenguin.engine.puffles.effects.PuffleEffectEnum.HAS_BOTH_ASSETS, 1);
    static var WATER_SPLASH_EFFECT = new com.clubpenguin.engine.puffles.effects.PuffleEffectEnum(com.clubpenguin.engine.puffles.effects.PuffleEffectEnum.WATER_SPLASH_ASSET_PATH, com.clubpenguin.engine.puffles.effects.PuffleEffectEnum.HAS_BOTH_ASSETS, 2);
    var _assetPath;
    var _effectTypeId;
    var _layeringType;

    function PuffleEffectEnum(assetPath, layeringType, effectTypeId)
    {
        this._assetPath = assetPath;
        this._layeringType = layeringType;
        this._effectTypeId = effectTypeId;
        com.clubpenguin.engine.puffles.effects.PuffleEffectEnum.PUFFLE_EFFECT_ENUMS_LIST.push(this);
    }

    function getAssetPath()
    {
        return this._assetPath;
    }

    function getLayeringType()
    {
        return this._layeringType;
    }

    function getEffectTypeId()
    {
        return this._effectTypeId;
    }

    static function getPuffleEffectByTypeId(typeId)
    {
        var __reg1 = 0;
        while (__reg1 < com.clubpenguin.engine.puffles.effects.PuffleEffectEnum.PUFFLE_EFFECT_ENUMS_LIST.length) 
        {
            if (typeId == com.clubpenguin.engine.puffles.effects.PuffleEffectEnum.PUFFLE_EFFECT_ENUMS_LIST[__reg1].getEffectTypeId()) 
            {
                return com.clubpenguin.engine.puffles.effects.PuffleEffectEnum.PUFFLE_EFFECT_ENUMS_LIST[__reg1];
            }
            ++__reg1;
        }
        return null;
    }

}
