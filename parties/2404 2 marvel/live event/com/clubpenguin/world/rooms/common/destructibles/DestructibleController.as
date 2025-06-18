//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.destructibles.DestructibleController
    {
        var _destructibleObject, _trigger, _destructionSounds, _constructionSounds, _explosionClips, _destructionLinks, _constructionLinks, _soundManager, _center, _min, _max, _closestPoint, _diff;
        function DestructibleController (destructibleObject, trigger, destructionSounds, constructionSounds) {
            _destructibleObject = destructibleObject;
            _trigger = trigger;
            _destructionSounds = destructionSounds;
            _constructionSounds = constructionSounds;
            _explosionClips = [];
            _destructionLinks = [];
            _constructionLinks = [];
            if (_destructionSounds == null) {
                _destructionSounds = ["destroyEffect"];
            }
            if (_constructionSounds == null) {
                _constructionSounds = ["fixEffect"];
            }
            initTempVars();
        }
        function set soundManager(manager) {
            _soundManager = manager;
            //return(soundManager);
        }
        function get soundManager() {
            return(_soundManager);
        }
        function addExplosionClip(explosion) {
            var _local_2 = 0;
            while (_local_2 < _explosionClips.length) {
                if (_explosionClips[_local_2] == explosion) {
                    return(undefined);
                }
                _local_2++;
            }
            _explosionClips.push(explosion);
        }
        function addLink(childLink) {
            var _local_2 = 0;
            while (_local_2 < _constructionLinks.length) {
                if (_constructionLinks[_local_2] == childLink) {
                    return(undefined);
                }
                _local_2++;
            }
            _constructionLinks.push(childLink);
            childLink._destructionLinks.push(this);
        }
        function checkTriggerHit(snowballInfo) {
            if (_trigger == undefined) {
                return(false);
            }
            var _local_2 = _trigger.hitTest(snowballInfo.x, snowballInfo.y, true);
            if (_local_2) {
                _local_2 = false;
                if ((isSnowballDestructive(snowballInfo) && (!isDestroyed)) && (canBeDestroyed())) {
                    breakObject();
                    _local_2 = true;
                } else if ((isSnowballConstructive(snowballInfo) && (!isFixed)) && (canBeFixed())) {
                    fixObject();
                    snowballInfo.snowballMC._visible = false;
                    _local_2 = true;
                } else if ((!isSnowballDestructive) && (!isSnowballDestructive)) {
                    _local_2 = true;
                }
            }
            return(_local_2);
        }
        function checkAreaOfEffectHit(x, y, radius) {
            if (_trigger == undefined) {
                return(false);
            }
            var _local_3 = _trigger.getBounds(_trigger._parent);
            var _local_2 = pointInRectangle(x, y, _local_3) || (circleIntersection(x, y, radius, _local_3));
            if ((_local_2 && (!isDestroyed)) && (canBeDestroyed())) {
                breakObject();
            } else {
                _local_2 = false;
            }
            return(_local_2);
        }
        function breakObject() {
            if (!isDestroyed) {
                _destructibleObject.nextFrame();
                _destructibleObject.explosion_mc.gotoAndPlay(2);
                var _local_2 = 0;
                while (_local_2 < _explosionClips.length) {
                    _explosionClips[_local_2].gotoAndPlay(2);
                    _local_2++;
                }
                playDestructionSound();
            }
        }
        function fixObject() {
            if (!isFixed) {
                _destructibleObject.gotoAndStop(1);
                _destructibleObject.fix_mc.gotoAndPlay(2);
                playConstructionSound();
            }
        }
        function playDestructionSound() {
            if (_soundManager != null) {
                _soundManager.tryPlayNextSound(_destructionSounds);
            } else {
                com.clubpenguin.world.rooms.common.destructibles.DestructibleSoundManager.playNextSoundAtTarget(_destructionSounds, _global.getCurrentEngine().getRoomMovieClip());
            }
        }
        function playConstructionSound() {
            if (_soundManager != null) {
                _soundManager.tryPlayNextSound(_constructionSounds);
            } else {
                com.clubpenguin.world.rooms.common.destructibles.DestructibleSoundManager.playNextSoundAtTarget(_constructionSounds, _global.getCurrentEngine().getRoomMovieClip());
            }
        }
        function isSnowballDestructive(snowballInfo) {
            return(snowballInfo.snowballType.isDestructive);
        }
        function isSnowballConstructive(snowballInfo) {
            return(snowballInfo.snowballType.isConstructive);
        }
        function canBeDestroyed() {
            var _local_2 = 0;
            while (_local_2 < _destructionLinks.length) {
                if (!_destructionLinks[_local_2].isDestroyed) {
                    return(false);
                }
                _local_2++;
            }
            return(true);
        }
        function canBeFixed() {
            var _local_2 = 0;
            while (_local_2 < _constructionLinks.length) {
                if (!_constructionLinks[_local_2].isFixed) {
                    return(false);
                }
                _local_2++;
            }
            return(true);
        }
        function get isDestroyed() {
            return(_destructibleObject._currentframe == _destructibleObject._totalframes);
        }
        function get isDamaged() {
            return((_destructibleObject._currentframe < _destructibleObject._totalframes) && (_destructibleObject._currentframe != 1));
        }
        function get isFixed() {
            return(_destructibleObject._currentframe == 1);
        }
        function get destructionSounds() {
            return(_destructionSounds);
        }
        function set destructionSounds(sounds) {
            _destructionSounds = sounds;
            //return(destructionSounds);
        }
        function get constructionSounds() {
            return(_constructionSounds);
        }
        function set constructionSounds(sounds) {
            _constructionSounds = sounds;
            //return(constructionSounds);
        }
        function initTempVars() {
            _center = new flash.geom.Point(0, 0);
            _min = new flash.geom.Point(0, 0);
            _max = new flash.geom.Point(0, 0);
            _closestPoint = new flash.geom.Point(0, 0);
            _diff = new flash.geom.Point(0, 0);
        }
        function pointInRectangle(x, y, bounds) {
            return((((x >= bounds.xMin) && (x <= bounds.xMax)) && (y >= bounds.yMin)) && (y <= bounds.yMax));
        }
        function circleIntersection(x, y, radius, bounds) {
            _center.x = x;
            _center.y = y;
            _min.x = bounds.xMin;
            _min.y = bounds.yMin;
            _max.x = bounds.xMax;
            _max.y = bounds.yMax;
            var _local_2 = _center.clone();
            if (_center.x < _min.x) {
                _local_2.x = _min.x;
            } else if (_center.x > _max.x) {
                _local_2.x = _max.x;
            }
            if (_center.y < _min.y) {
                _local_2.y = _min.y;
            } else if (_center.y > _max.y) {
                _local_2.y = _max.y;
            }
            _diff = _local_2.subtract(_center);
            if (((_diff.x * _diff.x) + (_diff.y * _diff.y)) > (radius * radius)) {
                return(false);
            }
            return(true);
        }
        function toString() {
            return(((((((((((("DestructibleController{mc:" + _destructibleObject) + ", isDestroyed:") + isDestroyed) + ", isDamaged:") + isDamaged) + ", isFixed:") + isFixed) + ", canBeDestroyed:") + canBeDestroyed()) + ", canBeFixed:") + canBeFixed()) + "}");
        }
    }
