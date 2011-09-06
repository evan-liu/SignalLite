package org.signallite
{
    import org.flexunit.asserts.assertEquals;
    import org.signallite.integrations.flexunit.handleSignal;

    public class ProgressSignalTest
    {
        private var signal:ProgressSignal;
        [Before]
        public function setUp():void
        {
            signal = new ProgressSignal(this);
        }
        [Test(async)]
        public function value_only():void
        {
            handleSignal(this, signal, verifyValueOnly);
            signal.dispatch(0.3);
        }
        private function verifyValueOnly():void
        {
            assertEquals(this, signal.target);
            assertEquals(0.3, signal.value);
        }
        [Test(async)]
        public function value_and_detail():void
        {
            handleSignal(this, signal, verifyDetail);
            signal.dispatch(0.4, 2, 5);
        }
        private function verifyDetail():void
        {
            assertEquals(0.4, signal.value);
            assertEquals(2, signal.current);
            assertEquals(5, signal.total);
        }
    }
}