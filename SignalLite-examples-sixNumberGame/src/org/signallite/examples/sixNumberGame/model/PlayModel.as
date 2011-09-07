package org.signallite.examples.sixNumberGame.model
{
    import org.signallite.examples.sixNumberGame.signals.PlayActionSignal;
    import org.signallite.examples.sixNumberGame.signals.PlayResultSignal;
    public class PlayModel
    {
        //======================================================================
        //  Class constants
        //======================================================================
        public static const ROUND_START:int = 1;
        public static const ROUND_END:int = 6;
        //======================================================================
        //  Signals
        //======================================================================
        public const roundEnded:PlayResultSignal = new PlayResultSignal(this);
        public const gameEnded:PlayResultSignal = new PlayResultSignal(this);

        public const centerRoundReady:PlayActionSignal = new PlayActionSignal(this);
        public const playerRoundReady:PlayActionSignal = new PlayActionSignal(this);
        public const competitorRoundReady:PlayActionSignal = new PlayActionSignal(this);
        //======================================================================
        //  Variables
        //======================================================================
        private var playerValueList:Vector.<int>;
        private var competitorValueList:Vector.<int>;
        private var centerValueList:Vector.<int>;
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  playerRoundValue
        //------------------------------
        private var _playerOutValue:int = 0;
        public function get playerOutValue():int
        {
            return _playerOutValue;
        }
        //------------------------------
        //  competitorOutValue
        //------------------------------
        private var _competitorOutValue:int = 0;
        public function get competitorOutValue():int
        {
            return _competitorOutValue;
        }
        //------------------------------
        //  centerOutValue
        //------------------------------
        private var _centerOutValue:int = 0;
        public function get centerOutValue():int
        {
            return _centerOutValue;
        }
        //------------------------------
        //  roundResult
        //------------------------------
        private var _roundResult:PlayResult;
        public function get roundResult():PlayResult
        {
            return _roundResult;
        }
        //------------------------------
        //  roundNumber
        //------------------------------
        private var _roundNumber:int = 0;
        public function get roundNumber():int
        {
            return _roundNumber;
        }
        //------------------------------
        //  playerGameValue
        //------------------------------
        private var _playerGameValue:int = 0;
        public function get playerGameValue():int
        {
            return _playerGameValue;
        }
        //------------------------------
        //  competitorGameValue
        //------------------------------
        private var _competitorGameValue:int = 0;
        public function get competitorGameValue():int
        {
            return _competitorGameValue;
        }
        //------------------------------
        //  gameResult
        //------------------------------
        private var _gameResult:PlayResult;
        public function get gameResult():PlayResult
        {
            return _gameResult;
        }
        //======================================================================
        //  Public methods
        //======================================================================
        public function startGame():void
        {
            reset();
            startRound();
        }
        public function startRound():void
        {
            _roundNumber++;
            _roundResult = null;

            actCenterRound();
            actCompetitorRound();
        }
        public function actCenterRound():void
        {
            var value:int = randomValue(centerValueList);
            _centerOutValue += value;
            centerRoundReady.dispatch(value);
        }
        public function actPlayerRound(value:int):void
        {
            _playerOutValue += value;
            playerRoundReady.dispatch(value);
            endRound();
        }
        public function actCompetitorRound():void
        {
            var value:int = randomValue(competitorValueList);
            _competitorOutValue += value;
            competitorRoundReady.dispatch(value);
        }
        //======================================================================
        //  Private methods
        //======================================================================
        private function reset():void
        {
            resetOutValues();

            _playerGameValue = 0;
            _competitorGameValue = 0;

            _roundNumber = ROUND_START - 1;
            _gameResult = null;

            playerValueList = prepareValueList();
            competitorValueList = prepareValueList();
            centerValueList = prepareValueList();
        }
        private function resetOutValues():void
        {
            _playerOutValue = 0;
            _competitorOutValue = 0;
            _centerOutValue = 0;
        }
        private function prepareValueList():Vector.<int>
        {
            return Vector.<int>([1, 2, 3, 4, 5, 6]);
        }
        private function randomValue(list:Vector.<int>):int
        {
            var index:int = Math.random() * list.length;
            var result:int = list[index];
            list.splice(index, 1);
            return result;
        }
        private function endRound():void
        {
            if (_playerOutValue == _competitorOutValue)
            {
                drawRound();
            }
            else
            {
                _playerOutValue > _competitorOutValue ? winRound() : loseRound();
            }
            roundEnded.dispatch(_roundResult);

            _roundNumber < ROUND_END ? startRound() : endGame();
        }
        private function winRound():void
        {
            _roundResult = PlayResult.WIN;
            _playerGameValue += _playerOutValue + _centerOutValue + _competitorOutValue;
            resetOutValues();
        }
        private function loseRound():void
        {
            _roundResult = PlayResult.LOSE;
            _competitorGameValue += _playerOutValue + _centerOutValue + _competitorOutValue;
            resetOutValues();
        }
        private function drawRound():void
        {
            _roundResult = PlayResult.DRAW;
        }
        private function endGame():void
        {
            if (_playerOutValue == _competitorOutValue)
            {
                _gameResult = PlayResult.DRAW;
            }
            else
            {
                _gameResult = _playerOutValue > _competitorOutValue ? PlayResult.WIN : PlayResult.LOSE;
            }
            gameEnded.dispatch(_gameResult);
        }
    }
}