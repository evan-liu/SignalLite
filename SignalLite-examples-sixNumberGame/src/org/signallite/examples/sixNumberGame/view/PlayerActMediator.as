package org.signallite.examples.sixNumberGame.view
{
    import org.signallite.examples.sixNumberGame.message.GameMessage;
    import org.signallite.examples.sixNumberGame.message.PlayerActEvent;
    import org.signallite.examples.sixNumberGame.message.RoundMessage;
    import org.signallite.examples.sixNumberGame.model.PlayModel;
    import org.signallite.integrations.robotlegs.SignalMediator;

    public class PlayerActMediator extends SignalMediator
    {
        //======================================================================
        //  Dependencies
        //======================================================================
        [Inject]
        public var view:PlayerActView;
        [Inject]
        public var playModel:PlayModel;
        //======================================================================
        //  Overridden methods
        // ======================================================================
        override public function onRegister():void
        {
            bindEventToMessage(view, PlayerActEvent.PLAYER_ACT, RoundMessage.PLAYER_ACT);
            addMessageListener(GameMessage.GAME_STARTED, gameStartedHandler);

            view.fill(playModel.valueList);
        }
        //======================================================================
        //  Message handlers
        //======================================================================
        private function gameStartedHandler():void
        {
            view.reset();
        }
    }
}