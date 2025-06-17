//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.enums
{
    public class Language 
    {

        public static const EN:Language = new Language("en");
        public static const PT:Language = new Language("pt");
        public static const FR:Language = new Language("fr");
        public static const ES:Language = new Language("es");
        public static const DE:Language = new Language("de");
        public static const DEFAULT:Language = EN;
        public static const list:Array = Enum.createList(Language);

        private var ID:String;

        public function Language(ID:String)
        {
            this.ID = ID;
        }

        public static function fromString(ID:String):Language
        {
            var item:Language;
            for each (item in list)
            {
                if (item.ID == ID)
                {
                    return (item);
                };
            };
            return (null);
        }


        public function toString():String
        {
            return (this.ID);
        }


    }
}//package com.clubpenguin.lib.enums
