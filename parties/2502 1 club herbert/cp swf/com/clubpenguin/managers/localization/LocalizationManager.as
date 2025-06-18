//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.managers.localization
{
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import com.clubpenguin.lib.enums.Language;
    import flash.utils.Dictionary;
    import com.clubpenguin.lib.vo.GameStringsVO;
    import com.clubpenguin.tools.localtext.core.ILocalizedText;
    import flash.text.TextField;
    import com.clubpenguin.lib.enums.errors.ErrorCodeEnum;

    public class LocalizationManager implements ILocalizationManager 
    {

        private static const REPLACEMENT_TAG:String = "%";
        private static const pathPattern:RegExp = new RegExp((("/" + Language.DEFAULT) + "/"));

        private const _localizationTable:Dictionary = new Dictionary();

        public var language:Language = Language.DEFAULT;


        public function setLocalizationTable(localizationTable:Object):void
        {
            var key:String;
            for (key in localizationTable)
            {
                if (!((this._localizationTable[key]) && (!(localizationTable[key] == this._localizationTable[key]))))
                {
                    this._localizationTable[key] = localizationTable[key];
                };
            };
        }

        public function setLocalizationTableFromKeyedArray(keyedArray:Object):void
        {
            var key:String;
            var langKeyValue:Array;
            for (key in keyedArray)
            {
                for each (langKeyValue in keyedArray[key])
                {
                    if (!((this._localizationTable[langKeyValue[0]]) && (!(langKeyValue[1] == this._localizationTable[langKeyValue[0]]))))
                    {
                        this._localizationTable[langKeyValue[0]] = langKeyValue[1];
                    };
                };
            };
        }

        public function getGameStrings():ILocalizedText
        {
            var gameStrings:ILocalizedText = new GameStringsVO();
            gameStrings.setLocalText(this._localizationTable);
            return (gameStrings);
        }

        public function getLocalizedString(key:String, ... args):String
        {
            var localizedString:String = key;
            localizedString = this._localizationTable[key];
            if (localizedString == null)
            {
                localizedString = (("**" + key) + "**");
            };
            var replacementArgs:Array = [localizedString].concat(args);
            return (this.replaceTags.apply(null, replacementArgs));
        }

        public function replaceTags(source:String, ... args):String
        {
            var argsLength:uint = args.length;
            var replaced:String = source;
            var i:uint;
            while (i < argsLength)
            {
                replaced = replaced.split(((REPLACEMENT_TAG + i) + REPLACEMENT_TAG)).join(args[i]);
                i++;
            };
            return (replaced);
        }

        public function localizeField(field:TextField, ... args):void
        {
            field.text = this.getLocalizedString.apply(null, [field.text].concat(args));
        }

        public function getPath(path:String):String
        {
            if (this.language == Language.DEFAULT)
            {
                return (path);
            };
            return (path.replace(pathPattern, (("/" + this.language) + "/")));
        }

        public function setLoadingErrorMessages(langCode:String):void
        {
            var errorMessage:String;
            var buttonText:String;
            var errorMessageTag:String = ErrorCodeEnum.WEB_SERVICE_LOAD_ERROR.errorMessageTag;
            var buttonTextTag:String = ErrorCodeEnum.WEB_SERVICE_LOAD_ERROR.buttonTextTag;
            var buttonURLTag:String = ErrorCodeEnum.WEB_SERVICE_LOAD_ERROR.buttonURLTag;
            var buttonURL:String = "http://www.clubpenguin.com";
            switch (langCode)
            {
                case "pt":
                    errorMessage = "Erro\nHouve um erro ao carregar o Club Penguin. Tente novamente mais tarde. Se o problema continuar, contate support.pt@clubpenguin.com ";
                    buttonText = "OK";
                    break;
                case "fr":
                    errorMessage = "Erreur de chargement\nUne erreur s'est produite. Essaie de te connecter plus tard. Si le problème persiste, contacte support.fr@clubpenguin.com";
                    buttonText = "OK";
                    break;
                case "es":
                    errorMessage = "Error al cargar la página\nVuelve a intentarlo más tarde. Si el problema continúa, comunícate con support.es@clubpenguin.com ";
                    buttonText = "OK";
                    break;
                case "de":
                    errorMessage = "Ladefehler\nFehler beim Laden. Bitte versuche dich später erneut anzumelden. Bei Problemen kontaktiere bitte support.de@clubpenguin.com ";
                    buttonText = "O.K.";
                    break;
                case "ru":
                    errorMessage = "Ошибка загрузки\nИзвини, в процессе загрузки «Клуба пингвинов» произошла ошибка. Попробуй зайти в игру позднее. Если эта проблема не исчезнет, то рекомендуем обратиться в Службу поддержки по адресу: support@clubpenguin.ru";
                    buttonText = "OK";
                    break;
                default:
                    errorMessage = "Load Error\nSorry, there's been an error loading Club Penguin. Please try logging in later. If the problem continues please contact support@clubpenguin.com";
                    buttonText = "OK";
            };
            this._localizationTable[errorMessageTag] = errorMessage;
            this._localizationTable[buttonTextTag] = buttonText;
            this._localizationTable[buttonURLTag] = buttonURL;
        }


    }
}//package com.clubpenguin.managers.localization
