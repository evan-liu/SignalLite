package org.signallite.integrations.robotlegs.support
{
    public class TestInjectEventCommand
    {
        //======================================================================
        // Dependencies
        //======================================================================
        [Inject]
        public var triggerEvent:TestCommandEvent;
        //======================================================================
        // Public methods
        //======================================================================
        public function execute():void
        {
            triggerEvent.wasExecuted = true;
        }
    }
}