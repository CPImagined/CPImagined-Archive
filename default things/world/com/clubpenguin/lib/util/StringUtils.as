//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.util
{
    import flash.utils.describeType;

    public class StringUtils 
    {


        public static function classVariablesDescription(classObject:Object):String
        {
            var i:int;
            var descriptionString:String = "";
            var description:XMLList = describeType(classObject)..variable;
            while (i < description.length())
            {
                descriptionString = descriptionString.concat((((("\n" + description[i].@name) + ":") + classObject[description[i].@name]) + " "));
                i++;
            };
            return (descriptionString);
        }

        public static function isValidString(string:String):Boolean
        {
            if (string == null)
            {
                return (false);
            };
            if (string.length < 1)
            {
                return (false);
            };
            if (string == "")
            {
                return (false);
            };
            if (string == "undefined")
            {
                return (false);
            };
            return (true);
        }

        public static function makeFirstLetterUpperCase(string:String):String
        {
            return ((string.length > 1) ? (string.charAt(0).toUpperCase() + string.substr(1, (string.length - 1))) : string.charAt(0).toUpperCase());
        }

        public static function toTitleCase(string:String):String
        {
            string = string.toLowerCase();
            var words:Array = string.split(" ");
            var i:uint;
            while (i < words.length)
            {
                words[i] = makeFirstLetterUpperCase(words[i]);
                i++;
            };
            return (words.join(" "));
        }


    }
}//package com.clubpenguin.lib.util
