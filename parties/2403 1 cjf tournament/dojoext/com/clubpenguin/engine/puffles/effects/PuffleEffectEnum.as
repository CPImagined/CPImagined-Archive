//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.puffles.effects.PuffleEffectEnum
    {
        var _assetPath, _layeringType, _effectTypeId;
        function PuffleEffectEnum (assetPath, layeringType, effectTypeId) {
            _assetPath = assetPath;
            _layeringType = layeringType;
            _effectTypeId = effectTypeId;
            PUFFLE_EFFECT_ENUMS_LIST.push(this);
        }
        function getAssetPath() {
            return(_assetPath);
        }
        function getLayeringType() {
            return(_layeringType);
        }
        function getEffectTypeId() {
            return(_effectTypeId);
        }
        static function getPuffleEffectByTypeId(typeId) {
            var _local_1 = 0;
            while (_local_1 < PUFFLE_EFFECT_ENUMS_LIST.length) {
                if (typeId == PUFFLE_EFFECT_ENUMS_LIST[_local_1].getEffectTypeId()) {
                    return(PUFFLE_EFFECT_ENUMS_LIST[_local_1]);
                }
                _local_1++;
            }
            return(null);
        }
        static var GOLD_STATE_ASSET_PATH = "w.puffle.effects.goldstate";
        static var WATER_SPLASH_ASSET_PATH = "";
        static var PUFFLE_EFFECT_ENUMS_LIST = new Array();
        static var HAS_FRONT_ASSET = 0;
        static var HAS_BACK_ASSET = 1;
        static var HAS_BOTH_ASSETS = 2;
        static var NO_EFFECT = new com.clubpenguin.engine.puffles.effects.PuffleEffectEnum("", null, 0);
        static var GOLD_STATE = new com.clubpenguin.engine.puffles.effects.PuffleEffectEnum(GOLD_STATE_ASSET_PATH, HAS_BOTH_ASSETS, 1);
        static var WATER_SPLASH_EFFECT = new com.clubpenguin.engine.puffles.effects.PuffleEffectEnum(WATER_SPLASH_ASSET_PATH, HAS_BOTH_ASSETS, 2);
    }
