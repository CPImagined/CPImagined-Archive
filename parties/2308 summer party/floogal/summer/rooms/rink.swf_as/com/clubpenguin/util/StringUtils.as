dynamic class com.clubpenguin.util.StringUtils
{

    function StringUtils()
    {
    }

    static function capitalizeFirstLetter(source)
    {
        return source.substr(0, 1).toUpperCase() + source.substr(1, source.length);
    }

    static function toTitleCase(source)
    {
        var __reg2 = source.split(" ");
        var __reg3 = __reg2.length;
        var __reg1 = 0;
        while (__reg1 < __reg3) 
        {
            __reg2[__reg1] = com.clubpenguin.util.StringUtils.capitalizeFirstLetter(__reg2[__reg1]);
            ++__reg1;
        }
        return __reg2.join(" ");
    }

    static function lastChar(string)
    {
        if (typeof string != "string") 
        {
            return "";
        }
        return string.substr(-1, 1);
    }

    static function removeLastChar(string)
    {
        if (typeof string != "string") 
        {
            return "";
        }
        return string.substring(0, string.length - 1);
    }

    static function ensureTrailingSlash(string)
    {
        if (typeof string != "string") 
        {
            return "";
        }
        if (com.clubpenguin.util.StringUtils.lastChar(string) != "/") 
        {
            string = string + "/";
        }
        return string;
    }

    static function removeTrailingSlash(string)
    {
        if (typeof string != "string") 
        {
            return "";
        }
        if (com.clubpenguin.util.StringUtils.lastChar(string) == "/") 
        {
            return com.clubpenguin.util.StringUtils.removeLastChar(string);
        }
        return string;
    }

    static function replaceString(target, word, message)
    {
        return message.split(target).join(word);
    }

    static function trimWhitespace(str)
    {
        str = com.clubpenguin.util.StringUtils.replaceChar(str, " ", "");
        return str;
    }

    static function replaceChar(str, targetChar, repChar)
    {
        var __reg3 = "";
        var __reg1 = 0;
        while (__reg1 < str.length) 
        {
            __reg3 = __reg3 + (str.charAt(__reg1) == targetChar ? repChar : str.charAt(__reg1));
            ++__reg1;
        }
        return __reg3;
    }

    static function ResizeTextToFit(txt)
    {
        var __reg4 = txt._y;
        if (txt.textWidth > txt._width) 
        {
            var __reg5 = txt.text;
            txt.text = "A";
            var __reg3 = txt.textHeight;
            txt.text = __reg5;
            while (txt.textWidth > txt._width) 
            {
                var __reg2 = txt.getTextFormat();
                --__reg2.size;
                txt.setTextFormat(__reg2);
            }
            txt._y = __reg4 + (__reg3 - txt.textHeight);
        }
    }

    static function checkStartsWithVowel(str)
    {
        var __reg1 = str.charAt(0).toLowerCase();
        return __reg1 == "a" || __reg1 == "e" || __reg1 == "i" || __reg1 == "o" || __reg1 == "u";
    }

}
