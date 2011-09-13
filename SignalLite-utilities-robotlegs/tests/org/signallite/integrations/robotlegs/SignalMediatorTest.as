package org.signallite.integrations.robotlegs
{
    import org.flexunit.asserts.assertEquals;
    import org.signallite.MessageBus;
    import org.signallite.MessageType;
    import org.signallite.Signal;

    import flash.events.Event;
    import flash.events.EventDispatcher;
    public class SignalMediatorTest extends SignalMediator
    {
        //======================================================================
        //  Variables
        //======================================================================
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
            calledCount = 0;
        }
        [After]
        public function tearDown():void
        {
            cleanFunctionList = cleanFunctionList.slice(0, 0);
        }
        //======================================================================
        //  Test methods
        //======================================================================
        [Test]
        public function test_dispatchMessage():void
        {
            messageBus.addListener(type, listener);
            dispatchMessage(type);
            assertEquals(1, calledCount);
            dispatchMessage(type);
            assertEquals(2, calledCount);
        }
        [Test]
        public function test_addMessageListener():void
        {
            addMessageListener(type, listener);
            messageBus.dispatch(type);
            assertEquals(1, calledCount);
            messageBus.dispatch(type);
            assertEquals(2, calledCount);
        }
        [Test]
        public function test_addMessageListenerOnce():void
        {
            addMessageListenerOnce(type, listener);
            messageBus.dispatch(type);
            assertEquals(1, calledCount);
            messageBus.dispatch(type);
            assertEquals(1, calledCount);
        }
        [Test]
        public function test_removeMessageListener():void
        {
            addMessageListener(type, listener);
            removeMessageListener(type, listener);
            messageBus.dispatch(type);
            assertEquals(0, calledCount);

            addMessageListenerOnce(type, listener);
            removeMessageListener(type, listener);
            messageBus.dispatch(type);
            assertEquals(0, calledCount);
        }
        [Test]
        public function test_addSignalListener():void
        {
            addSignalListener(signal, listener);
            signal.dispatch();
            assertEquals(1, calledCount);
            signal.dispatch();
            assertEquals(2, calledCount);
        }
        [Test]
        public function test_addSignalListenerOnce():void
        {
            addSignalListenerOnce(signal, listener);
            signal.dispatch();
            assertEquals(1, calledCount);
            signal.dispatch();
            assertEquals(1, calledCount);
        }
        [Test]
        public function test_addEventListener():void
        {
            addEventListener(eventDispatcher, "test", listener);
            eventDispatcher.dispatchEvent(new Event("test"));
            assertEquals(1, calledCount);
            eventDispatcher.dispatchEvent(new Event("test"));
            assertEquals(2, calledCount);
        }
        [Test]
        public function test_bindEventToMessage():void
        {
            addMessageListener(type, listener);
            bindEventToMessage(eventDispatcher, "test", type);
            eventDispatcher.dispatchEvent(new Event("test"));
            assertEquals(1, calledCount);
            eventDispatcher.dispatchEvent(new Event("test"));
            assertEquals(2, calledCount);
        }
        [Test]
        public function test_unbindEventToMessage():void
        {
            addMessageListener(type, listener);
            bindEventToMessage(eventDispatcher, "test", type);
            unbindEventToMessage(eventDispatcher, "test", type);
            eventDispatcher.dispatchEvent(new Event("test"));
            assertEquals(0, calledCount);
        }
        [Test]
        public function test_bindSignalToMessage():void
        {
            addMessageListener(type, listener);
            bindSignalToMessage(signal, type);
            signal.dispatch();
            assertEquals(1, calledCount);
            signal.dispatch();
            assertEquals(2, calledCount);
        }
        [Test]
        public function test_unbindSignalToMessage():void
        {
            addMessageListener(type, listener);
            bindSignalToMessage(signal, type);
            unbindSignalToMessage(signal, type);
            signal.dispatch();
            assertEquals(0, calledCount);
        }
        [Test]
        public function test_addMessageListener_clean_when_remove():void
        {
            addMessageListener(type, listener);
            preRemove();
            messageBus.dispatch(type);
            assertEquals(0, calledCount);
        }
        [Test]
        public function test_addMessageListenerOnce_clean_when_remove():void
        {
            addMessageListenerOnce(type, listener);
            preRemove();
            messageBus.dispatch(type);
            assertEquals(0, calledCount);
        }
        [Test]
        public function test_addSignalListener_clean_when_remove():void
        {
            addSignalListener(signal, listener);
            preRemove();
            signal.dispatch();
            assertEquals(0, calledCount);
        }
        [Test]
        public function test_addSignalListenerOnce_clean_when_remove():void
        {
            addSignalListenerOnce(signal, listener);
            preRemove();
            signal.dispatch();
            assertEquals(0, calledCount);
        }
        [Test]
        public function test_addEventListener_clean_when_remove():void
        {
            addEventListener(eventDispatcher, "test", listener);
            preRemove();
            eventDispatcher.dispatchEvent(new Event("test"));
            assertEquals(0, calledCount);
        }
        [Test]
        public function test_bindEventToMessage_clean_when_remove():void
        {
            addMessageListener(type, listener);
            bindEventToMessage(eventDispatcher, "test", type);
            preRemove();
            eventDispatcher.dispatchEvent(new Event("test"));
            assertEquals(0, calledCount);
        }
        [Test]
        public function test_bindSignalToMessage_clean_when_remove():void
        {
            addMessageListener(type, listener);
            bindSignalToMessage(signal, type);
            preRemove();
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