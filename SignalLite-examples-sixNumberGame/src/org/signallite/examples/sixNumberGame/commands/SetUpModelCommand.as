package org.signallite.examples.sixNumberGame.commands
{
    import org.robotlegs.core.IInjector;
    import org.signallite.IMessageBus;
    import org.signallite.examples.sixNumberGame.message.GameMessage;
    import org.signallite.examples.sixNumberGame.message.RoundMessage;
    import org.signallite.examples.sixNumberGame.model.PlayModel;
    public class SetUpModelCommand
    {
        //======================================================================
        //  Dependencies
        //======================================================================
        [Inject]
        public var injector:IInjector;
        [Inject]
        public var messageBus:IMessageBus;
        //======================================================================
        //  Public methods
        //======================================================================
        public function execute():void
        {
            var playModel:PlayModel = new PlayModel();
            injector.mapValue(PlayModel, playModel);
            messageBus.bindSignal(playModel.gameEnded, GameMessage.GAME_ENDED);
            messageBus.bindSignal(playModel.roundStarted, RoundMessage.ROUND_STARTED);
            messageBus.bindSignal(playModel.roundEnded, RoundMessage.ROUND_ENDED);
            messageBus.bindSignal(playModel.centerRoundReady, RoundMessage.CENTER_ROUND_READY);
            messageBus.bindSignal(playModel.playerRoundReady, RoundMessage.PLAYER_ROUND_READY);
            messageBus.bindSignal(playModel.competitorRoundReady, RoundMessage.COMPETITOR_ROUND_READY);
        }
    }
}