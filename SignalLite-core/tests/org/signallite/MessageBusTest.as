package org.signallite
{
    import org.flexunit.asserts.assertEquals;
    import org.flexunit.asserts.assertTrue;

    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;
    import flash.events.MouseEvent;

    public class MessageBusTest
    {
        //======================================================================
        // Variables
        //======================================================================
        private var instance:MessageBus;
        private var signal:Signal;
        private var typeForSignal:MessageType;
        private var eventDispatcher:IEventDispatcher;
        private var event:Event;
        private var typeForEvent:MessageType;
        private var callCount:int = 0;
        //======================================================================
        // Fixture methods
        //======================================================================
        [Before]
        public function setUp():void
        {
            instance = new MessageBus();

            signal = new Signal();
            typeForSignal = new MessageType(ISignal);
            instance.bindSignal(signal, typeForSignal);

            event = new MouseEvent(MouseEvent.CLICK);
            eventDispatcher = new EventDispatcher();
            typeForEvent = new MessageType(MouseEvent);
            instance.bindEvent(eventDispatcher, event.type, typeForEvent);

            callCount = 0;
        }
        [After]
        public function tearDown():void
        {
            instance = null;
        }
        //======================================================================
        // Test methods
        //======================================================================
        //------------------------------
        // Add / Remove
        //------------------------------
        [Test]
        public function addListener():void
        {
            instance.addListener(typeForSignal, function(s:ISignal):void
            {
                assertEquals(signal, s);
            });
            instance.addListener(typeForSignal, function(s:ISignal, t:MessageType):void
            {
                assertEquals(signal, s);
                assertEquals(typeForSignal, t);
            });

            instance.addListener(typeForSignal, listener);
            signal.dispatch();

            assertEquals(1, callCount);
        }
        [Test]
        public function addListenerOnce():void
        {
            instance.addListenerOnce(typeForSignal, listener);
            signal.dispatch();
            assertEquals(1, callCount);
            signal.dispatch();
            assertEquals(1, callCount);
        }
        [Test]
        public function removeListener():void
        {
            instance.addListener(typeForSignal, listener);
            signal.dispatch();

            assertEquals(1, callCount);

            instance.removeListener(typeForSignal, listener);

            signal.dispatch();
            assertEquals(1, callCount);
        }
        [Test]
        public function addListener_then_removeListener():void
        {
            instance.addListener(typeForSignal, listener);
            instance.removeListener(typeForSignal, listener);

            signal.dispatch();

            assertEquals(0, callCount);
        }
        [Test]
        public function unbindSignal():void
        {
            instance.addListener(typeForSignal, listener);
            signal.dispatch();

            assertEquals(1, callCount);

            instance.unbindSignal(signal, typeForSignal);

            signal.dispatch();
            assertEquals(1, callCount);
        }
        //------------------------------
        // Add twice
        //------------------------------
        [Test]
        public function addListener_twice_call_once():void
        {
            instance.addListener(typeForSignal, listener);
            instance.addListener(typeForSignal, listener);
            signal.dispatch();
            assertEquals(1, callCount);
        }
        [Test]
        public function addListenerOnce_twice_call_once():void
        {
            instance.addListenerOnce(typeForSignal, listener);
            instance.addListenerOnce(typeForSignal, listener);
            signal.dispatch();
            assertEquals(1, callCount);
        }
        //------------------------------
        // Errors
        //------------------------------
        [Test(expects="flash.errors.IllegalOperationError")]
        public function signal_class_error():void
        {
            instance.bindSignal(new Signal(), new MessageType(ProgressSignal));
        }
        [Test(expects="flash.errors.IllegalOperationError")]
        public function addOnce_then_add_error():void
        {
            instance.addListenerOnce(typeForSignal, listener);
            instance.addListener(typeForSignal, listener);
        }
        [Test(expects="flash.errors.IllegalOperationError")]
        public function add_then_addOnce_error():void
        {
            instance.addListener(typeForSignal, listener);
            instance.addListenerOnce(typeForSignal, listener);
        }
        //------------------------------
        // Events
        //------------------------------
        [Test]
        public function bindEvent():void
        {
            instance.addListener(typeForEvent, listener);

            eventDispatcher.dispatchEvent(event);
            assertEquals(1, callCount);
        }
        [Test]
        public function unbindEvent():void
        {
            instance.addListener(typeForEvent, listener);

            instance.unbindEvent(eventDispatcher, event.type, typeForEvent);

            eventDispatcher.dispatchEvent(event);
            assertEquals(0, callCount);
        }
        //------------------------------
        // dispatchType
        //------------------------------
        [Test]
        public function dispatch_event_directly():void
        {
            instance.addListenerOnce(typeForEvent, listener);

            instance.dispatch(typeForEvent, event);
            instance.dispatch(typeForEvent, event);

            assertEquals(1, callCount);
        }
        [Test]
        public function dispatch_signal_directly():void
        {
            instance.addListenerOnce(typeForSignal, listener);

            instance.dispatch(typeForSignal, signal);
            instance.dispatch(typeForSignal, signal);

            assertEquals(1, callCount);
        }
        //======================================================================
        // Support methods
        //======================================================================
        private function listener(signal:*, type:MessageType):void
        {
            assertTrue(signal is type.messageClass);
            callCount++;
        }
    }
}