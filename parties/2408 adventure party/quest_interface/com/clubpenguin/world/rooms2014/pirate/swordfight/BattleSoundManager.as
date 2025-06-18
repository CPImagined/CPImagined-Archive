//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.pirate.swordfight.BattleSoundManager
    {
        var _layers, _target, _defaultLayer;
        function BattleSoundManager (target) {
            _layers = new Array();
            _target = target;
            _defaultLayer = new com.clubpenguin.world.rooms2014.pirate.swordfight.SoundLayer("default", -1);
            addLayer(LAYER_POINTS_AWARDED, 1);
            addLayer(LAYER_TRANSFORM, 2);
            addLayer(LAYER_LIGHT_SABER, 3);
        }
        function addLayer(layerName, maxConcurrent) {
            if (getLayer(layerName) == null) {
                _layers.push(new com.clubpenguin.world.rooms2014.pirate.swordfight.SoundLayer(layerName, maxConcurrent));
            }
        }
        function removeLayer(layerName) {
            var _local_2 = 0;
            while (_local_2 < _layers.length) {
                if (_layers[_local_2].name == layerName) {
                    _layers = _layers.splice(_local_2, 1);
                }
                _local_2++;
            }
        }
        function getLayer(layerName) {
            var _local_2 = 0;
            while (_local_2 < _layers.length) {
                if (_layers[_local_2].name == layerName) {
                    return(_layers[_local_2]);
                }
                _local_2++;
            }
            return(null);
        }
        function playSound(symbolName, layerName) {
            var _local_2 = getLayer(layerName);
            if (_local_2 == null) {
                _local_2 = _defaultLayer;
            }
            if (_local_2.canPlaySound()) {
                var _local_5 = _target.getNextHighestDepth();
                var _local_4 = _target.createEmptyMovieClip("symbolName_" + _local_5, _local_5);
                var _local_3 = new Sound(_local_4);
                _local_3.attachSound(symbolName);
                if (_local_3.duration != undefined) {
                    _local_2.numSoundsPlaying++;
                    _local_3.onSoundComplete = com.clubpenguin.util.Delegate.create(this, onSoundComplete, _local_3, _local_2, _local_4);
                    _local_3.start(0, 1);
                }
            }
        }
        function onSoundComplete(sfx, layer, targetHolder) {
            targetHolder.removeMovieClip();
            layer.numSoundsPlaying--;
            if (layer.numSoundsPlaying < 0) {
                layer.numSoundsPlaying = 0;
            }
        }
        static var LAYER_POINTS_AWARDED = "battle_point_awarded";
        static var LAYER_TRANSFORM = "battle_transform";
        static var LAYER_LIGHT_SABER = "battle_light_saber";
        static var SFX_TRANSFORM_START = "sfx_sw_battle_transform_start";
        static var SFX_TRANSFORM_END = "sfx_sw_battle_transform_end";
        static var SFX_POINTS_AWARDED = "sfx_sw_battle_points";
        static var SFX_LIGHT_SABER_FINAL_HIT = "sfx_sw_battle_final_hit";
        static var SFX_LIGHT_SABER_HIT_1 = "sfx_sw_battle_hit_1";
        static var SFX_LIGHT_SABER_HIT_2 = "sfx_sw_battle_hit_2";
        static var SFX_LIGHT_SABER_HIT_3 = "sfx_sw_battle_hit_3";
        static var SFX_ATTACK_SELECT = "sfx_sw_battle_attack_select";
    }
