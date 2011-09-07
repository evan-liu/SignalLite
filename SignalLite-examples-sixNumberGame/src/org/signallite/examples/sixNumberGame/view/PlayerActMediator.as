package org.signallite.examples.sixNumberGame.view
{
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
            messageBus.addListener(GameMessage.GAME_STARTED, gameStartedHandler);
            
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