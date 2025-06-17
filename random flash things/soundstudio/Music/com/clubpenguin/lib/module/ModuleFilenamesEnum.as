//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.module
{
    public class ModuleFilenamesEnum 
    {

        public static const INTRO_TO_CLUBPENGUIN:ModuleFilenamesEnum = new ModuleFilenamesEnum("intro_to_cp", "intro_to_cp.swf");
        public static const NEWSPAPER:ModuleFilenamesEnum = new ModuleFilenamesEnum("current_AS3_news", "newspaper.swf");
        public static const UGC_WALL:ModuleFilenamesEnum = new ModuleFilenamesEnum("ugc_wall", "ugc_wall.swf");
        public static const WORLD:ModuleFilenamesEnum = new ModuleFilenamesEnum("world", "world.swf");
        public static const CREATE_ACCOUNT:ModuleFilenamesEnum = new ModuleFilenamesEnum("create_account", "create/create_module.swf");
        public static const START_SCREEN:ModuleFilenamesEnum = new ModuleFilenamesEnum("start_screen", "start/swf/start_module.swf", true);
        public static const REDEMPTION:ModuleFilenamesEnum = new ModuleFilenamesEnum("redemption", "redemption.swf");
        public static const PUFFLE_ADOPTION:ModuleFilenamesEnum = new ModuleFilenamesEnum("puffle_adoption", "puffle_adoption.swf");
        public static const PUFFLE_CARE:ModuleFilenamesEnum = new ModuleFilenamesEnum("puffle_care", "puffle_care.swf");
        public static const PUFFLE_MANUAL:ModuleFilenamesEnum = new ModuleFilenamesEnum("puffle_manual", "puffle_manual.swf");
        public static const PUFFLE_CERTIFICATE:ModuleFilenamesEnum = new ModuleFilenamesEnum("puffle_certificate", "puffle_certificate.swf");
        public static const PUFFLE_HANDLER:ModuleFilenamesEnum = new ModuleFilenamesEnum("puffle_handler", "/puffle/handler/puffle_handler.swf");
        public static const CATALOG_VIEWER:ModuleFilenamesEnum = new ModuleFilenamesEnum("catalog_viewer", "catalog_viewer.swf");
        public static const GAME_LAUNCHER:ModuleFilenamesEnum = new ModuleFilenamesEnum("game_launcher", "game_launcher.swf");
        public static const MAP_TRIGGERS:ModuleFilenamesEnum = new ModuleFilenamesEnum("map_triggers", "map_triggers.swf");
        public static const MOBILE_ACCOUNT_ACTIVATION:ModuleFilenamesEnum = new ModuleFilenamesEnum("mobile_account_activation", "mobile_account_activation.swf");
        public static const STAMPS_NOTIFICATION:ModuleFilenamesEnum = new ModuleFilenamesEnum("stamps_notification", "stamps.swf");
        public static const NOTIFICATIONS:ModuleFilenamesEnum = new ModuleFilenamesEnum("notifications", "notifications.swf");
        public static const COURTYARD_SENSEI:ModuleFilenamesEnum = new ModuleFilenamesEnum("courtyard_sensei", "courtyard_sensei.swf");
        public static const SNOWBALL:ModuleFilenamesEnum = new ModuleFilenamesEnum("snowball", "snowball.swf");
        public static const LIKE_WINDOW_MODULE:ModuleFilenamesEnum = new ModuleFilenamesEnum("likeWindowModule", "like_window_module.swf");
        public static const VIDEO_PLAYER:ModuleFilenamesEnum = new ModuleFilenamesEnum("videoPlayer", "video_player.swf");
        public static const NINJA_PROGRESS:ModuleFilenamesEnum = new ModuleFilenamesEnum("ninjaProgress", "ninja_progress.swf");
        public static const PHRASE_AUTOCOMPLETE:ModuleFilenamesEnum = new ModuleFilenamesEnum("phraseAutoComplete", "phrase_autocomplete.swf");
        public static const MEMBERSHIP_TRIAL:ModuleFilenamesEnum = new ModuleFilenamesEnum("membershipTrial", "membership_trial.swf");
        public static const BANNING:ModuleFilenamesEnum = new ModuleFilenamesEnum("banning", "banning.swf");
        public static const PUFFLE_TREASURE_INFOGRAPHIC:ModuleFilenamesEnum = new ModuleFilenamesEnum("puffle_treasure_infographic", "puffle_treasure_infographic.swf");
        public static const PUFFLE_CARE_STATION_MENU:ModuleFilenamesEnum = new ModuleFilenamesEnum("puffle_care_station_menu", "puffle_care_station_menu.swf");
        public static const PRE_ACTIVATION:ModuleFilenamesEnum = new ModuleFilenamesEnum("preactivation", "preactivation.swf");
        public static const PUFFLE_GOLD_BERRY_MACHINE:ModuleFilenamesEnum = new ModuleFilenamesEnum("puffle_gold_berry_machine", "puffle_gold_berry_machine.swf");
        public static const PUFFLE_GOLD_QUEST_PROGRESS:ModuleFilenamesEnum = new ModuleFilenamesEnum("puffle_gold_quest_progress", "puffle_gold_quest_progress.swf");
        public static const PUFFLE_GOLD_JACKHAMMER_PROMPT:ModuleFilenamesEnum = new ModuleFilenamesEnum("puffle_gold_jackhammer_prompt", "puffle_gold_jackhammer_prompt.swf");
        public static const PUFFLE_UI_WIDGET:ModuleFilenamesEnum = new ModuleFilenamesEnum("puffle_ui_widget", "puffle_ui_widget/puffle_ui_widget.swf");
        public static const PUFFLE_TRICKS_HUD:ModuleFilenamesEnum = new ModuleFilenamesEnum("puffle_tricks_hud", "puffle_tricks_hud/puffle_tricks_hud.swf");
        public static const MINIGAME_END_SCREENS:ModuleFilenamesEnum = new ModuleFilenamesEnum("minigame_end_screens", "minigame_end_screens.swf");
        public static const AUDIO_LIKES:ModuleFilenamesEnum = new ModuleFilenamesEnum("audio_likes", "audio_likes.swf");
        public static const MUSIC:ModuleFilenamesEnum = new ModuleFilenamesEnum("music", "music/Music.swf");
        public static const FILENAMES:Array = [INTRO_TO_CLUBPENGUIN, NEWSPAPER, UGC_WALL, WORLD, CREATE_ACCOUNT, START_SCREEN, REDEMPTION, PUFFLE_CARE, PUFFLE_ADOPTION, PUFFLE_MANUAL, PUFFLE_CERTIFICATE, PUFFLE_HANDLER, CATALOG_VIEWER, GAME_LAUNCHER, MOBILE_ACCOUNT_ACTIVATION, MAP_TRIGGERS, STAMPS_NOTIFICATION, NOTIFICATIONS, COURTYARD_SENSEI, SNOWBALL, LIKE_WINDOW_MODULE, VIDEO_PLAYER, NINJA_PROGRESS, MEMBERSHIP_TRIAL, PHRASE_AUTOCOMPLETE, BANNING, PUFFLE_TREASURE_INFOGRAPHIC, BANNING, PRE_ACTIVATION, PUFFLE_CARE_STATION_MENU, PUFFLE_GOLD_BERRY_MACHINE, PUFFLE_GOLD_QUEST_PROGRESS, PUFFLE_GOLD_JACKHAMMER_PROMPT, PUFFLE_UI_WIDGET, PUFFLE_TRICKS_HUD, MINIGAME_END_SCREENS, AUDIO_LIKES, MUSIC];

        private var _key:String;
        private var _filename:String;
        private var _isExternal:Boolean;

        public function ModuleFilenamesEnum(key:String, filename:String, isExternal:Boolean=false)
        {
            this._key = key;
            this._filename = filename;
            this._isExternal = isExternal;
        }

        public static function getValue(key:String):ModuleFilenamesEnum
        {
            var i:int;
            while (i < FILENAMES.length)
            {
                if (ModuleFilenamesEnum(FILENAMES[i]).key == key)
                {
                    return (ModuleFilenamesEnum(FILENAMES[i]));
                };
                i++;
            };
            return (null);
        }


        public function get key():String
        {
            return (this._key);
        }

        public function get filename():String
        {
            return (this._filename);
        }

        public function get isExternal():Boolean
        {
            return (this._isExternal);
        }


    }
}//package com.clubpenguin.lib.module
