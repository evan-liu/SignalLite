package org.signallite.integrations.robotlegs.support
{
    import flash.events.Event;

    public class TestCommandEvent extends Event
    {
        //======================================================================
        // Constructor
        //======================================================================
        public function TestCommandEvent()
        {
            super("testCommand");
        }
        //======================================================================
        // Properties
        //======================================================================
        public var wasExecuted:Boolean = false;
    }
}