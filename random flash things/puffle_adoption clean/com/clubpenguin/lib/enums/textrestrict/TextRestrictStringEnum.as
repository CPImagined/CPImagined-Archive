//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.enums.textrestrict
{
    import com.clubpenguin.lib.enums.Enum;

    public class TextRestrictStringEnum extends Enum 
    {

        public static const EN:TextRestrictStringEnum = new TextRestrictStringEnum("en", " ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz");
        public static const PT:TextRestrictStringEnum = new TextRestrictStringEnum("pt", " ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzÀÁÂÃÇÉÊÍÓÔÕÚàáâãçéêíòóôõú");
        public static const FR:TextRestrictStringEnum = new TextRestrictStringEnum("fr", " ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzÀÂÆÇÈÉÊËÎÏÔÙÛÜàâæçèéêëîïôùûüœ");
        public static const ES:TextRestrictStringEnum = new TextRestrictStringEnum("es", " ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzÁÉÍÑÓÚÜáéíñóúü");
        public static const DE:TextRestrictStringEnum = new TextRestrictStringEnum("de", " ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzÄÖÜßäöü");
        public static const RU:TextRestrictStringEnum = new TextRestrictStringEnum("ru", " ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя");
        public static const TEXT_RESTRICT_STRING_ENUM_LIST:Array = Enum.createList(TextRestrictStringEnum);

        public var language:String;
        public var restrictString:String;

        public function TextRestrictStringEnum(language:String, restrictString:String)
        {
            this.language = language;
            this.restrictString = restrictString;
        }

        public static function getRestrictStringByLanguage(language:String):String
        {
            var i:int;
            while (i < TEXT_RESTRICT_STRING_ENUM_LIST.length)
            {
                if (TextRestrictStringEnum(TEXT_RESTRICT_STRING_ENUM_LIST[i]).language == language)
                {
                    return (TextRestrictStringEnum(TEXT_RESTRICT_STRING_ENUM_LIST[i]).restrictString);
                };
                i++;
            };
            return (null);
        }


    }
}//package com.clubpenguin.lib.enums.textrestrict
