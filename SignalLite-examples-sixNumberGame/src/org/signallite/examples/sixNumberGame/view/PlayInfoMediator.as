package org.signallite.examples.sixNumberGame.view
{
    import org.signallite.examples.sixNumberGame.message.GameMessage;
    import org.signallite.examples.sixNumberGame.message.PlayActSignal;
    import org.signallite.examples.sixNumberGame.message.PlayResultSignal;
    import org.signallite.examples.sixNumberGame.message.RoundMessage;
    import org.signallite.examples.sixNumberGame.model.PlayModel;
    import org.signallite.integrations.robotlegs.SignalMediator;

    public class PlayInfoMediator extends SignalMediator
    {
        //======================================================================
        //  Dependencies
        //======================================================================
        [Inject]
        public var view:PlayInfoView;
        [Inject]
        public var model:PlayModel;
        //======================================================================
        //  Overridden methods
        //======================================================================
        override public function onRegister():void
        {
            addMessageListener(RoundMessage.ROUND_STARTED, roundStartedHandler);
            addMessageListener(RoundMessage.CENTER_ROUND_READY, centerRoundReadyHandler);
            addMessageListener(RoundMessage.ROUND_ENDED, roundEndedHandler);
            addMessageListener(GameMessage.GAME_ENDED, gameEndedHandler);
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