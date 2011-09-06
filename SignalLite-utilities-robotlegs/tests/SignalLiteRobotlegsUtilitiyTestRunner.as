package
{
    import org.flexunit.internals.TraceListener;
    import org.flexunit.runner.FlexUnitCore;

    import flash.display.Sprite;

    public class SignalLiteRobotlegsUtilitiyTestRunner extends Sprite
    {
        //======================================================================
        // Constructor
        //======================================================================
        public function SignalLiteRobotlegsUtilitiyTestRunner()
        {
            flexUnit = new FlexUnitCore();
            flexUnit.addListener(new TraceListener());
            flexUnit.run(SignalLiteRobotlegsUtilitiyTests);
        }
        //======================================================================
        // Variables
        //======================================================================
        private var flexUnit:FlexUnitCore;
    }
}