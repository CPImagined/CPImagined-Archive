//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.newspaper.components
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import com.clubpenguin.newspaper.models.vo.ContentActionVO;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import com.clubpenguin.newspaper.events.ContentButtonEvent;

    public class ContentButtonComponent extends MovieClip 
    {

        private var _action:String;
        private var _target:String;
        private var _category:String;
        private var _buttonViewInstanceName:String;
        private var _buttonView:SimpleButton;
        private var actionVO:ContentActionVO = new ContentActionVO();

        public function ContentButtonComponent()
        {
            trace("ContentButtonComponent: 1");
            alpha = 0;
            trace("ContentButtonComponent: 2");
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            trace("ContentButtonComponent: 3");
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

        private function onMouseUp(_arg_1:MouseEvent):void
        {
            trace(("ContentButtonComponent.onMouseUp() -> event: " + _arg_1));
            trace(("\t-> name: " + name));
            trace(("\t-> action: " + this.action));
            trace(("\t-> target: " + this.target));
            trace(("\t-> category: " + this.category));
            trace(("\t-> instance name: " + this.buttonViewInstanceName));
            this.actionVO.action = this.action;
            this.actionVO.target = this.target;
            this.actionVO.category = this.category;
            this.actionVO.buttonInstanceName = this.buttonViewInstanceName;
            dispatchEvent(new ContentButtonEvent(ContentButtonEvent.CLICKED, this.actionVO));
        }

        public function set action(_arg_1:String):void
        {
            trace("ContentButtonComponent.setaction");
            this._action = _arg_1;
        }

        public function get action():String
        {
            trace("ContentButtonComponent.getaction");
            return (this._action);
        }

        public function set target(_arg_1:String):void
        {
            trace("ContentButtonComponent.settarget");
            this._target = _arg_1;
        }

        public function get target():String
        {
            trace("ContentButtonComponent.gettarget");
            return (this._target);
        }

        public function set buttonViewInstanceName(_arg_1:String):void
        {
            trace("ContentButtonComponent.setbuttonViewInstanceName");
            this._buttonViewInstanceName = _arg_1;
        }

        public function get buttonViewInstanceName():String
        {
            trace("ContentButtonComponent.getbuttonViewInstanceName");
            return (this._buttonViewInstanceName);
        }

        public function set category(_arg_1:String):void
        {
            this._category = _arg_1;
        }

        public function get category():String
        {
            return (this._category);
        }


    }
}//package com.clubpenguin.newspaper.components
