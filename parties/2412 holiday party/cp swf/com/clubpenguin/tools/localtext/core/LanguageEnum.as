//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.tools.localtext.core
{
    public class LanguageEnum 
    {

        public static const DE:LanguageEnum = new LanguageEnum("de", ["de_DE"]);
        public static const EN:LanguageEnum = new LanguageEnum("en", ["en_US", "en_GB"]);
        public static const ES:LanguageEnum = new LanguageEnum("es", ["es_ES", "es_LA"]);
        public static const FR:LanguageEnum = new LanguageEnum("fr", ["fr_FR"]);
        public static const PT:LanguageEnum = new LanguageEnum("pt", ["pt_PT", "pt_BR"]);
        public static const RU:LanguageEnum = new LanguageEnum("ru", ["ru_RU"]);

        private var _lang:String;
        private var _locales:Array;

        public function LanguageEnum(lang:String, locales:Array)
        {
            this._lang = lang;
            this._locales = locales;
        }

        public static function getEnumByLangString(lang:String):LanguageEnum
        {
            switch (lang)
            {
                case "de":
                    return (DE);
                case "en":
                    return (EN);
                case "es":
                    return (ES);
                case "fr":
                    return (FR);
                case "pt":
                    return (PT);
                case "ru":
                    return (RU);
                default:
                    return (EN);
            };
        }


        public function get lang():String
        {
            return (this._lang);
        }

        public function get locales():Array
        {
            return (this._locales);
        }


    }
}//package com.clubpenguin.tools.localtext.core
