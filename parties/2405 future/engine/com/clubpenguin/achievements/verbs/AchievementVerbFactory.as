//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.achievements.verbs.AchievementVerbFactory
    {
        var _debug, __get__debug;
        function AchievementVerbFactory (debug) {
            _debug = debug;
        }
        function createVerb(descriptor) {
            debugTrace("createVerb - " + descriptor.join(" "));
            var _local_3 = String(descriptor.shift());
            switch (_local_3) {
                case "hasProperty" : 
                    return(new com.clubpenguin.achievements.verbs.AchievementVerbHasProperty(descriptor, __get__debug()));
                case "owns" : 
                    return(new com.clubpenguin.achievements.verbs.AchievementVerbOwns(descriptor, __get__debug()));
                case "wearing" : 
                    return(new com.clubpenguin.achievements.verbs.AchievementVerbWearing(descriptor, __get__debug()));
                case "in" : 
                    return(new com.clubpenguin.achievements.verbs.AchievementVerbIn(descriptor, __get__debug()));
                case "hits" : 
                    return(new com.clubpenguin.achievements.verbs.AchievementVerbHit(descriptor, __get__debug()));
                case "occurs" : 
                    return(new com.clubpenguin.achievements.verbs.AchievementVerbOccurs(descriptor, __get__debug()));
                case "occursUniquely" : 
                    return(new com.clubpenguin.achievements.verbs.AchievementVerbOccursUniquely(descriptor, __get__debug()));
                case "puffles" : 
                    return(new com.clubpenguin.achievements.verbs.AchievementVerbPuffles(descriptor, __get__debug()));
                case "isOnFrame" : 
                    return(new com.clubpenguin.achievements.verbs.AchievementVerbIsOnFrame(descriptor, __get__debug()));
                case "hasItemID" : 
                    return(new com.clubpenguin.achievements.verbs.AchievementVerbHasID(descriptor, __get__debug(), "item_id"));
                case "hasEmoteID" : 
                    return(new com.clubpenguin.achievements.verbs.AchievementVerbHasID(descriptor, __get__debug(), "emote_id"));
                case "hasEventID" : 
                    return(new com.clubpenguin.achievements.verbs.AchievementVerbHasID(descriptor, __get__debug(), "id"));
                case "hasPenguinColourID" : 
                    return(new com.clubpenguin.achievements.verbs.AchievementVerbHasID(descriptor, __get__debug(), "colour_id"));
                case "containsText" : 
                    return(new com.clubpenguin.achievements.verbs.AchievementVerbContainsText(descriptor, __get__debug()));
            }
            throw new com.clubpenguin.achievements.AchievementException(("createVerb did not recognise verbToken:\"" + _local_3) + "\"");
        }
        function set debug(state) {
            _debug = state;
            //return(__get__debug());
        }
        function debugTrace(msg) {
            if (_debug) {
            }
        }
    }
