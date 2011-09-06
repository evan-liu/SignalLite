package org.signallite.integrations.robotlegs
{
    import org.flexunit.asserts.assertEquals;
    import org.flexunit.asserts.assertFalse;
    import org.flexunit.asserts.assertTrue;
    import org.robotlegs.adapters.SwiftSuspendersInjector;
    import org.robotlegs.adapters.SwiftSuspendersReflector;
    import org.robotlegs.core.IInjector;
    import org.robotlegs.core.IReflector;
    import org.signallite.ISignal;
    import org.signallite.MessageBus;
    import org.signallite.MessageType;
    import org.signallite.integrations.robotlegs.support.SignalInjectTestClass;
    import org.signallite.integrations.robotlegs.support.TestCommandEvent;
    import org.signallite.integrations.robotlegs.support.TestCommandSignal;
    import org.signallite.integrations.robotlegs.support.TestConstructorInjectCommand;
    import org.signallite.integrations.robotlegs.support.TestInjectEventCommand;
    import org.signallite.integrations.robotlegs.support.TestInjectSignalCommand;
    import org.signallite.integrations.robotlegs.support.TestNoExecuteCommand;
    import org.signallite.integrations.robotlegs.support.TestNotInjectSignalCommand;

    public class SignalCommandMapTest
    {
        //======================================================================
        // Variables
        //======================================================================
        private var signalCommandMap:ISignalCommandMap;
        private var injector:IInjector;
        private var reflector:IReflector;
        private var signalBus:MessageBus;
        private var signal:TestCommandSignal;
        private var signalType:MessageType;
        private var event:TestCommandEvent;
        private var eventType:MessageType;
        //======================================================================
        // Fixture methods
        //======================================================================
        [Before]
        public function setup():void
        {
            injector = new SwiftSuspendersInjector();
            reflector = new SwiftSuspendersReflector();
            signalBus = new MessageBus();
            signalCommandMap = new SignalCommandMap(injector, reflector, signalBus);
            signal = new TestCommandSignal();
            signalType = new MessageType(TestCommandSignal);
            event = new TestCommandEvent();
            eventType = new MessageType(TestCommandEvent);
        }
        [After]
        public function teardown():void
        {
            injector = null;
            reflector = null;
            signalCommandMap = null;
        }
        //======================================================================
        // Test methods
        //======================================================================
        [Test]
        public function mapping_signal_creates_command_mapping():void
        {
            signalCommandMap.mapSignal(signal, TestNotInjectSignalCommand);
            assertTrue(signalCommandMap.hasSignalCommand(signal, TestNotInjectSignalCommand));
        }
        [Test(expects="org.robotlegs.base.ContextError")]
        public function mapping_class_with_no_execute_throws_error():void
        {
            signalCommandMap.mapSignal(signal, TestNoExecuteCommand);
        }
        [Test]
        public function unmapping_signal_removes_command_mapping():void
        {
            signalCommandMap.mapSignal(signal, TestNotInjectSignalCommand);
            signalCommandMap.unmapSignal(signal, TestNotInjectSignalCommand);
            assertFalse(signalCommandMap.hasSignalCommand(signal, TestNotInjectSignalCommand));
        }
        [Test]
        public function dispatch_signal_executes_command():void
        {
            signalCommandMap.mapSignal(signal, TestInjectSignalCommand);
            signal.dispatch();
            assertTrue(signal.wasExecuted);
        }
        [Test]
        public function command_can_be_executed_multiple_times():void
        {
            signalCommandMap.mapSignal(signal, TestInjectSignalCommand);
            signal.dispatch();
            signal.wasExecuted = false;
            signal.dispatch();
            assertTrue(signal.wasExecuted);
        }
        [Test]
        public function command_receives_constructor_dependency_from_signal_dispatch():void
        {
            signalCommandMap.mapSignal(signal, TestConstructorInjectCommand);
            signal.dispatch();
            assertTrue(signal.wasExecuted);
        }
        [Test]
        public function one_shot_command_only_executes_once():void
        {
            signalCommandMap.mapSignal(signal, TestInjectSignalCommand, true);
            signal.dispatch();
            assertTrue(signal.wasExecuted);
            signal.wasExecuted = false;
            signal.dispatch();

            assertFalse(signal.wasExecuted);
        }
        [Test]
        public function mapping_signal_class_returns_instance():void
        {
            var signal:ISignal = signalCommandMap.mapSignalClass(TestCommandSignal, TestNotInjectSignalCommand);
            assertTrue(signal is ISignal);
        }
        [Test]
        public function signal_mapped_as_class_maps_signal_instance_with_injector():void
        {
            var signal:ISignal = signalCommandMap.mapSignalClass(TestCommandSignal, TestNotInjectSignalCommand);
            var signalTwo:ISignal = injector.instantiate(SignalInjectTestClass).signal;
            assertEquals(signal, signalTwo);
        }
        [Test]
        public function mapping_signal_class_twice_returns_same_signal_instance():void
        {
            var signalOne:ISignal = signalCommandMap.mapSignalClass(TestCommandSignal, TestNotInjectSignalCommand);
            var signalTwo:ISignal = signalCommandMap.mapSignalClass(TestCommandSignal, TestInjectSignalCommand);
            assertEquals(signalOne, signalTwo);
        }
        [Test]
        public function map_signal_class_creates_command_mapping():void
        {
            var signal:ISignal = signalCommandMap.mapSignalClass(TestCommandSignal, TestNotInjectSignalCommand);
            assertTrue(signalCommandMap.hasSignalCommand(signal, TestNotInjectSignalCommand));
        }
        [Test]
        public function unmap_signal_class_removes_command_mapping():void
        {
            var signal:ISignal = signalCommandMap.mapSignalClass(TestCommandSignal, TestNotInjectSignalCommand);
            signalCommandMap.unmapSignalClass(TestCommandSignal, TestNotInjectSignalCommand);
            assertFalse(signalCommandMap.hasSignalCommand(signal, TestNotInjectSignalCommand));
        }
        [Test]
        public function mapType():void
        {
            signalCommandMap.map(signalType, TestNotInjectSignalCommand);
            assertTrue(signalCommandMap.hasCommand(signalType, TestNotInjectSignalCommand));
        }
        [Test]
        public function unmapType():void
        {
            signalCommandMap.map(signalType, TestNotInjectSignalCommand);
            signalCommandMap.unmap(signalType, TestNotInjectSignalCommand);
            assertFalse(signalCommandMap.hasCommand(signalType, TestNotInjectSignalCommand));
        }
        [Test]
        public function signal_trigger_type_command():void
        {
            signalCommandMap.map(signalType, TestInjectSignalCommand);
            signalBus.dispatch(signalType, signal);
            assertTrue(signal.wasExecuted);
        }
        [Test]
        public function event_trigger_type_command():void
        {
            signalCommandMap.map(eventType, TestInjectEventCommand);
            signalBus.dispatch(eventType, event);
            assertTrue(event.wasExecuted);
        }
        [Test]
        public function map_type_once():void
        {
            signalCommandMap.map(signalType, TestInjectSignalCommand, true);

            assertTrue(signalCommandMap.hasCommand(signalType, TestInjectSignalCommand));

            signalBus.dispatch(signalType, signal);
            assertTrue(signal.wasExecuted);

            assertFalse(signalCommandMap.hasCommand(signalType, TestInjectSignalCommand));
        }
    }
}
