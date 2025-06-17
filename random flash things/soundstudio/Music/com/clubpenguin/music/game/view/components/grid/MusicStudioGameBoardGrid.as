//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.view.components.grid
{
    import flash.events.EventDispatcher;
    import flash.display.MovieClip;
    import __AS3__.vec.Vector;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import com.clubpenguin.lib.util.Log;
    import flash.display.DisplayObject;
    import flash.system.ApplicationDomain;
    import flash.events.MouseEvent;
    import com.clubpenguin.music.game.view.events.MusicStudioGameBoardEvent;
    import __AS3__.vec.*;

    public class MusicStudioGameBoardGrid extends EventDispatcher 
    {

        protected var skin:MovieClip;
        public var buttons:Vector.<ToggleButton>;
        private var buttonClasses:Array;
        private var _localizationManager:ILocalizationManager;
        private var _genre:int;

        public function MusicStudioGameBoardGrid(skin:MovieClip, localizationManager:ILocalizationManager)
        {
            Log.debug("");
            this.skin = skin;
            this._localizationManager = localizationManager;
            this.buttons = new Vector.<ToggleButton>();
            this.getButtonClassesReferences();
            this.hideAllIconsButPop();
            this.addListeners();
        }

        public function set genre(index:int):void
        {
            this._genre = index;
            var i:uint;
            while (i < 5)
            {
                (this.skin[("icons_genre" + i)] as MovieClip).visible = (i == index);
                i++;
            };
            this.setGenreIconsForButtons(index);
        }

        private function setGenreIconsForButtons(index:int):void
        {
            var button:ToggleButton;
            for each (button in this.buttons)
            {
                button.icon = this.getGenreIconForButton(button);
            };
        }

        private function getGenreIconForButton(button:ToggleButton):DisplayObject
        {
            var icon:DisplayObject;
            var icons:MovieClip = (this.skin[("icons_genre" + this._genre)] as MovieClip);
            var i:int;
            while (i < icons.numChildren)
            {
                icon = icons.getChildAt(i);
                if (button.skin.hitTestObject(icon))
                {
                    return (icon);
                };
                i++;
            };
            return (null);
        }

        public function get layout():String
        {
            var button:ToggleButton;
            var status:String = "";
            for each (button in this.buttons)
            {
                if (button.toggled)
                {
                    status = (status + "1");
                }
                else
                {
                    status = (status + "0");
                };
            };
            Log.debug(status);
            return (status);
        }

        private function hideAllIconsButPop():void
        {
            var genreId:uint = 1;
            while (genreId < 4)
            {
                (this.skin[("icons_genre" + genreId)] as MovieClip).visible = false;
                genreId++;
            };
        }

        private function getButtonClassesReferences():void
        {
            var buttonClassDefinition:Class;
            this.buttonClasses = [];
            var i:int = 1;
            while (i <= 6)
            {
                buttonClassDefinition = (ApplicationDomain.currentDomain.getDefinition(("music_btn" + i)) as Class);
                if (buttonClassDefinition)
                {
                    this.buttonClasses.push(buttonClassDefinition);
                };
                i++;
            };
            Log.debug(("buttonClasses.length: " + this.buttonClasses.length));
            if (this.buttonClasses.length != 6)
            {
                throw (new Error("[MusicStudioGameBoardGrid] Unexpected number of button class definitions."));
            };
        }

        public function reset():void
        {
            var button:ToggleButton;
            var length:uint = this.buttons.length;
            var i:uint;
            while (i < length)
            {
                button = this.buttons[i];
                button.toggled = false;
                i++;
            };
        }

        protected function addListeners():void
        {
            var buttonAsset:MovieClip;
            var button:ToggleButton;
            var col:Number;
            var col_num:String;
            var column:Vector.<ToggleButton>;
            var columnsIndex:Array = [];
            var columns:Array = [];
            var i:uint;
            while (i < this.skin.numChildren)
            {
                buttonAsset = (this.skin.getChildAt(i) as MovieClip);
                if (!buttonAsset)
                {
                }
                else
                {
                    if (!this.isButtonMC(buttonAsset))
                    {
                        buttonAsset.mouseEnabled = false;
                        buttonAsset.mouseChildren = false;
                    }
                    else
                    {
                        button = new ToggleButton(buttonAsset);
                        button.addEventListener(MouseEvent.CLICK, this.onButtonClicked);
                        button.addEventListener(MouseEvent.MOUSE_UP, this.onButtonMouseUp);
                        col = Math.round(button.skin.x);
                        if (!columns[col])
                        {
                            columns[col] = new Vector.<ToggleButton>();
                            columnsIndex.push(col);
                        };
                        button.column = col;
                        columns[col].push(button);
                    };
                };
                i++;
            };
            columnsIndex.sort(Array.NUMERIC);
            var c:int;
            while (c < columnsIndex.length)
            {
                col_num = columnsIndex[c].toString();
                column = (columns[col_num] as Vector.<ToggleButton>);
                this.buttons = this.buttons.concat(column);
                c++;
            };
        }

        private function isButtonMC(buttonAsset:MovieClip):Boolean
        {
            var clazz:Class;
            for each (clazz in this.buttonClasses)
            {
                if ((buttonAsset is clazz))
                {
                    return (true);
                };
            };
            return (false);
        }

        protected function onButtonClicked(event:MouseEvent):void
        {
            Log.debug(event.currentTarget.toString());
            var button:ToggleButton = (event.currentTarget as ToggleButton);
            var buttonInColumn:ToggleButton = this.getOtherToggledButtonInColumn(button);
            if (((buttonInColumn) && (!(button == buttonInColumn))))
            {
                buttonInColumn.toggled = false;
            };
            dispatchEvent(new MusicStudioGameBoardEvent(MusicStudioGameBoardEvent.SOUND_BUTTON_CLICKED));
        }

        protected function onButtonMouseUp(event:MouseEvent):void
        {
            var button:ToggleButton = (event.currentTarget as ToggleButton);
            if (this.isOneOffButton(button))
            {
                button.toggled = false;
            };
        }

        private function isOneOffButton(button:ToggleButton):Boolean
        {
            var length:uint = this.buttons.length;
            var firstOneOff:ToggleButton = this.buttons[(length - 15)];
            return (button.column >= firstOneOff.column);
        }

        protected function getOtherToggledButtonInColumn(button:ToggleButton):ToggleButton
        {
            var otherButton:ToggleButton;
            var length:uint = this.buttons.length;
            var i:uint;
            while (i < length)
            {
                otherButton = this.buttons[i];
                if ((((otherButton.toggled) && (button.column == otherButton.column)) && (!(button == otherButton))))
                {
                    return (otherButton);
                };
                i++;
            };
            return (null);
        }

        public function localize():void
        {
            this.skin.loopsLabel.text = this._localizationManager.getLocalizedString("w.app.music.game.board.loops");
            this.skin.oneShotsLabel.text = this._localizationManager.getLocalizedString("w.app.music.game.board.oneShots");
        }


    }
}//package com.clubpenguin.music.game.view.components.grid
