package org.signallite.examples.sixNumberGame.view
{
    import org.signallite.examples.sixNumberGame.message.RoundMessage;
    import org.signallite.examples.sixNumberGame.events.PlayerActEvent;
    import org.signallite.examples.sixNumberGame.message.GameMessage;
    import org.signallite.IMessageBus;
    import org.robotlegs.mvcs.Mediator;
    import org.signallite.examples.sixNumberGame.model.PlayModel;

    public class PlayerActMediator extends Mediator
    {
        //======================================================================
        //  Dependencies
        //======================================================================
        [Inject]
        public var view:PlayerActView;
        [Inject]
        public var playModel:PlayModel;
        [Inject]
        public var messageBus:IMessageBus;
        //======================================================================
        //  Overridden methods
        // ======================================================================
        override public function onRegister():void
        {
            messageBus.bindEvent(view, PlayerActEvent.PLAYER_ACT, RoundMessage.PLAYER_ACT);

            messageBus.addListener(GameMessage.GAME_STARTED, gameStartedHandler);

            view.fill(playModel.valueList);
        }
        override public function onRemove():void
        {
            messageBus.unbindEvent(view, PlayerActEvent.PLAYER_ACT, RoundMessage.PLAYER_ACT);
            messageBus.removeListener(GameMessage.GAME_STARTED, gameStartedHandler);
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