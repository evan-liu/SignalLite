package
{
    import org.signallite.AmbiguousRelationshipTest;
    import org.signallite.MessageBusTest;
    import org.signallite.ProgressSignalTest;
    import org.signallite.SignalTest;

    [Suite]
    [RunWith("org.flexunit.runners.Suite")]
    public class SignalLiteCoreTests
    {
        public var _AmbiguousRelationshipTest:AmbiguousRelationshipTest;
        public var _ProgressSignalTest:ProgressSignalTest;
        public var _SignalTest:SignalTest;
        public var _MessageBusTest:MessageBusTest;
    }
}