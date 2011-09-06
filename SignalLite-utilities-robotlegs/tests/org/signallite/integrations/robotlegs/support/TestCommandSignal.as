package org.signallite.integrations.robotlegs.support
{
    import org.signallite.Signal;

    public class TestCommandSignal extends Signal
    {
        public function TestCommandSignal(target:Object = null)
        {
            super(target);
        }
        public var wasExecuted:Boolean;
    }
}