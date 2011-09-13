package org.signallite.integrations.robotlegs
{
    import org.flexunit.asserts.assertEquals;
    import org.signallite.MessageBus;
    import org.signallite.MessageType;
    import org.signallite.Signal;

    import flash.events.Event;
    import flash.events.EventDispatcher;
    public class SignalMediatorTest
    {
        //======================================================================
        //  Variables
        //======================================================================
        private var instance:SignalMediator;
        private var messageBus:MessageBus;
        private var eventDispatcher:EventDispatcher;
        private var signal:Signal;
        private var type:MessageType = new MessageType();

        private var calledCount:int = 0;
        //======================================================================
        //  Fixture methods
        //======================================================================
        [Before]
        public function setUp():void
        {
            messageBus = new MessageBus();
            eventDispatcher = new EventDispatcher();
            signal = new Signal();
            instance = new SignalMediator();
            instance.messageBus = messageBus;
            calledCount = 0;
        }
        [After]
        public function tearDown():void
        {
            instance = null;
        }
        //======================================================================
        //  Test methods
        //======================================================================
        [Test]
        public function test_dispatchMessage():void
        {
            messageBus.addListener(type, listener);
            instance.dispatchMessage(type);
            assertEquals(1, calledCount);
            instance.dispatchMessage(type);
            assertEquals(2, calledCount);
        }
        [Test]
        public function test_addMessageListener():void
        {
            instance.addMessageListener(type, listener);
            messageBus.dispatch(type);
            assertEquals(1, calledCount);
            messageBus.dispatch(type);
            assertEquals(2, calledCount);
        }
        [Test]
        public function test_addMessageListenerOnce():void
        {
            instance.addMessageListenerOnce(type, listener);
            messageBus.dispatch(type);
            assertEquals(1, calledCount);
            messageBus.dispatch(type);
            assertEquals(1, calledCount);
        }
        [Test]
        public function test_removeMessageListener():void
        {
            instance.addMessageListener(type, listener);
            instance.removeMessageListener(type, listener);
            messageBus.dispatch(type);
            assertEquals(0, calledCount);

            instance.addMessageListenerOnce(type, listener);
            instance.removeMessageListener(type, listener);
            messageBus.dispatch(type);
            assertEquals(0, calledCount);
        }
        [Test]
        public function test_addSignalListener():void
        {
            instance.addSignalListener(signal, listener);
            signal.dispatch();
            assertEquals(1, calledCount);
            signal.dispatch();
            assertEquals(2, calledCount);
        }
        [Test]
        public function test_addSignalListenerOnce():void
        {
            instance.addSignalListenerOnce(signal, listener);
            signal.dispatch();
            assertEquals(1, calledCount);
            signal.dispatch();
            assertEquals(1, calledCount);
        }
        [Test]
        public function test_addEventListener():void
        {
            instance.addEventListener(eventDispatcher, "test", listener);
            eventDispatcher.dispatchEvent(new Event("test"));
            assertEquals(1, calledCount);
            eventDispatcher.dispatchEvent(new Event("test"));
            assertEquals(2, calledCount);
        }
        [Test]
        public function test_bindEventToMessage():void
        {
            instance.addMessageListener(type, listener);
            instance.bindEventToMessage(eventDispatcher, "test", type);
            eventDispatcher.dispatchEvent(new Event("test"));
            assertEquals(1, calledCount);
            eventDispatcher.dispatchEvent(new Event("test"));
            assertEquals(2, calledCount);
        }
        [Test]
        public function test_unbindEventToMessage():void
        {
            instance.addMessageListener(type, listener);
            instance.bindEventToMessage(eventDispatcher, "test", type);
            instance.unbindEventToMessage(eventDispatcher, "test", type);
            eventDispatcher.dispatchEvent(new Event("test"));
            assertEquals(0, calledCount);
        }
        [Test]
        public function test_bindSignalToMessage():void
        {
            instance.addMessageListener(type, listener);
            instance.bindSignalToMessage(signal, type);
            signal.dispatch();
            assertEquals(1, calledCount);
            signal.dispatch();
            assertEquals(2, calledCount);
        }
        [Test]
        public function test_unbindSignalToMessage():void
        {
            instance.addMessageListener(type, listener);
            instance.bindSignalToMessage(signal, type);
            instance.unbindSignalToMessage(signal, type);
            signal.dispatch();
            assertEquals(0, calledCount);
        }
        [Test]
        public function test_addMessageListener_clean_when_remove():void
        {
            instance.addMessageListener(type, listener);
            instance.preRemove();
            messageBus.dispatch(type);
            assertEquals(0, calledCount);
        }
        [Test]
        public function test_addMessageListenerOnce_clean_when_remove():void
        {
            instance.addMessageListenerOnce(type, listener);
            instance.preRemove();
            messageBus.dispatch(type);
            assertEquals(0, calledCount);
        }
        [Test]
        public function test_addSignalListener_clean_when_remove():void
        {
            instance.addSignalListener(signal, listener);
            instance.preRemove();
            signal.dispatch();
            assertEquals(0, calledCount);
        }
        [Test]
        public function test_addSignalListenerOnce_clean_when_remove():void
        {
            instance.addSignalListenerOnce(signal, listener);
            instance.preRemove();
            signal.dispatch();
            assertEquals(0, calledCount);
        }
        [Test]
        public function test_addEventListener_clean_when_remove():void
        {
            instance.addEventListener(eventDispatcher, "test", listener);
            instance.preRemove();
            eventDispatcher.dispatchEvent(new Event("test"));
            assertEquals(0, calledCount);
        }
        [Test]
        public function test_bindEventToMessage_clean_when_remove():void
        {
            instance.addMessageListener(type, listener);
            instance.bindEventToMessage(eventDispatcher, "test", type);
            instance.preRemove();
            eventDispatcher.dispatchEvent(new Event("test"));
            assertEquals(0, calledCount);
        }
        [Test]
        public function test_bindSignalToMessage_clean_when_remove():void
        {
            instance.addMessageListener(type, listener);
            instance.bindSignalToMessage(signal, type);
            instance.preRemove();
            signal.dispatch();
            assertEquals(0, calledCount);
        }
        //======================================================================
        //  Support methods
        //======================================================================
        protected function listener(...args):void
        {
            calledCount++;
        }
    }
}