//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.newspaper.components
{
    import flash.display.MovieClip;
    import com.clubpenguin.newspaper.models.vo.ContentActionVO;
    import flash.display.SimpleButton;
    import flash.events.Event;
    import com.clubpenguin.newspaper.events.ContentButtonEvent;
    import flash.events.MouseEvent;

    public class ContentButtonComponent extends MovieClip 
    {

        private var actionVO:ContentActionVO = new ContentActionVO();
        private var _target:String;
        private var _action:String;
        private var _buttonViewInstanceName:String;
        private var _buttonView:SimpleButton;

        public function ContentButtonComponent()
        {
            alpha = 0;
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        }

        private function onMouseUp(_arg_1:MouseEvent):void
        {
            trace(("ContentButtonComponent.onMouseUp() -> event: " + _arg_1));
            trace(("\t-> name: " + name));
            trace(("\t-> action: " + this.action));
            trace(("\t-> target: " + this.target));
            trace(("\t-> instance name: " + this.buttonViewInstanceName));
            this.actionVO.action = this.action;
            this.actionVO.target = this.target;
            this.actionVO.buttonInstanceName = this.buttonViewInstanceName;
            dispatchEvent(new ContentButtonEvent(ContentButtonEvent.CLICKED, this.actionVO));
        }

        private function onAddedToStage(_arg_1:Event):void
        {
            trace(("ContentButtonComponent.onAddedToStage() -> event: " + _arg_1));
            if (this.buttonViewInstanceName)
            {
                trace(("\t-> locating button with instance name: " + this._buttonViewInstanceName));
                this._buttonView = (parent.getChildByName(this.buttonViewInstanceName) as SimpleButton);
                if (this._buttonView)
                {
                    trace(("\t\t-> buttonView found: " + this._buttonView));
                    this._buttonView.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
                    mouseEnabled = false;
                    return;
                };
            };
            buttonMode = true;
            addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
        }

        public function set action(_arg_1:String):void
        {
            this._action = _arg_1;
        }

        public function get action():String
        {
            return (this._action);
        }

        public function set target(_arg_1:String):void
        {
            this._target = _arg_1;
        }

        public function set buttonViewInstanceName(_arg_1:String):void
        {
            this._buttonViewInstanceName = _arg_1;
        }

        public function get target():String
        {
            return (this._target);
        }

        public function get buttonViewInstanceName():String
        {
            return (this._buttonViewInstanceName);
        }


    }
}//package com.clubpenguin.newspaper.components
