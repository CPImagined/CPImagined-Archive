//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.hollywood.Hollywood
    {
        static var _opcodeJournal, _superstarHitEffect, actorScavengerHunt;
        function Hollywood () {
        }
        static function init() {
            var _local_2 = _global.getCurrentShell();
            _opcodeJournal = new com.clubpenguin.world.rooms2013.hollywood.OpcodeJournal();
            _opcodeJournal.init(_local_2.getMyPlayerId());
            _superstarHitEffect = new com.clubpenguin.world.rooms2013.hollywood.snowball.SuperstarHitEffect(_opcodeJournal);
            actorScavengerHunt = new com.clubpenguin.world.rooms2013.hollywood.ui.ActorScavengerHunt();
            _local_2.addListener(com.clubpenguin.engine.projectiles.events.SnowballEvent.SNOWBALL_HIT, com.clubpenguin.util.Delegate.create(_superstarHitEffect, _superstarHitEffect.applyHitEffect));
            _local_2.addListener(com.clubpenguin.engine.projectiles.events.SnowballEvent.SNOWBALL_MISS, com.clubpenguin.util.Delegate.create(_superstarHitEffect, _superstarHitEffect.applyMissEffect));
        }
        static function getOpcodeJournal() {
            return(_opcodeJournal);
        }
        static function canAccessMemberExperience() {
            var _local_2 = _global.getCurrentShell();
            return(_local_2.isMyPlayerMember());
        }
        static function isPlayerActor(avatarID) {
            return((avatarID == SUPERSTAR_AVATAR_ID) || (avatarID == STAR_DIRECTOR_AVATAR_ID));
        }
        static function isPlayerDirector(avatarID) {
            return((avatarID == NON_MEMBER_DIRECTOR_AVATAR_ID) || (avatarID == STAR_DIRECTOR_AVATAR_ID));
        }
        static function isDirectorQuestComplete() {
            return(getDirectorPower() >= 100);
        }
        static function areActorQuestsComplete() {
            return(getNumCompletedActorQuests() >= 3);
        }
        static function getNumCompletedActorQuests() {
            var _local_3 = _global.getCurrentParty().partyCookie;
            if (_local_3 == null) {
                return(0);
            }
            var _local_6 = _local_3.StarPower.SchoolSet.Cameras;
            var _local_5 = _local_3.StarPower.ActionSet.Stunts;
            var _local_4 = _local_3.StarPower.SciFiSet.Locations;
            var _local_2 = 0;
            if ((_local_6[0] && (_local_6[1])) && (_local_6[2])) {
                _local_2 = _local_2 + 1;
            }
            if ((_local_5[0] && (_local_5[1])) && (_local_5[2])) {
                _local_2 = _local_2 + 1;
            }
            if ((_local_4[0] && (_local_4[1])) && (_local_4[2])) {
                _local_2 = _local_2 + 1;
            }
            return(_local_2);
        }
        static function getDirectorPower() {
            var _local_3 = _global.getCurrentParty().partyCookie;
            if (_local_3 == null) {
                return(0);
            }
            var _local_4 = _local_3.DirectorPower.DirectorPoints;
            var _local_2 = 100 * (_local_4 / _local_3.DirectorPower.PointsToBeADirector);
            _local_2 = Math.min(100, _local_2);
            _local_2 = Math.max(0, _local_2);
            return(_local_2);
        }
        static function getStageTicketOwned() {
            return(_global.getCurrentParty().partyCookie.hasStageTicket);
        }
        static function setStageTicketReceived() {
            var _local_3 = _global.getCurrentParty();
            var _local_2 = _local_3.partyCookie;
            if (!_local_2.hasStageTicket) {
                _local_2.hasStageTicket = true;
                _local_3.sendSavePartyCookieJson(PARTY_COOKIE_ID, _local_2);
            }
        }
        static function setDirectorPower(points) {
            var _local_2 = _global.getCurrentParty();
            _local_2.partyCookie.DirectorPower.DirectorPoints = points;
        }
        static function canPhotographPlayer(playerId) {
            var _local_1 = 0;
            while (_local_1 < PLAYER_PHOTO_LIST.length) {
                if (PLAYER_PHOTO_LIST[_local_1] == playerId) {
                    return(false);
                }
                _local_1++;
            }
            return(true);
        }
        static var PARTY_COOKIE_ID = "20130201";
        static var STAGE_A_AVAILABILITY_DATE = 0;
        static var STAGE_B_AVAILABILITY_DATE = 1360998000000;
        static var STAGE_C_AVAILABILITY_DATE = 1361084400000;
        static var BRONZE_AWARDS_AVAILABILITY_DATE = 1361430000000;
        static var SILVER_AWARDS_AVAILABILITY_DATE = 1361602800000;
        static var GOLD_AWARDS_AVAILABILITY_DATE = 1361689200000;
        static var ACTION_SCENE_BG = 9185;
        static var SCIFI_SCENE_BG = 9186;
        static var HIGH_SCHOOL_SCENE_BG = 9187;
        static var GOLF_CART = 4794;
        static var BRONZE_AWARD = 5217;
        static var SILVER_AWARD = 5216;
        static var GOLD_AWARD = 5207;
        static var SLIDER_CELL_PHONE = 5219;
        static var HUGE_DIAMOND_RING = 5210;
        static var DIGITAL_CAMERA = 3157;
        static var DIRECTOR_CAP = 1555;
        static var CLAPBOARD = 5209;
        static var MOVIE_CAMERA = 3158;
        static var FILM_SCRIPT = 5211;
        static var STARS_AND_LIGHTS_BG = 9184;
        static var STUNTMAN_SUIT = 4791;
        static var STUNTWOMAN_SUIT = 4792;
        static var GOLD_LETTERMAN_JACKET = 4789;
        static var SPACE_THING_COSTUME = 4790;
        static var SUPERSTAR_AVATAR_ID = 26;
        static var NON_MEMBER_DIRECTOR_AVATAR_ID = 27;
        static var STAR_DIRECTOR_AVATAR_ID = 28;
        static var PARTY_CATALOGUE_1 = "w.party.clothing.catalogue1";
        static var PARTY_CATALOGUE_2 = "w.party.clothing.catalogue2";
        static var CONTENT_SCAVENGER_HUNT = "scavenger_hunt";
        static var GO_THERE_POSTER = "party_poster";
        static var AWARDS_SWAGBAG_UI = "w.party.02.2013.hollywood.swagbagui";
        static var AWARDS_INSTRUCTIONS_UI = "w.party.02.2013.hollywood.awards_instructions";
        static var AWARDS_ENTRY_DENIAL_UI = "w.party.02.2013.hollywood.awards_entry_denial";
        static var QUEST_UI_STAGE_A = "w.party.02.2013.hollywood.questui.stagea";
        static var QUEST_UI_STAGE_B = "w.party.02.2013.hollywood.questui.stageb";
        static var QUEST_UI_STAGE_C = "w.party.02.2013.hollywood.questui.stagec";
        static var STAGE_A_ACT1 = "stageA:Act1";
        static var STAGE_A_ACT2 = "stageA:Act2";
        static var STAGE_A_ACT3 = "stageA:Act3";
        static var STAGE_B_ACT1 = "stageB:Act1";
        static var STAGE_B_ACT2 = "stageB:Act2";
        static var STAGE_B_ACT3 = "stageB:Act3";
        static var STAGE_C_ACT1 = "stageC:Act1";
        static var STAGE_C_ACT2 = "stageC:Act2";
        static var STAGE_C_ACT3 = "stageC:Act3";
        static var OOPS_SUPERSTAR = "oops_party1";
        static var PLAYER_PHOTO_LIST = [];
    }
