package org.signallite.integrations.robotlegs.support
{
    public class TestConstructorInjectCommand
    {
        public var triggerSignal:TestCommandSignal;
        public function TestConstructorInjectCommand(triggerSignal:TestCommandSignal)
        {
            this.triggerSignal = triggerSignal;
        }
        public function execute():void
        {
            triggerSignal.wasExecuted = true;
        }
    }
}
