package org.signallite.integrations.robotlegs
{
    import org.robotlegs.base.ContextError;
    import org.robotlegs.core.IInjector;
    import org.robotlegs.core.IReflector;
    import org.signallite.IMessageBus;
    import org.signallite.ISignal;
    import org.signallite.MessageType;

    import flash.utils.Dictionary;
    import flash.utils.describeType;

    public class SignalCommandMap implements ISignalCommandMap
    {
        //======================================================================
        // Constructor
        //======================================================================
        public function SignalCommandMap(injector:IInjector, reflector:IReflector, messageBus:IMessageBus)
        {
            this.injector = injector;
            this.reflector = reflector;
            this.messageBus = messageBus;

            signalMap = new Dictionary();
            signalClassMap = new Dictionary();
            typeMap = new Dictionary();
            verifiedCommandClasses = new Dictionary();
        }
        //======================================================================
        // Variables
        //======================================================================
        protected var injector:IInjector;
        protected var reflector:IReflector;
        protected var messageBus:IMessageBus;
        protected var signalMap:Dictionary;
        protected var signalClassMap:Dictionary;
        protected var typeMap:Dictionary;
        protected var verifiedCommandClasses:Dictionary;
        //======================================================================
        // Public methods: ISignalCommandMap
        //======================================================================
        public function map(type:MessageType, commandClass:Class, oneShot:Boolean = false):void
        {
            verifyCommandClass(commandClass);
            if (hasCommand(type, commandClass))
            {
                return;
            }
            if (!typeMap[type])
            {
                typeMap[type] = new Dictionary();
            }
            var typeCommandMap:Dictionary = typeMap[type];
            var callback:Function = function(signal:*, type:MessageType):void
            {
                routeTypeToCommand(signal, type, commandClass, oneShot);
            };
            typeCommandMap[commandClass] = callback;
            messageBus.addListener(type, callback);
        }
        public function hasCommand(type:MessageType, commandClass:Class):Boolean
        {
            var callbacksByCommandClass:Dictionary = typeMap[type];
            return callbacksByCommandClass && callbacksByCommandClass[commandClass];
        }
        public function unmap(type:MessageType, commandClass:Class):void
        {
            var callbacksByCommandClass:Dictionary = typeMap[type];
            if (callbacksByCommandClass == null) return;
            var callback:Function = callbacksByCommandClass[commandClass];
            if (callback == null) return;
            messageBus.removeListener(type, callback);
            delete callbacksByCommandClass[commandClass];
        }
        public function mapSignal(signal:ISignal, commandClass:Class, oneShot:Boolean = false):void
        {
            verifyCommandClass(commandClass);
            if (hasSignalCommand(signal, commandClass))
            {
                return;
            }
            if (!signalMap[signal])
            {
                signalMap[signal] = new Dictionary();
            }
            var signalCommandMap:Dictionary = signalMap[signal];
            var callback:Function = function(signal:ISignal):void
            {
                routeSignalToCommand(signal, commandClass, oneShot);
            };
            signalCommandMap[commandClass] = callback;
            signal.add(callback);
        }
        public function mapSignalClass(signalClass:Class, commandClass:Class, oneShot:Boolean = false):ISignal
        {
            var signal:ISignal = getSignalClassInstance(signalClass);
            mapSignal(signal, commandClass, oneShot);
            return signal;
        }
        public function hasSignalCommand(signal:ISignal, commandClass:Class):Boolean
        {
            var callbacksByCommandClass:Dictionary = signalMap[signal];
            return callbacksByCommandClass && callbacksByCommandClass[commandClass];
        }
        public function unmapSignal(signal:ISignal, commandClass:Class):void
        {
            var callbacksByCommandClass:Dictionary = signalMap[signal];
            if (callbacksByCommandClass == null) return;
            var callback:Function = callbacksByCommandClass[commandClass];
            if (callback == null) return;
            signal.remove(callback);
            delete callbacksByCommandClass[commandClass];
        }
        public function unmapSignalClass(signalClass:Class, commandClass:Class):void
        {
            unmapSignal(getSignalClassInstance(signalClass), commandClass);
        }
        //======================================================================
        // Protected methods
        //======================================================================
        protected function getSignalClassInstance(signalClass:Class):ISignal
        {
            return ISignal(signalClassMap[signalClass]) || createSignalClassInstance(signalClass);
        }
        protected function createSignalClassInstance(signalClass:Class):ISignal
        {
            var injectorForSignalInstance:IInjector = injector;
            var signal:ISignal;
            if (injector.hasMapping(IInjector))
                injectorForSignalInstance = injector.getInstance(IInjector);
            signal = injectorForSignalInstance.instantiate(signalClass);
            injectorForSignalInstance.mapValue(signalClass, signal);
            signalClassMap[signalClass] = signal;
            return signal;
        }
        protected function routeSignalToCommand(signal:ISignal, commandClass:Class, oneshot:Boolean):void
        {
            executeCommand(signal, commandClass);
            if (oneshot)
            {
                unmapSignal(signal, commandClass);
            }
        }
        protected function routeTypeToCommand(signal:*, type:MessageType, commandClass:Class, oneshot:Boolean):void
        {
            executeCommand(signal, commandClass);
            if (oneshot)
            {
                unmap(type, commandClass);
            }
        }
        protected function executeCommand(signal:*, commandClass:Class):void
        {
            var signalClass:Class = signal ? reflector.getClass(signal) : null;
            var needMapSignal:Boolean = signalClass && !injector.hasMapping(signalClass);
            if (needMapSignal)
            {
                injector.mapValue(signalClass, signal);
            }
            var command:Object = injector.instantiate(commandClass);
            if (needMapSignal)
            {
                injector.unmap(signalClass);
            }
            command.execute();
        }
        protected function verifyCommandClass(commandClass:Class):void
        {
            if (verifiedCommandClasses[commandClass]) return;
            if (describeType(commandClass).factory.method.(@name == "execute").length() != 1)
            {
                throw new ContextError(ContextError.E_COMMANDMAP_NOIMPL + ' - ' + commandClass);
            }
            verifiedCommandClasses[commandClass] = true;
        }
    }
}