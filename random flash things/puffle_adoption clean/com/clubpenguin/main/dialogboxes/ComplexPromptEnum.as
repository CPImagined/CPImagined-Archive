//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.dialogboxes
{
    import com.clubpenguin.main.view.NotEnoughCoinsPromptView;
    import com.clubpenguin.main.mediator.dialogs.NotEnoughCoinsPromptMediator;
    import com.clubpenguin.lib.util.Enum;

    public class ComplexPromptEnum 
    {

        public static const NOT_ENOUGH_COINS_PROMPT:ComplexPromptEnum = new ComplexPromptEnum("not_enough_coins", NotEnoughCoinsPromptView, NotEnoughCoinsPromptMediator);

        private var _style:String;
        private var _viewClass:Class;
        private var _mediatorClass:Class;

        public function ComplexPromptEnum(style:String, viewClass:Class, mediatorClass:Class)
        {
            this._style = style;
            this._viewClass = viewClass;
            this._mediatorClass = mediatorClass;
        }

        public static function getComplexPrompt(style:String):ComplexPromptEnum
        {
            var foundEnum:ComplexPromptEnum;
            var list:Array = Enum.createList(ComplexPromptEnum);
            var targetStyle:String = style;
            var i:int;
            while (i < list.length)
            {
                if ((list[i] as ComplexPromptEnum).getStyle() == targetStyle)
                {
                    foundEnum = (list[i] as ComplexPromptEnum);
                    break;
                };
                i++;
            };
            return (foundEnum);
        }


        private function getStyle():String
        {
            return (this._style);
        }

        public function get viewClass():Class
        {
            return (this._viewClass);
        }

        public function get mediatorClass():Class
        {
            return (this._mediatorClass);
        }


    }
}//package com.clubpenguin.main.dialogboxes
