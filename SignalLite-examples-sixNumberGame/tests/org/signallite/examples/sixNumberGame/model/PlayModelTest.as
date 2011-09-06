package org.signallite.examples.sixNumberGame.model
{
    import org.flexunit.asserts.assertTrue;
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
        public function startGame_should_dispatch_signal():void
        {
            proceedOnSignal(this, instance.gameStarted);
            instance.startGame();
        }
        [Test(async)]
        public function startGame_should_start_first_round():void
        {
            proceedOnSignal(this, instance.roundStarted);
            instance.startGame();

            assertTrue(instance.centerValue > 0 && instance.centerValue <= 6);
        }
    }
}