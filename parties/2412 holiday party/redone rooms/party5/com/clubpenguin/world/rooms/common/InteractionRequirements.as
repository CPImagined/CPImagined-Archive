//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.InteractionRequirements
    {
        var _colour, _head, _face, _neck, _body, _hand, _feet, _flag, _photo, parts, __get__areAllNeeded, __get__areAnyNeeded, __get__specialDance, __get__colour, __get__head, __get__face, __get__neck, __get__body, __get__hand, __get__feet, __get__flag, __get__photo, lengths;
        function InteractionRequirements () {
            _colour = [];
            _head = [];
            _face = [];
            _neck = [];
            _body = [];
            _hand = [];
            _feet = [];
            _flag = [];
            _photo = [];
            parts = [_colour, _head, _face, _neck, _body, _hand, _feet, _flag, _photo];
        }
        function destroy() {
            for (var _local_2 in this) {
                var _local_2 = null;
            }
        }
        function set areAllNeeded(value) {
            _areAllNeeded = value;
            //return(__get__areAllNeeded());
        }
        function set areAnyNeeded(value) {
            _areAnyNeeded = value;
            //return(__get__areAnyNeeded());
        }
        function set dancingRequired(value) {
            _dancingRequired = value;
            //return(dancingRequired);
        }
        function get dancingRequired() {
            return(_dancingRequired);
        }
        function set specialDance(value) {
            _specialDance = value;
            //return(__get__specialDance());
        }
        function set colour(value) {
            _colour = value;
            resetLengths();
            //return(__get__colour());
        }
        function set head(value) {
            _head = value;
            resetLengths();
            //return(__get__head());
        }
        function set face(value) {
            _face = value;
            resetLengths();
            //return(__get__face());
        }
        function set neck(value) {
            _neck = value;
            resetLengths();
            //return(__get__neck());
        }
        function set body(value) {
            _body = value;
            resetLengths();
            //return(__get__body());
        }
        function set hand(value) {
            _hand = value;
            resetLengths();
            //return(__get__hand());
        }
        function set feet(value) {
            _feet = value;
            resetLengths();
            //return(__get__feet());
        }
        function set flag(value) {
            _flag = value;
            resetLengths();
            //return(__get__flag());
        }
        function set photo(value) {
            _photo = value;
            resetLengths();
            //return(__get__photo());
        }
        function isPlayerInteracting(player, secretFrame) {
            if (dancingRequired) {
                if (player.frame != DANCE_FRAME) {
                    return(false);
                } else if (__get__specialDance()) {
                    if (player.frame == secretFrame) {
                        return(false);
                    }
                }
            }
            if (!__get__areAnyNeeded()) {
                return(true);
            } else if (isPlayerWearingNeededItems(player)) {
                return(true);
            }
            return(false);
        }
        function isPlayerWearingNeededItems(player) {
            var _local_5 = [player.colour, player.head, player.face, player.neck, player.body, player.hand, player.feet, player.flag, player.photo];
            var _local_3 = _areAllNeeded;
            var _local_2 = 0;
            while (_local_2 < ITEM_TYPES) {
                if (lengths[_local_2] != 0) {
                } else if (isPlayerWearingThis(_local_5[_local_2], _local_2)) {
                    if (!_local_3) {
                        return(true);
                    }
                } else if (_local_3) {
                    return(false);
                }
                _local_2++;
            }
            if (_local_3) {
                return(true);
            } else {
                return(false);
            }
        }
        function isPlayerWearingThis(item, listIndex) {
            var _local_3 = parts[listIndex];
            var _local_5 = lengths[listIndex];
            var _local_2 = 0;
            while (_local_2 < _local_5) {
                if (item == _local_3[_local_2]) {
                    return(true);
                }
                _local_2++;
            }
            return(false);
        }
        function resetLengths() {
            lengths = [_colour.length, _head.length, _face.length, _neck.length, _body.length, _hand.length, _feet.length, _flag.length, _photo.length];
        }
        static var CLASS_NAME = "InteractionRequirements";
        static var DANCE_FRAME = 26;
        static var ITEM_TYPES = 9;
        var _areAllNeeded = false;
        var _areAnyNeeded = false;
        var _dancingRequired = false;
        var _specialDance = false;
    }
