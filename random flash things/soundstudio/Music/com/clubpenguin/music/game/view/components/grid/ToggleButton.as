//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.view.components.grid
{
    import flash.events.EventDispatcher;
    import flash.display.MovieClip;
    import flash.display.DisplayObject;
    import flash.events.MouseEvent;

    public class ToggleButton extends EventDispatcher 
    {

        private static const ICON_DELTA_Y:int = 3;

        public var column:Number;
        private var _skin:MovieClip;
        private var iconStartY:int;
        private var _icon:DisplayObject;
        private var _toggled:Boolean;

        public function ToggleButton(skin:MovieClip)
        {
            this._skin = skin;
            skin.buttonMode = true;
            this.addListeners();
            this.updateSkin();
        }

        public function get skin():MovieClip
        {
            return (this._skin);
        }

        public function get icon():DisplayObject
        {
            return (this._icon);
        }

        public function set icon(obj:DisplayObject):void
        {
            this._icon = obj;
            this.iconStartY = ((obj) ? obj.y : NaN);
        }

        public function set toggled(bool:Boolean):void
        {
            this._toggled = bool;
            this.updateSkin();
        }

        public function get toggled():Boolean
        {
            return (this._toggled);
        }

        private function addListeners():void
        {
            this.skin.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            this.skin.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
        }

        protected function onMouseClick(event:MouseEvent):void
        {
            dispatchEvent(new MouseEvent(MouseEvent.CLICK));
        }

        protected function onMouseDown(event:MouseEvent):void
        {
            this.skin.gotoAndStop(2);
            if (this.icon)
            {
                this.icon.y = (this.iconStartY + ICON_DELTA_Y);
            };
            this.skin.stage.addEventListener(MouseEvent.MOUSE_UP, this.onAppMouseUp);
            this._toggled = (!(this._toggled));
            this.updateSkin();
            this.onMouseClick(event);
        }

        private function onAppMouseUp(event:MouseEvent):void
        {
            if (this.skin.stage.hasEventListener(MouseEvent.MOUSE_UP))
            {
                this.skin.stage.removeEventListener(MouseEvent.MOUSE_UP, this.onAppMouseUp);
            };
            dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP, false, true));
            this.updateSkin();
        }

        private function onMouseUp(event:MouseEvent):void
        {
            if (this.skin.stage.hasEventListener(MouseEvent.MOUSE_UP))
            {
                this.skin.stage.removeEventListener(MouseEvent.MOUSE_UP, this.onAppMouseUp);
            };
            dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP, false, true));
            this.updateSkin();
        }

        private function updateSkin():void
        {
            if (this.icon)
            {
                this.icon.y = (this.iconStartY + ((this.toggled) ? ICON_DELTA_Y : 0));
            };
            this.skin.gotoAndStop(((this.toggled) ? 2 : 1));
        }


    }
}//package com.clubpenguin.music.game.view.components.grid
