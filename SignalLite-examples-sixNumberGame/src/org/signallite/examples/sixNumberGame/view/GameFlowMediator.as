package org.signallite.examples.sixNumberGame.view
{
    import org.signallite.examples.sixNumberGame.message.GameFlowEvent;
    import org.signallite.examples.sixNumberGame.message.GameMessage;
    import org.signallite.examples.sixNumberGame.message.RoundMessage;
    import org.signallite.integrations.robotlegs.SignalMediator;

    public class GameFlowMediator extends SignalMediator
    {
        //======================================================================
        //  Dependencies
        //======================================================================
        [Inject]
        public var view:GameFlowView;
        //======================================================================
        //  Overridden methods
        // ======================================================================
        override public function onRegister():void
        {
            view.showStart();

            bindEventToMessage(view, GameFlowEvent.START_GAME, GameMessage.GAME_STARTED);
            bindEventToMessage(view, GameFlowEvent.RESTART_GAME, GameMessage.GAME_STARTED);

            addMessageListener(RoundMessage.ROUND_STARTED, roundStartedHandler);
            addMessageListener(GameMessage.GAME_ENDED, gameEndedHandler);
        }
        //======================================================================
        //  Message handlers
        //======================================================================
        private function roundStartedHandler():void
        {
            view.showPlaying();
        }
        private function gameEndedHandler():void
        {
            view.showEnd();
        }
    }
}