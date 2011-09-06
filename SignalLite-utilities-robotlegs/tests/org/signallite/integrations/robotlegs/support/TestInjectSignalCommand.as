package org.signallite.integrations.robotlegs.support
{
    public class TestInjectSignalCommand
    {
        [Inject]
        public var triggerSignal:TestCommandSignal;
        public function execute():void
        {
            triggerSignal.wasExecuted = true;
        }
    }
}