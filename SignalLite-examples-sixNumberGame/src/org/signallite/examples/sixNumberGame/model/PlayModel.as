package org.signallite.examples.sixNumberGame.model
{
    import org.signallite.Signal;
    import org.signallite.examples.sixNumberGame.signals.PlayActSignal;
    import org.signallite.examples.sixNumberGame.signals.PlayResultSignal;
    public class PlayModel
    {
        //======================================================================
        //  Class constants
        //======================================================================
        public static const ROUND_MIN:int = 1;
        public static const ROUND_MAX:int = 6;
        //======================================================================
        //  Signals
        //======================================================================
        public const roundStarted:Signal = new Signal(this);
        public const roundEnded:PlayResultSignal = new PlayResultSignal(this);

        public const centerRoundReady:PlayActSignal = new PlayActSignal(this);
        public const playerRoundReady:PlayActSignal = new PlayActSignal(this);
        public const competitorRoundReady:PlayActSignal = new PlayActSignal(this);

        public const gameEnded:PlayResultSignal = new PlayResultSignal(this);
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
        //  valueList
        //------------------------------
        private var _valueList:Vector.<int> = Vector.<int>([1, 2, 3, 4, 5, 6]);
        public function get valueList():Vector.<int>
        {
            return _valueList.concat();
        }
        //------------------------------
        //  playerRoundValue
        //------------------------------
        private var _playerRoundValue:int = 0;
        public function get playerRoundValue():int
        {
            return _playerRoundValue;
        }
        //------------------------------
        //  competitorRoundValue
        //------------------------------
        private var _competitorRoundValue:int = 0;
        public function get competitorRoundValue():int
        {
            return _competitorRoundValue;
        }
        //------------------------------
        //  centerRoundValue
        //------------------------------
        private var _centerRoundValue:int;
        public function get centerRoundValue():int
        {
            return _centerRoundValue;
        }
        //------------------------------
        //  playerOutValue
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

            resetRoundValues();

            actCenterRound();
            actCompetitorRound();

            roundStarted.dispatch();
        }
        public function actCenterRound():void
        {
            _centerRoundValue = randomValue(centerValueList);
            _centerOutValue += _centerRoundValue;
            centerRoundReady.dispatch(_centerRoundValue);
        }
        public function actPlayerRound(value:int):void
        {
            _playerRoundValue = value;
            _playerOutValue += value;
            playerRoundReady.dispatch(value);
            endRound();
        }
        public function actCompetitorRound():void
        {
            _competitorRoundValue = randomValue(competitorValueList);
            _competitorOutValue += _competitorRoundValue;
            competitorRoundReady.dispatch(_competitorRoundValue);
        }
        //======================================================================
        //  Private methods
        //======================================================================
        private function reset():void
        {
            resetRoundValues();
            resetOutValues();

            _playerGameValue = 0;
            _competitorGameValue = 0;

            _roundNumber = ROUND_MIN - 1;
            _gameResult = null;

            playerValueList = valueList;
            competitorValueList = valueList;
            centerValueList = valueList;
        }
        private function resetRoundValues():void
        {
            _centerRoundValue = 0;
            _competitorRoundValue = 0;
            _playerRoundValue = 0;
        }
        private function resetOutValues():void
        {
            _playerOutValue = 0;
            _competitorOutValue = 0;
            _centerOutValue = 0;
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

            _roundNumber < ROUND_MAX ? startRound() : endGame();
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