//Created by Action Script Viewer - https://www.buraks.com/asv
package org.robotlegs.base
{
    import org.robotlegs.core.IMediator;
    import flash.utils.getDefinitionByName;
    import flash.events.IEventDispatcher;
    import flash.events.Event;

    public class MediatorBase implements IMediator 
    {

        protected static var UIComponentClass:Class;
        protected static const flexAvailable:Boolean = checkFlex();

        protected var viewComponent:Object;
        protected var removed:Boolean;


        protected static function checkFlex():Boolean
        {
            try
            {
                UIComponentClass = (getDefinitionByName("mx.core::UIComponent") as Class);
            }
            catch(error:Error)
            {
            };
            return (!(UIComponentClass == null));
        }


        public function preRegister():void
        {
            this.removed = false;
            if ((((flexAvailable) && (this.viewComponent is UIComponentClass)) && (!(this.viewComponent["initialized"]))))
            {
                IEventDispatcher(this.viewComponent).addEventListener("creationComplete", this.onCreationComplete, false, 0, true);
            }
            else
            {
                this.onRegister();
            };
        }

        public function onRegister():void
        {
        }

        public function preRemove():void
        {
            this.removed = true;
            this.onRemove();
        }

        public function onRemove():void
        {
        }

        public function getViewComponent():Object
        {
            return (this.viewComponent);
        }

        public function setViewComponent(viewComponent:Object):void
        {
            this.viewComponent = viewComponent;
        }

        protected function onCreationComplete(e:Event):void
        {
            IEventDispatcher(e.target).removeEventListener("creationComplete", this.onCreationComplete);
            if (!this.removed)
            {
                this.onRegister();
            };
        }


    }
}//package org.robotlegs.base
