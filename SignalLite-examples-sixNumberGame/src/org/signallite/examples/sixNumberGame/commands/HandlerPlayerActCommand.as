package org.signallite.examples.sixNumberGame.commands
{
    import org.signallite.examples.sixNumberGame.model.PlayModel;
    import org.signallite.examples.sixNumberGame.events.PlayerActEvent;
    public class HandlerPlayerActCommand
    {
        //======================================================================
        //  Dependencies
        //======================================================================
        [Inject]
        public var triggerEvent:PlayerActEvent;
        [Inject]
        public var model:PlayModel;
        //======================================================================
        //  Public methods
        //======================================================================
        public function execute():void
        {
            model.actPlayerRound(triggerEvent.value);
        }
    }
}