//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.halloween.scavengerhunts.ScavengerHuntMain
    {
        static var _icon, _ghostHauntScavengerHunt, _keyScavengerHunt;
        function ScavengerHuntMain () {
        }
        static function init() {
            if (_isInitialized) {
                return(undefined);
            }
            _isInitialized = true;
            var _local_1 = com.clubpenguin.world.rooms2012.halloween.Halloween.hasGhostGoggles();
            createKeyScavengerHunt(!_local_1);
            createGhostHauntScavengerHunt(_local_1);
            if (_local_1 && (!com.clubpenguin.world.rooms2012.halloween.Halloween.isMyPlayerGhost())) {
                _icon.scavengerBtn._visible = false;
            }
        }
        static function setHudIcon(icon) {
            _icon = icon;
        }
        static function createGhostHauntScavengerHunt(isActive) {
            _ghostHauntScavengerHunt = new com.clubpenguin.world.rooms2012.halloween.scavengerhunts.GhostHauntScavengerHunt(isActive);
            _ghostHauntScavengerHunt.getScavengerHuntCompleted().add(onGhostHauntCompleted, com.clubpenguin.world.rooms2012.halloween.scavengerhunts.ScavengerHuntMain);
            if (isActive) {
                _icon.setupGhostHauntScavengerHunt();
            }
        }
        static function createKeyScavengerHunt(isActive) {
            _keyScavengerHunt = new com.clubpenguin.world.rooms2012.halloween.scavengerhunts.KeyScavengerHunt(isActive);
            _keyScavengerHunt.getScavengerHuntCompleted().addOnce(onKeysCompleted, com.clubpenguin.world.rooms2012.halloween.scavengerhunts.ScavengerHuntMain);
            if (isActive) {
                _icon.setupKeyScavengerHunt();
            }
        }
        static function onKeysCompleted() {
            _keyScavengerHunt.setActive(false);
            _ghostHauntScavengerHunt.setActive(true);
            _icon.setupGhostHauntScavengerHunt();
            if (!com.clubpenguin.world.rooms2012.halloween.Halloween.isMyPlayerGhost()) {
                _icon.scavengerBtn._visible = false;
            } else {
                _icon.scavengerBtn._visible = true;
            }
        }
        static function onGhostHauntCompleted() {
            _ghostHauntScavengerHunt.reset();
        }
        static function getGhostHauntScavengerHunt() {
            return(_ghostHauntScavengerHunt);
        }
        static function getKeyScavengerHunt() {
            return(_keyScavengerHunt);
        }
        static function isGhostHauntScavengerHuntActive() {
            return(_ghostHauntScavengerHunt.isActive());
        }
        static function isKeyScavengerHuntActive() {
            return(_keyScavengerHunt.isActive());
        }
        static var _isInitialized = false;
    }
