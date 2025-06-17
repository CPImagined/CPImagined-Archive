//Created by Action Script Viewer - https://www.buraks.com/asv
package org.robotlegs.base
{
    import org.robotlegs.core.ISignalCommandMap;
    import org.robotlegs.core.IInjector;
    import flash.utils.Dictionary;
    import org.osflash.signals.ISignal;
    import flash.utils.describeType;

    public class SignalCommandMap implements ISignalCommandMap 
    {

        protected var injector:IInjector;
        protected var signalMap:Dictionary;
        protected var signalClassMap:Dictionary;
        protected var verifiedCommandClasses:Dictionary;

        public function SignalCommandMap(injector:IInjector)
        {
            this.injector = injector;
            this.signalMap = new Dictionary(false);
            this.signalClassMap = new Dictionary(false);
            this.verifiedCommandClasses = new Dictionary(false);
        }

        public function mapSignal(signal:ISignal, commandClass:Class, oneShot:Boolean=false):void
        {
            this.verifyCommandClass(commandClass);
            if (this.hasSignalCommand(signal, commandClass))
            {
                return;
            };
            var signalCommandMap:Dictionary = (this.signalMap[signal] = ((this.signalMap[signal]) || (new Dictionary(false))));
            var callback:Function = function (a:*=null, b:*=null, c:*=null, d:*=null, e:*=null, f:*=null, g:*=null):void
            {
                routeSignalToCommand(signal, arguments, commandClass, oneShot);
            };
            signalCommandMap[commandClass] = callback;
            signal.add(callback);
        }

        public function mapSignalClass(signalClass:Class, commandClass:Class, oneShot:Boolean=false):ISignal
        {
            var signal:ISignal = this.getSignalClassInstance(signalClass);
            this.mapSignal(signal, commandClass, oneShot);
            return (signal);
        }

        private function getSignalClassInstance(signalClass:Class):ISignal
        {
            return ((ISignal(this.signalClassMap[signalClass])) || (this.createSignalClassInstance(signalClass)));
        }

        private function createSignalClassInstance(signalClass:Class):ISignal
        {
            var signal:ISignal;
            var injectorForSignalInstance:IInjector = this.injector;
            if (this.injector.hasMapping(IInjector))
            {
                injectorForSignalInstance = this.injector.getInstance(IInjector);
            };
            signal = injectorForSignalInstance.instantiate(signalClass);
            injectorForSignalInstance.mapValue(signalClass, signal);
            this.signalClassMap[signalClass] = signal;
            return (signal);
        }

        public function hasSignalCommand(signal:ISignal, commandClass:Class):Boolean
        {
            var callbacksByCommandClass:Dictionary = this.signalMap[signal];
            if (callbacksByCommandClass == null)
            {
                return (false);
            };
            var callback:Function = callbacksByCommandClass[commandClass];
            return (!(callback == null));
        }

        public function unmapSignal(signal:ISignal, commandClass:Class):void
        {
            var callbacksByCommandClass:Dictionary = this.signalMap[signal];
            if (callbacksByCommandClass == null)
            {
                return;
            };
            var callback:Function = callbacksByCommandClass[commandClass];
            if (callback == null)
            {
                return;
            };
            signal.remove(callback);
            delete callbacksByCommandClass[commandClass];
        }

        public function unmapSignalClass(signalClass:Class, commandClass:Class):void
        {
            this.unmapSignal(this.getSignalClassInstance(signalClass), commandClass);
        }

        protected function routeSignalToCommand(signal:ISignal, valueObjects:Array, commandClass:Class, oneshot:Boolean):void
        {
            this.createCommandInstance(signal.valueClasses, valueObjects, commandClass).execute();
            if (oneshot)
            {
                this.unmapSignal(signal, commandClass);
            };
        }

        protected function createCommandInstance(valueClasses:Array, valueObjects:Array, commandClass:Class):Object
        {
            var i:uint;
            while (i < valueClasses.length)
            {
                this.injector.mapValue(valueClasses[i], valueObjects[i]);
                i++;
            };
            return (this.injector.instantiate(commandClass));
        }

        protected function verifyCommandClass(commandClass:Class):void
        {
            if (this.verifiedCommandClasses[commandClass])
            {
                return;
            };
            if (describeType(commandClass).factory.method.(@name == "execute").length() != 1)
            {
                throw (new ContextError(((ContextError.E_COMMANDMAP_NOIMPL + " - ") + commandClass)));
            };
            this.verifiedCommandClasses[commandClass] = true;
        }


    }
}//package org.robotlegs.base
