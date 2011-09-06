package
{
    import org.signallite.examples.sixNumberGame.SixNumberGameContext;

    import flash.display.Sprite;

    public class SixNumberGame extends Sprite
    {
        //======================================================================
        //  Constructor
        //======================================================================
        public function SixNumberGame()
        {
            super();
            context = new SixNumberGameContext(this);
        }
        //======================================================================
        //  Variables
        //======================================================================
        private var context:SixNumberGameContext;
    }
}