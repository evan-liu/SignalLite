package org.signallite.examples.sixNumberGame.model
{
    import org.flexunit.asserts.assertEquals;
    import org.signallite.integrations.flexunit.proceedOnSignal;
    public class PlayModelTest
    {
        //======================================================================
        //  Variables
        //======================================================================
        private var instance:PlayModel;
        //======================================================================
        //  Fixture methods
        //======================================================================
        [Before]
        public function setUp():void
        {
            instance = new PlayModel();
        }
        [After]
        public function tearDown():void
        {
            instance = null;
        }
        //======================================================================
        //  Test methods
        //======================================================================
        [Test(async)]
        public function startGame_should_start_first_round():void
        {
            proceedOnSignal(this, instance.roundStarted);

            instance.startGame();

            assertEquals(1, instance.roundNumber);
        }
        [Test(async)]
        public function act_player_then_end_round():void
        {
            instance.startGame();

            proceedOnSignal(this, instance.playerRoundReady);
            proceedOnSignal(this, instance.roundEnded);

            instance.actPlayerRound(1);
        }
        [Test(async)]
        public function start_next_round_after_round_end():void
        {
            instance.startGame();
            instance.actPlayerRound(1);
            assertEquals(2, instance.roundNumber);
        }
        [Test(async)]
        public function all_rounds_end_then_end_game():void
        {
            instance.startGame();

            proceedOnSignal(this, instance.gameEnded);

            for (var i:int = 1; i <= 6; i++)
            {
                instance.actPlayerRound(i);
            }
        }
    }
}