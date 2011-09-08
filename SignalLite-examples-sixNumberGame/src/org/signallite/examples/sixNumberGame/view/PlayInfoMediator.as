package org.signallite.examples.sixNumberGame.view
{
    import org.robotlegs.mvcs.Mediator;
    import org.signallite.IMessageBus;
    import org.signallite.examples.sixNumberGame.message.GameMessage;
    import org.signallite.examples.sixNumberGame.message.PlayActSignal;
    import org.signallite.examples.sixNumberGame.message.PlayResultSignal;
    import org.signallite.examples.sixNumberGame.message.RoundMessage;
    import org.signallite.examples.sixNumberGame.model.PlayModel;

    public class PlayInfoMediator extends Mediator
    {
        //======================================================================
        //  Dependencies
        //======================================================================
        [Inject]
        public var view:PlayInfoView;
        [Inject]
        public var messageBus:IMessageBus;
        [Inject]
        public var model:PlayModel;
        //======================================================================
        //  Overridden methods
        //======================================================================
        override public function onRegister():void
        {
            messageBus.addListener(RoundMessage.ROUND_STARTED, roundStartedHandler);
            messageBus.addListener(RoundMessage.CENTER_ROUND_READY, centerRoundReadyHandler);
            messageBus.addListener(RoundMessage.ROUND_ENDED, roundEndedHandler);
            messageBus.addListener(GameMessage.GAME_ENDED, gameEndedHandler);
        }
        override public function onRemove():void
        {
            messageBus.removeListener(RoundMessage.ROUND_STARTED, roundStartedHandler);
            messageBus.removeListener(RoundMessage.CENTER_ROUND_READY, centerRoundReadyHandler);
            messageBus.removeListener(RoundMessage.ROUND_ENDED, roundEndedHandler);
            messageBus.removeListener(GameMessage.GAME_ENDED, gameEndedHandler);
        }
        //======================================================================
        //  Message handlers
        //======================================================================
        private function roundStartedHandler():void
        {
            view.renderRoundStart(model.roundNumber);
        }
        private function centerRoundReadyHandler(signal:PlayActSignal):void
        {
            view.renderCenterRoundAction(signal.value);
        }
        private function roundEndedHandler(signal:PlayResultSignal):void
        {
            view.renderRoundResult(signal.result, model.roundNumber, model.centerRoundValue,
                                   model.competitorRoundValue, model.playerRoundValue);
            view.renderScore(model.playerGameValue, model.competitorGameValue);
            view.renderOut(model.centerOutValue, model.competitorOutValue, model.playerOutValue);
        }
        private function gameEndedHandler(signal:PlayResultSignal):void
        {
            view.renderGameResult(signal.result);
        }
    }
}