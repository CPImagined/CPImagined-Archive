//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager
    {
        var background_mc, __get__checkInterval, _currentColorState, _colorFireState, _colorWaterState, _colorSnowState, _colorTieState, _colorDefaultState, _currentColorMode, _nextColorMode, _colorModeA, _colorModeB, _colorModeC, _currentShadowState, _shadowFireState, _shadowWaterState, _shadowSnowState, _shadowTieState, _shadowDefaultState, _shadowEmptyState, _currentShadowMode, _nextShadowMode, _shadowModeA, _shadowModeB, _shadowModeC;
        function WeatherEffectsManager (shell, background) {
            trace("WeatherEffectsManager()");
            SHELL = shell;
            background_mc = background;
            com.greensock.plugins.TweenPlugin.activate([com.greensock.plugins.ColorTransformPlugin]);
            setDefaultTintValues(2, EFFECT_TYPE_DEFAULT);
        }
        function getDancingFirePlayers() {
            return(_dancingFirePlayers);
        }
        function getDancingWaterPlayers() {
            return(_dancingWaterPlayers);
        }
        function getDancingSnowPlayers() {
            return(_dancingSnowPlayers);
        }
        function getDancingShadowPlayers() {
            return(_dancingShadowPlayers);
        }
        function set checkInterval(interval) {
            _checkInterval = interval;
            //return(__get__checkInterval());
        }
        function get fireAnimationHeight() {
            return(_fireAnimationHeight);
        }
        function get fireAnimationSpeed() {
            return(_fireAnimationSpeed);
        }
        function get fireAmount() {
            return(_fireAmount);
        }
        function get fireShrinkSize() {
            return(_fireShrinkSize);
        }
        function get fireDelayTime() {
            return(_fireDelayTime);
        }
        function get rainAnimationHeight() {
            return(_rainAnimationHeight);
        }
        function get rainAnimationSpeed() {
            return(_rainAnimationSpeed);
        }
        function get rainAmount() {
            return(_rainAmount);
        }
        function get rainShrinkSize() {
            return(_rainShrinkSize);
        }
        function get rainFadeAmount() {
            return(_rainFadeAmount);
        }
        function get rainDelayTime() {
            return(_rainDelayTime);
        }
        function get rainRotation() {
            return(_rainRotation);
        }
        function get snowAnimationHeight() {
            return(_snowAnimationHeight);
        }
        function get snowAnimationSpeed() {
            return(_snowAnimationSpeed);
        }
        function get snowAmount() {
            return(_snowAmount);
        }
        function get snowShrinkSize() {
            return(_snowShrinkSize);
        }
        function get snowFadeAmount() {
            return(_snowFadeAmount);
        }
        function get snowDelayTime() {
            return(_snowDelayTime);
        }
        function get currentColorState() {
            return(_currentColorState);
        }
        function get colorFireState() {
            return(_colorFireState);
        }
        function get colorWaterState() {
            return(_colorWaterState);
        }
        function get colorSnowState() {
            return(_colorSnowState);
        }
        function get colorTieState() {
            return(_colorTieState);
        }
        function get colorDefaultState() {
            return(_colorDefaultState);
        }
        function get currentColorMode() {
            return(_currentColorMode);
        }
        function set currentColorMode(mode) {
            _currentColorMode = mode;
            //return(currentColorMode);
        }
        function get nextColorMode() {
            return(_nextColorMode);
        }
        function get colorModeA() {
            return(_colorModeA);
        }
        function get colorModeB() {
            return(_colorModeB);
        }
        function get colorModeC() {
            return(_colorModeC);
        }
        function get currentShadowState() {
            return(_currentShadowState);
        }
        function get shadowFireState() {
            return(_shadowFireState);
        }
        function get shadowWaterState() {
            return(_shadowWaterState);
        }
        function get shadowSnowState() {
            return(_shadowSnowState);
        }
        function get shadowTieState() {
            return(_shadowTieState);
        }
        function get shadowDefaultState() {
            return(_shadowDefaultState);
        }
        function get shadowEmptyState() {
            return(_shadowEmptyState);
        }
        function get currentShadowMode() {
            return(_currentShadowMode);
        }
        function set currentShadowMode(mode) {
            _currentShadowMode = mode;
            //return(currentShadowMode);
        }
        function get nextShadowMode() {
            return(_nextShadowMode);
        }
        function get shadowModeA() {
            return(_shadowModeA);
        }
        function get shadowModeB() {
            return(_shadowModeB);
        }
        function get shadowModeC() {
            return(_shadowModeC);
        }
        function startWeatherEffectCheck() {
            initStates();
            _intervalId = setInterval(com.clubpenguin.util.Delegate.create(this, checkOutfitandSpecialDance), _checkInterval);
        }
        function stopWeatherEffectCheck() {
            clearInterval(_intervalId);
            _intervalId = -1;
        }
        function initialize(fireAnimationHeight, fireAnimationSpeed, fireAmount, fireDelayTime, rainAnimationHeight, rainAmount, rainShrinkSize, rainFadeAmount, rainDelayTime, rainRotation, snowAnimationHeight, snowAmount, snowShrinkSize, snowFadeAmount, snowDelayTime) {
            setupFireAnimationHeight(fireAnimationHeight);
            setupFireAnimationSpeed(fireAnimationSpeed);
            setupFireAmount(fireAmount);
            setupFireDelayTime(fireDelayTime);
            setupRainAnimationHeight(rainAnimationHeight);
            setupRainAmount(rainAmount);
            setupRainShrinkSize(rainShrinkSize);
            setupRainFadeAmount(rainFadeAmount);
            setupRainDelayTime(rainDelayTime);
            setupRainRotation(rainRotation);
            setupSnowAnimationHeight(snowAnimationHeight);
            setupSnowAmount(snowAmount);
            setupSnowShrinkSize(snowShrinkSize);
            setupSnowFadeAmount(snowFadeAmount);
            setupSnowDelayTime(snowDelayTime);
        }
        function setupIntervalCheck(interval) {
            _checkInterval = interval;
        }
        function setupFireAnimationHeight(height) {
            _fireAnimationHeight = height;
        }
        function setupFireAnimationSpeed(speed) {
            _fireAnimationSpeed = speed;
        }
        function setupFireAmount(amount) {
            _fireAmount = amount;
        }
        function setupFireDelayTime(delay) {
            _fireDelayTime = delay;
        }
        function setupRainAnimationHeight(height) {
            _rainAnimationHeight = height;
        }
        function setupRainAnimationSpeed(speed) {
            _rainAnimationSpeed = speed;
        }
        function setupRainAmount(amount) {
            _rainAmount = amount;
        }
        function setupRainShrinkSize(shrinkSize) {
            _rainShrinkSize = shrinkSize;
        }
        function setupRainFadeAmount(rainFadeAmount) {
            _rainFadeAmount = rainFadeAmount;
        }
        function setupRainDelayTime(delay) {
            _rainDelayTime = delay;
        }
        function setupRainRotation(rotation) {
            _rainRotation = rotation;
        }
        function setupSnowAnimationHeight(height) {
            _snowAnimationHeight = height;
        }
        function setupSnowAnimationSpeed(speed) {
            _snowAnimationSpeed = speed;
        }
        function setupSnowAmount(amount) {
            _snowAmount = amount;
        }
        function setupSnowShrinkSize(shrinkSize) {
            _snowShrinkSize = shrinkSize;
        }
        function getBackogrundMC() {
            return(background_mc);
        }
        function setupSnowFadeAmount(snowFadeAmount) {
            _snowFadeAmount = snowFadeAmount;
        }
        function setupSnowDelayTime(snowDelayTime) {
            _snowDelayTime = snowDelayTime;
        }
        function playWeatherEffect(effectType) {
            _currentColorState.playWeatherEffect(effectType);
        }
        function set currentColorState(state) {
            _currentColorState = state;
            _currentColorMode = _nextColorMode;
            _currentColorState.applyState();
            //return(currentColorState);
        }
        function initStates() {
            _colorFireState = new com.clubpenguin.world.rooms.weathereffects.state["color"].ColorFireState(this);
            _colorWaterState = new com.clubpenguin.world.rooms.weathereffects.state["color"].ColorWaterState(this);
            _colorSnowState = new com.clubpenguin.world.rooms.weathereffects.state["color"].ColorSnowState(this);
            _colorTieState = new com.clubpenguin.world.rooms.weathereffects.state["color"].ColorTieState(this);
            _colorDefaultState = new com.clubpenguin.world.rooms.weathereffects.state["color"].ColorDefaultState(this);
            _colorModeA = new com.clubpenguin.world.rooms.weathereffects.state.mode.ModeA();
            _colorModeB = new com.clubpenguin.world.rooms.weathereffects.state.mode.ModeB();
            _colorModeC = new com.clubpenguin.world.rooms.weathereffects.state.mode.ModeC();
            _currentColorMode = (_nextColorMode = _colorModeA);
            _currentColorState = _colorDefaultState;
            _shadowFireState = new com.clubpenguin.world.rooms.weathereffects.state.shadow.ShadowFireState(this);
            _shadowWaterState = new com.clubpenguin.world.rooms.weathereffects.state.shadow.ShadowWaterState(this);
            _shadowSnowState = new com.clubpenguin.world.rooms.weathereffects.state.shadow.ShadowSnowState(this);
            _shadowTieState = new com.clubpenguin.world.rooms.weathereffects.state.shadow.ShadowTieState(this);
            _shadowDefaultState = new com.clubpenguin.world.rooms.weathereffects.state.shadow.ShadowDefaultState(this);
            _shadowEmptyState = new com.clubpenguin.world.rooms.weathereffects.state.shadow.ShadowEmptyState(this);
            _shadowModeA = new com.clubpenguin.world.rooms.weathereffects.state.mode.ModeA();
            _shadowModeB = new com.clubpenguin.world.rooms.weathereffects.state.mode.ModeB();
            _shadowModeC = new com.clubpenguin.world.rooms.weathereffects.state.mode.ModeC();
            _currentShadowMode = (_nextShadowMode = _shadowModeA);
            _currentShadowState = _shadowEmptyState;
        }
        function determineColorMode(numberOfUsers) {
            if (numberOfUsers <= 2) {
                return(_colorModeA);
            }
            if (numberOfUsers == 3) {
                return(_colorModeB);
            }
            if (numberOfUsers >= 4) {
                return(_colorModeC);
            }
            return(_colorModeA);
        }
        function set currentShadowState(state) {
            _currentShadowState = state;
            _currentShadowMode = _nextShadowMode;
            _currentShadowState.applyState();
            //return(currentShadowState);
        }
        function determineShadowMode(numberOfUsers) {
            if (numberOfUsers <= 2) {
                return(_shadowModeA);
            }
            if (numberOfUsers == 3) {
                return(_shadowModeB);
            }
            if (numberOfUsers >= 4) {
                return(_shadowModeC);
            }
            return(_shadowModeA);
        }
        function determineShadowState() {
            switch (_currentColorState) {
                case _colorFireState : 
                    _currentShadowState.toFireState();
                    break;
                case _colorWaterState : 
                    _currentShadowState.toWaterState();
                    break;
                case _colorSnowState : 
                    _currentShadowState.toSnowState();
                    break;
                case _colorTieState : 
                    _currentShadowState.toTieState();
                    break;
                case _colorDefaultState : 
                    _currentShadowState.toDefaultState();
                    break;
            }
        }
        function checkOutfitandSpecialDance() {
            _dancingFirePlayers = 0;
            _dancingWaterPlayers = 0;
            _dancingSnowPlayers = 0;
            _dancingShadowPlayers = 0;
            var _local_3 = 0;
            while (_local_3 < SHELL.getPlayerList().length) {
                var _local_2 = SHELL.getPlayerList()[_local_3];
                if (isWearingFireOutfit(_local_2) && (isDoingSpecialDance(_local_2))) {
                    _dancingFirePlayers++;
                }
                if (isWearingWaterOutfit(_local_2) && (isDoingSpecialDance(_local_2))) {
                    _dancingWaterPlayers++;
                }
                if (isWearingSnowOutfit(_local_2) && (isDoingSpecialDance(_local_2))) {
                    _dancingSnowPlayers++;
                }
                if (isWearingShadowOutfit(_local_2) && (isDoingSpecialDance(_local_2))) {
                    _dancingShadowPlayers++;
                }
                _local_3++;
            }
            if (SHELL.getPlayerList().length < 2) {
                resetToDefaultValues();
                _nextShadowMode = determineShadowMode(_dancingShadowPlayers);
                _currentShadowState.toEmptyState();
                return(undefined);
            }
            determinePlayableWeatherEffects();
        }
        function determinePlayableWeatherEffects() {
            _playFireEffect = false;
            _playWaterEffect = false;
            _playSnowEffect = false;
            _playShadowEffect = false;
            if (_dancingFirePlayers >= 2) {
                _playFireEffect = true;
            }
            if (_dancingWaterPlayers >= 2) {
                _playWaterEffect = true;
            }
            if (_dancingSnowPlayers >= 2) {
                _playSnowEffect = true;
            }
            if (_dancingShadowPlayers >= 2) {
                _playShadowEffect = true;
            }
            if (_dancingWaterPlayers >= _dancingFirePlayers) {
                _playFireEffect = false;
            }
            if (_dancingFirePlayers >= _dancingSnowPlayers) {
                _playSnowEffect = false;
            }
            if (_dancingSnowPlayers >= _dancingWaterPlayers) {
                _playWaterEffect = false;
            }
            if (_dancingWaterPlayers < _dancingFirePlayers) {
                _playWaterEffect = false;
            }
            if (_dancingSnowPlayers < _dancingWaterPlayers) {
                _playSnowEffect = false;
            }
            if (_dancingFirePlayers < _dancingSnowPlayers) {
                _playFireEffect = false;
            }
            if (((_dancingFirePlayers >= 2) && (_dancingFirePlayers == _dancingWaterPlayers)) && (_dancingFirePlayers == _dancingSnowPlayers)) {
                _playFireEffect = true;
                _playWaterEffect = true;
                _playSnowEffect = true;
            }
            if ((_playFireEffect || (_playWaterEffect)) || (_playSnowEffect)) {
                determineWhichStateShouldBePlayed();
            } else {
                resetToDefaultValues();
            }
            if (_playShadowEffect) {
                determineWhichShadowStateShouldBePlayed();
            }
            if (!_playShadowEffect) {
                _nextShadowMode = determineShadowMode(_dancingShadowPlayers);
                if ((_nextShadowMode != _currentShadowMode) || (_currentShadowState != _shadowEmptyState)) {
                    trace("RESET SHADOW");
                    _currentShadowState.toEmptyState();
                }
            }
        }
        function determineWhichStateShouldBePlayed() {
            if (!_playShadowEffect) {
                _nextShadowMode = determineShadowMode(_dancingShadowPlayers);
                if ((_nextShadowMode != _currentShadowMode) || (_currentShadowState != _shadowEmptyState)) {
                    trace("RESET SHADOW");
                    _currentShadowState.toEmptyState();
                }
            }
            if ((_playFireEffect && (_playWaterEffect)) && (_playSnowEffect)) {
                _nextColorMode = determineColorMode(_dancingFirePlayers);
                _currentColorState.toTieState();
                if (_playShadowEffect) {
                    determineWhichShadowStateShouldBePlayed();
                }
                return(undefined);
            }
            if (_playFireEffect) {
                _nextColorMode = determineColorMode(_dancingFirePlayers);
                _currentColorState.toFireState();
                if (_playShadowEffect) {
                    determineWhichShadowStateShouldBePlayed();
                }
                return(undefined);
            }
            if (_playWaterEffect) {
                _nextColorMode = determineColorMode(_dancingWaterPlayers);
                _currentColorState.toWaterState();
                if (_playShadowEffect) {
                    determineWhichShadowStateShouldBePlayed();
                }
                return(undefined);
            }
            if (_playSnowEffect) {
                _nextColorMode = determineColorMode(_dancingSnowPlayers);
                _currentColorState.toSnowState();
                if (_playShadowEffect) {
                    determineWhichShadowStateShouldBePlayed();
                }
                return(undefined);
            }
            if (((!_playFireEffect) && (!_playWaterEffect)) && (!_playSnowEffect)) {
                resetToDefaultValues();
            }
        }
        function determineWhichShadowStateShouldBePlayed() {
            trace("DETERMINING WHICH SHADOW STATE SHOULD BE PLAYED");
            _nextShadowMode = determineShadowMode(_dancingShadowPlayers);
            if (_playShadowEffect) {
                determineShadowState();
                return(undefined);
            }
            _currentShadowState.toEmptyState();
        }
        function setDefaultTintValues(numOfPlayers, effectType) {
            var _local_2 = new Object();
            _local_2.tintType = (_playShadowEffect ? "shadow" : "color");
            _local_2.state = "Mode" + (((numOfPlayers - 1) > 2) ? "C" : ((((numOfPlayers - 1) == 2) ? "B" : "A")));
            _local_2.effectType = effectType;
            _local_2.stateForSettings = "Mode" + ((numOfPlayers > 2) ? "B" : "A");
            if ((effectType == EFFECT_TYPE_DEFAULT) && (!_playShadowEffect)) {
                _local_2.state = "ModeA";
            }
            _local_2.sky = com.clubpenguin.world.rooms.weathereffects.WeatherEffectsSettings[((_local_2.tintType + effectType) + OBJECT_TYPE_SKY) + _local_2.stateForSettings];
            _local_2.clouds = com.clubpenguin.world.rooms.weathereffects.WeatherEffectsSettings[((_local_2.tintType + effectType) + OBJECT_TYPE_CLOUDS) + _local_2.stateForSettings];
            _local_2.distantObjects = com.clubpenguin.world.rooms.weathereffects.WeatherEffectsSettings[((_local_2.tintType + effectType) + OBJECT_TYPE_DISTANT_OBJ) + _local_2.stateForSettings];
            _local_2.topCoulds = com.clubpenguin.world.rooms.weathereffects.WeatherEffectsSettings[((_local_2.tintType + effectType) + OBJECT_TYPE_TOP_CLOUDS) + _local_2.stateForSettings];
            com.greensock.TweenMax.to(background_mc.weatherEffects_mc.bgSky.bgSkyShadow.bgSkyColor, 0, {colorTransform:_local_2.sky});
        }
        function resetToDefaultValues() {
            if (_currentColorState == _colorDefaultState) {
                return(undefined);
            }
            _nextColorMode = determineColorMode(0);
            _currentColorState.toDefaultState();
        }
        function isWearingFireOutfit(player) {
            if (player.head != _FIRE_NINJA_HEAD_ITEM_ID) {
                return(false);
            }
            if (player.face != _FIRE_NINJA_FACE_ITEM_ID) {
                return(false);
            }
            if (player.body != _FIRE_NINJA_BODY_ITEM_ID) {
                return(false);
            }
            if (player.feet != _FIRE_NINJA_FEET_ITEM_ID) {
                return(false);
            }
            return(true);
        }
        function isWearingWaterOutfit(player) {
            if (player.head != _WATER_NINJA_HEAD_ITEM_ID) {
                return(false);
            }
            if (player.face != _WATER_NINJA_FACE_ITEM_ID) {
                return(false);
            }
            if (player.body != _WATER_NINJA_BODY_ITEM_ID) {
                return(false);
            }
            if (player.feet != _WATER_NINJA_FEET_ITEM_ID) {
                return(false);
            }
            return(true);
        }
        function isWearingSnowOutfit(player) {
            if (player.head != _SNOW_NINJA_HEAD_ITEM_ID) {
                return(false);
            }
            if (player.face != _SNOW_NINJA_FACE_ITEM_ID) {
                return(false);
            }
            if (player.body != _SNOW_NINJA_BODY_ITEM_ID) {
                return(false);
            }
            if (player.feet != _SNOW_NINJA_FEET_ITEM_ID) {
                return(false);
            }
            return(true);
        }
        function isWearingShadowOutfit(player) {
            if (player.head != _SHADOW_NINJA_HEAD_ITEM_ID) {
                return(false);
            }
            if (player.face != _SHADOW_NINJA_FACE_ITEM_ID) {
                return(false);
            }
            if (player.body != _SHADOW_NINJA_BODY_ITEM_ID) {
                return(false);
            }
            if (player.feet != _SHADOW_NINJA_FEET_ITEM_ID) {
                return(false);
            }
            return(true);
        }
        function isDoingSpecialDance(player) {
            var _local_3 = SHELL.getSecretFrame(player.player_id, player.frame);
            if ((player.frame == _SPECIAL_DANCE_FRAME) && (player.frame != _local_3)) {
                return(true);
            }
            return(false);
        }
        function traceCurrentRoomStatus() {
            trace("=====================================");
            trace("FIRE DANCERS   " + _dancingFirePlayers);
            trace("WATER DANCERS  " + _dancingWaterPlayers);
            trace("SNOW DANCERS   " + _dancingSnowPlayers);
            trace("SHADOW DANCERS " + _dancingShadowPlayers);
            trace("PLAY FIRE EFFECT:   " + _playFireEffect);
            trace("PLAY WATER EFFECT:  " + _playWaterEffect);
            trace("PLAY SNOW EFFECT:   " + _playSnowEffect);
            trace("PLAY SHADOW EFFECT: " + _playShadowEffect);
            trace("===========================");
        }
        function destroy() {
            trace("WeatherEffectsManager -> destroy()");
            stopWeatherEffectCheck();
        }
        var SHELL = undefined;
        static var _NECK_AMULET_ID = 3032;
        static var _SPECIAL_DANCE_FRAME = 26;
        static var _FIRE_NINJA_HEAD_ITEM_ID = 1086;
        static var _FIRE_NINJA_FACE_ITEM_ID = 2013;
        static var _FIRE_NINJA_BODY_ITEM_ID = 4120;
        static var _FIRE_NINJA_FEET_ITEM_ID = 6025;
        static var _WATER_NINJA_HEAD_ITEM_ID = 1087;
        static var _WATER_NINJA_FACE_ITEM_ID = 2025;
        static var _WATER_NINJA_BODY_ITEM_ID = 4121;
        static var _WATER_NINJA_FEET_ITEM_ID = 6026;
        static var _SNOW_NINJA_HEAD_ITEM_ID = -1;
        static var _SNOW_NINJA_FACE_ITEM_ID = -1;
        static var _SNOW_NINJA_BODY_ITEM_ID = -1;
        static var _SNOW_NINJA_FEET_ITEM_ID = -1;
        static var _SHADOW_NINJA_HEAD_ITEM_ID = 1271;
        static var _SHADOW_NINJA_FACE_ITEM_ID = 2033;
        static var _SHADOW_NINJA_BODY_ITEM_ID = 4380;
        static var _SHADOW_NINJA_FEET_ITEM_ID = 6077;
        var _intervalId = -1;
        var _dancingFirePlayers = 0;
        var _dancingWaterPlayers = 0;
        var _dancingSnowPlayers = 0;
        var _dancingShadowPlayers = 0;
        var _playFireEffect = false;
        var _playWaterEffect = false;
        var _playSnowEffect = false;
        var _playShadowEffect = false;
        var _checkInterval = 4000;
        var _fireAnimationHeight = 55;
        var _fireAnimationSpeed = 1;
        var _fireAmount = 3;
        var _fireShrinkSize = 100;
        var _fireDelayTime = 2;
        var _rainAnimationHeight = 85;
        var _rainAnimationSpeed = 0.5;
        var _rainAmount = 25;
        var _rainShrinkSize = 25;
        var _rainFadeAmount = 50;
        var _rainDelayTime = 2;
        var _rainRotation = -26;
        var _snowAnimationHeight = 85;
        var _snowAnimationSpeed = 1;
        var _snowAmount = 25;
        var _snowShrinkSize = 50;
        var _snowFadeAmount = 50;
        var _snowDelayTime = 2;
        static var EFFECT_TYPE_FIRE = "Fire";
        static var EFFECT_TYPE_WATER = "Water";
        static var EFFECT_TYPE_SNOW = "Snow";
        static var EFFECT_TYPE_TIE = "Tie";
        static var EFFECT_TYPE_DEFAULT = "Default";
        static var EFFECT_TYPE_EMPTY = "Empty";
        static var OBJECT_TYPE_SKY = "Sky";
        static var OBJECT_TYPE_CLOUDS = "Clouds";
        static var OBJECT_TYPE_DISTANT_OBJ = "DistantObjects";
        static var OBJECT_TYPE_TOP_CLOUDS = "TopClouds";
        static var OBJECT_TYPE_SHELL = "TintShell";
    }
