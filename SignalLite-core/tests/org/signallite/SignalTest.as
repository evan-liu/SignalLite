package org.signallite
{
    import org.flexunit.asserts.assertEquals;
    import org.flexunit.asserts.assertTrue;
    import org.flexunit.asserts.fail;
    import org.signallite.integrations.flexunit.handleSignal;

    public class SignalTest
    {
        public var completed:Signal;
        [Before]
        public function setUp():void
        {
            completed = new Signal();
        }
        [After]
        public function tearDown():void
        {
            completed.removeAll();
            completed = null;
        }
        [Test]
        public function numListeners_is_0_after_creation():void
        {
            assertEquals(0, completed.numListeners);
        }
        [Test]
        public function addOnce_and_dispatch_should_remove_listener_automatically():void
        {
            completed.addOnce(newEmptyHandler());
            completed.dispatch();
            assertEquals('there should be no listeners', 0, completed.numListeners);
        }
        [Test]
        public function add_listener_then_remove_then_dispatch_should_not_call_listener():void
        {
            completed.add(failIfCalled);
            completed.remove(failIfCalled);
            completed.dispatch();
        }
        [Test]
        public function add_listener_then_remove_function_not_in_listeners_should_do_nothing():void
        {
            completed.add(newEmptyHandler());
            completed.remove(newEmptyHandler());
            assertEquals(1, completed.numListeners);
        }
        [Test(async)]
        public function add_2_listeners_remove_2nd_then_dispatch_should_call_1st_not_2nd_listener():void
        {
            handleSignal(this, completed, simpleHandler);
            completed.add(failIfCalled);
            completed.remove(failIfCalled);
            completed.dispatch();
        }
        [Test]
        public function add_2_listeners_should_yield_numListeners_of_2():void
        {
            completed.add(newEmptyHandler());
            completed.add(newEmptyHandler());
            assertEquals(2, completed.numListeners);
        }
        [Test]
        public function add_2_listeners_then_remove_1_should_yield_numListeners_of_1():void
        {
            var firstFunc:Function = newEmptyHandler();
            completed.add(firstFunc);
            completed.add(newEmptyHandler());

            completed.remove(firstFunc);

            assertEquals(1, completed.numListeners);
        }
        [Test]
        public function add_2_listeners_then_removeAll_should_yield_numListeners_of_0():void
        {
            completed.add(newEmptyHandler());
            completed.add(newEmptyHandler());

            completed.removeAll();

            assertEquals(0, completed.numListeners);
        }
        [Test]
        public function add_same_listener_twice_should_only_add_it_once():void
        {
            var func:Function = newEmptyHandler();
            completed.add(func);
            completed.add(func);
            assertEquals(1, completed.numListeners);
        }
        [Test]
        public function addOnce_same_listener_twice_should_only_add_it_once():void
        {
            var func:Function = newEmptyHandler();
            completed.addOnce(func);
            completed.addOnce(func);
            assertEquals(1, completed.numListeners);
        }
        [Test(async)]
        public function dispatch_2_listeners_1st_listener_removes_itself_then_2nd_listener_is_still_called():void
        {
            completed.add(selfRemover);
            // async.add verifies the second listener is called
            handleSignal(this, completed, newEmptyHandler);
            completed.dispatch();
        }
        [Test(async)]
        public function dispatch_2_listeners_1st_listener_removes_all_then_2nd_listener_is_still_called():void
        {
            handleSignal(this, completed, allRemover);
            handleSignal(this, completed, newEmptyHandler);
            completed.dispatch();
        }
        [Test]
        public function can_use_anonymous_listeners():void
        {
            var listeners:Array = [];

            for ( var i:int = 0; i < 100;  i++ )
            {
                listeners.push(completed.add(function():void
                {
                }));
            }

            assertTrue("there should be 100 listeners", completed.numListeners == 100);

            for each ( var fnt:Function in listeners )
            {
                completed.remove(fnt);
            }
            assertTrue("all anonymous listeners removed", completed.numListeners == 0);
        }
        [Test]
        public function can_use_anonymous_listeners_in_addOnce():void
        {
            var listeners:Array = [];

            for ( var i:int = 0; i < 100;  i++ )
            {
                listeners.push(completed.addOnce(function():void
                {
                }));
            }

            assertTrue("there should be 100 listeners", completed.numListeners == 100);

            for each ( var fnt:Function in listeners )
            {
                completed.remove(fnt);
            }
            assertTrue("all anonymous listeners removed", completed.numListeners == 0);
        }
        [Test(async)]
        public function adding_a_listener_during_dispatch_should_not_call_it():void
        {
            handleSignal(this, completed, addListenerDuringDispatch);
            completed.dispatch();
        }
        private function simpleHandler():void
        {
        }
        private function newEmptyHandler():Function
        {
            return function():void
            {
            };
        }
        private function failIfCalled():void
        {
            fail('This event handler should not have been called.');
        }
        private function selfRemover():void
        {
            completed.remove(selfRemover);
        }
        private function allRemover():void
        {
            completed.removeAll();
        }
        private function addListenerDuringDispatch():void
        {
            completed.add(failIfCalled);
        }
    }
}