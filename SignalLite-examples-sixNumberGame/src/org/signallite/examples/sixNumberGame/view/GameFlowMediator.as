package org.signallite.examples.sixNumberGame.view
{
    import org.robotlegs.mvcs.Mediator;
    import org.signallite.IMessageBus;
    import org.signallite.examples.sixNumberGame.events.GameFlowEvent;
    import org.signallite.examples.sixNumberGame.message.GameMessage;
    import org.signallite.examples.sixNumberGame.message.RoundMessage;

    public class GameFlowMediator extends Mediator
    {
        //======================================================================
        //  Dependencies
        //======================================================================
        [Inject]
        public var view:GameFlowView;
        [Inject]
        public var messageBus:IMessageBus;
        //======================================================================
        //  Overridden methods
        // ======================================================================
        override public function onRegister():void
        {
            view.showStart();

            messageBus.bindEvent(view, GameFlowEvent.START_GAME, GameMessage.GAME_STARTED);
            messageBus.bindEvent(view, GameFlowEvent.RESTART_GAME, GameMessage.GAME_STARTED);

            messageBus.addListener(RoundMessage.ROUND_STARTED, roundStartedHandler);
        }
        override public function onRemove():void
        {
            messageBus.unbindEvent(view, GameFlowEvent.START_GAME, GameMessage.GAME_STARTED);
            messageBus.unbindEvent(view, GameFlowEvent.RESTART_GAME, GameMessage.GAME_STARTED);
        }
        //======================================================================
        //  Message handlers
        //======================================================================
        private function roundStartedHandler():void
        {
            view.showPlaying();
        }
    }
}