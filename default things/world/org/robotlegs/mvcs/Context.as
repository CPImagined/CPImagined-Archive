//Created by Action Script Viewer - https://www.buraks.com/asv
package org.robotlegs.mvcs
{
    import org.robotlegs.base.ContextBase;
    import org.robotlegs.core.IContext;
    import org.robotlegs.core.IInjector;
    import org.robotlegs.core.IReflector;
    import flash.display.DisplayObjectContainer;
    import org.robotlegs.core.ICommandMap;
    import org.robotlegs.core.IMediatorMap;
    import org.robotlegs.core.IViewMap;
    import org.robotlegs.base.ContextEvent;
    import org.robotlegs.adapters.SwiftSuspendersReflector;
    import org.robotlegs.base.CommandMap;
    import org.robotlegs.base.MediatorMap;
    import org.robotlegs.base.ViewMap;
    import flash.events.IEventDispatcher;
    import org.robotlegs.core.IEventMap;
    import org.robotlegs.base.EventMap;
    import flash.events.Event;
    import org.robotlegs.adapters.SwiftSuspendersInjector;
    import flash.system.ApplicationDomain;

    public class Context extends ContextBase implements IContext 
    {

        protected var _injector:IInjector;
        protected var _reflector:IReflector;
        protected var _autoStartup:Boolean;
        protected var _contextView:DisplayObjectContainer;
        protected var _commandMap:ICommandMap;
        protected var _mediatorMap:IMediatorMap;
        protected var _viewMap:IViewMap;

        public function Context(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
        {
            this._contextView = contextView;
            this._autoStartup = autoStartup;
            this.mapInjections();
            this.checkAutoStartup();
        }

        public function startup():void
        {
            dispatchEvent(new ContextEvent(ContextEvent.STARTUP_COMPLETE));
        }

        public function shutdown():void
        {
            dispatchEvent(new ContextEvent(ContextEvent.SHUTDOWN_COMPLETE));
        }

        public function get contextView():DisplayObjectContainer
        {
            return (this._contextView);
        }

        public function set contextView(value:DisplayObjectContainer):void
        {
            if (this._contextView != value)
            {
                this._contextView = value;
                this._injector.applicationDomain = this.getApplicationDomainFromContextView();
                this._commandMap = null;
                this._mediatorMap = null;
                this._viewMap = null;
                this.mapInjections();
                this.checkAutoStartup();
            };
        }

        protected function get injector():IInjector
        {
            return (this._injector = ((this._injector) || (this.createInjector())));
        }

        protected function set injector(value:IInjector):void
        {
            this._injector = value;
        }

        protected function get reflector():IReflector
        {
            return (this._reflector = ((this._reflector) || (new SwiftSuspendersReflector())));
        }

        protected function set reflector(value:IReflector):void
        {
            this._reflector = value;
        }

        protected function get commandMap():ICommandMap
        {
            return (this._commandMap = ((this._commandMap) || (new CommandMap(eventDispatcher, this.createChildInjector(), this.reflector))));
        }

        protected function set commandMap(value:ICommandMap):void
        {
            this._commandMap = value;
        }

        protected function get mediatorMap():IMediatorMap
        {
            return (this._mediatorMap = ((this._mediatorMap) || (new MediatorMap(this.contextView, this.createChildInjector(), this.reflector))));
        }

        protected function set mediatorMap(value:IMediatorMap):void
        {
            this._mediatorMap = value;
        }

        protected function get viewMap():IViewMap
        {
            return (this._viewMap = ((this._viewMap) || (new ViewMap(this.contextView, this.injector))));
        }

        protected function set viewMap(value:IViewMap):void
        {
            this._viewMap = value;
        }

        protected function mapInjections():void
        {
            this.injector.mapValue(IReflector, this.reflector);
            this.injector.mapValue(IInjector, this.injector);
            this.injector.mapValue(IEventDispatcher, eventDispatcher);
            this.injector.mapValue(DisplayObjectContainer, this.contextView);
            this.injector.mapValue(ICommandMap, this.commandMap);
            this.injector.mapValue(IMediatorMap, this.mediatorMap);
            this.injector.mapValue(IViewMap, this.viewMap);
            this.injector.mapClass(IEventMap, EventMap);
        }

        protected function checkAutoStartup():void
        {
            if (((this._autoStartup) && (this.contextView)))
            {
                if (this.contextView.stage)
                {
                    this.startup();
                }
                else
                {
                    this.contextView.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage, false, 0, true);
                };
            };
        }

        protected function onAddedToStage(e:Event):void
        {
            this.contextView.removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            this.startup();
        }

        protected function createInjector():IInjector
        {
            var injector:IInjector = new SwiftSuspendersInjector();
            injector.applicationDomain = this.getApplicationDomainFromContextView();
            return (injector);
        }

        protected function createChildInjector():IInjector
        {
            return (this.injector.createChild(this.getApplicationDomainFromContextView()));
        }

        protected function getApplicationDomainFromContextView():ApplicationDomain
        {
            if (((this.contextView) && (this.contextView.loaderInfo)))
            {
                return (this.contextView.loaderInfo.applicationDomain);
            };
            return (ApplicationDomain.currentDomain);
        }


    }
}//package org.robotlegs.mvcs
