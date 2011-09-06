package org.signallite.examples.sixNumberGame.model
{
    import org.signallite.Signal;
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
        public const gameStarted:Signal = new Signal(this);
        public const gameEnded:Signal = new Signal(this);

        public const roundStarted:Signal = new Signal(this);
        public const roundEnded:Signal = new Signal(this);

        public const playerRoundReady:Signal = new Signal(this);
        public const competitorRoundReady:Signal = new Signal(this);
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
        private var _playerRoundValue:int = 0;
        public function get playerRoundValue():int
        {
            return _playerRoundValue;
        }
        public function set playerRoundValue(value:int):void
        {
            _playerRoundValue = value;
            playerRoundReady.dispatch();
            checkRound();
        }
        //------------------------------
        //  competitorRoundValue
        //------------------------------
        private var _competitorRoundValue:int = 0;
        public function get competitorRoundValue():int
        {
            return _competitorRoundValue;
        }
        public function set competitorRoundValue(value:int):void
        {
            _competitorRoundValue = value;
            competitorRoundReady.dispatch();
            checkRound();
        }
        //------------------------------
        //  centerRoundValue
        //------------------------------
        private var _centerRoundValue:int = 0;
        public function get centerRoundValue():int
        {
            return _centerRoundValue;
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
            gameStarted.dispatch();
            startRound();
        }
        public function startRound():void
        {
            _roundNumber++;
            _roundResult = null;
            _centerRoundValue = randomValue(centerValueList);
            roundStarted.dispatch();
        }
        public function reset():void
        {
            _playerRoundValue = 0;
            _competitorRoundValue = 0;
            _playerGameValue = 0;
            _competitorGameValue = 0;
            _roundNumber = ROUND_START - 1;
            _gameResult = null;

            playerValueList = prepareValueList();
            competitorValueList = prepareValueList();
            centerValueList = prepareValueList();
        }
        //======================================================================
        //  Private methods
        //======================================================================
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
        private function checkRound():void
        {
            if (_playerRoundValue > 0 && _competitorRoundValue > 0)
            {
                endRound();
            }
        }
        private function endRound():void
        {
            if (_playerRoundValue == _competitorRoundValue)
            {
                drawRound();
            }
            else
            {
                _playerRoundValue > _competitorRoundValue ? winRound() : loseRound();
            }
            roundEnded.dispatch();
            if (_roundNumber == ROUND_END)
            {
                endGame();
            }
        }
        private function winRound():void
        {
            _roundResult = PlayResult.WIN;
        }
        private function loseRound():void
        {
            _roundResult = PlayResult.LOSE;
        }
        private function drawRound():void
        {
            _roundResult = PlayResult.DRAW;
        }
        private function endGame():void
        {
            if (_playerRoundValue == _competitorRoundValue)
            {
                _gameResult = PlayResult.DRAW;
            }
            else
            {
                _gameResult = _playerRoundValue > _competitorRoundValue ? PlayResult.WIN : PlayResult.LOSE;
            }
            gameEnded.dispatch();
        }
    }
}