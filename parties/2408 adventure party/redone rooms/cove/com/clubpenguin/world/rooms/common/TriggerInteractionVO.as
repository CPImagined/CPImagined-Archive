//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.TriggerInteractionVO
    {
        var areAllNeeded, areAnyNeeded, specialDance, colour, colourLength, head, headLength, face, faceLength, neck, neckLength, body, bodyLength, hand, handLength, feet, feetLength, flag, flagLength, photo, photoLength, parts, lengths;
        function TriggerInteractionVO (areAllNeeded, areAnyNeeded, specialDance, colour, head, face, neck, body, hand, feet, flag, photo) {
            this.areAllNeeded = areAllNeeded;
            this.areAnyNeeded = areAnyNeeded;
            this.specialDance = specialDance;
            this.colour = colour;
            colourLength = colour.length;
            this.head = head;
            headLength = head.length;
            this.face = face;
            faceLength = face.length;
            this.neck = neck;
            neckLength = neck.length;
            this.body = body;
            bodyLength = body.length;
            this.hand = hand;
            handLength = hand.length;
            this.feet = feet;
            feetLength = feet.length;
            this.flag = flag;
            flagLength = flag.length;
            this.photo = photo;
            photoLength = photo.length;
            parts = [colour, head, face, neck, body, hand, feet, flag, photo];
            lengths = [colourLength, headLength, faceLength, neckLength, bodyLength, handLength, feetLength, flagLength, photoLength];
            validate();
        }
        function destroy() {
            for (var _local_2 in this) {
                var _local_2 = null;
            }
        }
        function validate() {
            var _local_2 = 0;
            while (_local_2 < ITEM_TYPES) {
                if (parts[_local_2] == undefined) {
                }
                if (lengths[_local_2] == undefined) {
                }
                _local_2++;
            }
        }
        static var CLASS_NAME = "TriggerInteractionVO";
        static var ITEM_TYPES = 9;
    }
