package org.signallite.examples.sixNumberGame.model
{
    import org.signallite.Signal;
    public class PlayModel
    {
        //======================================================================
        //  Signals
        //======================================================================
        public const gameStarted:Signal = new Signal(this);
        public const gameEnded:Signal = new Signal(this);
        public const roundStarted:Signal = new Signal(this);
        public const roundEnded:Signal = new Signal(this);
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
        //  playerValue
        //------------------------------
        private var _playerValue:int = 0;
        public function get playerValue():int
        {
            return _playerValue;
        }
        //------------------------------
        //  competitorValue
        //------------------------------
        private var _competitorValue:int = 0;
        public function get competitorValue():int
        {
            return _competitorValue;
        }
        //------------------------------
        //  centerValue
        //------------------------------
        private var _centerValue:int = 0;
        public function get centerValue():int
        {
            return _centerValue;
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
        //  gameResult
        //------------------------------
        private var _gameResult:PlayResult;
        public function get gameResult():PlayResult
        {
            return _gameResult;
        }
        //------------------------------
        //  roundNumber
        //------------------------------
        private var _roundNumber:int = 0;
        public function get roundNumber():int
        {
            return _roundNumber;
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
            _centerValue = randomValue(centerValueList);
            roundStarted.dispatch();
        }
        public function reset():void
        {
            _roundNumber = 0;
            _playerValue = 0;
            _competitorValue = 0;
            _centerValue = 0;
            _roundResult = null;
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
    }
}