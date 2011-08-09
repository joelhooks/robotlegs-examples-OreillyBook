package mosaic.services.design
{

    import asunit.framework.TestCase;

    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;
    import flash.net.SharedObject;

    import mockolate.nice;
    import mockolate.prepare;
    import mockolate.stub;

    import mosaic.controller.events.DesignLoadEvent;

    import org.robotlegs.mvcs.Actor;

    public class DesignSolLoadingServiceTest extends TestCase
    {
        protected var instance:DesignSolLoadingService;
        protected static const NON_EXISTANT_DESIGN:String = "DesignThatIsntThere";
        protected static const EXISTING_DESIGN:String = "DesignGood";

        protected static const ROWS:uint = 5;
        protected static const COLUMNS:uint = 6;
        protected static const GROUT_COLOR:uint = 0x330044;
        protected static const DEFAULT_TILE_COLOR:uint = 0x887766;
        protected static const NO_OF_TILE_SUPPLIES:uint = 7;


        public function DesignSolLoadingServiceTest(methodName:String = null)
        {
            super(methodName)
        }

        override public function run():void
        {
            var mockolateMaker:IEventDispatcher = prepare(IDesignFromDataParser);
            mockolateMaker.addEventListener(Event.COMPLETE, prepareCompleteHandler);
        }

        protected function prepareCompleteHandler(e:Event):void
        {
            IEventDispatcher(e.target).removeEventListener(Event.COMPLETE, prepareCompleteHandler);
            super.run();
        }

        override protected function setUp():void
        {
            super.setUp();
            writeGoodSol();
            instance = new DesignSolLoadingService();
            instance.eventDispatcher = new EventDispatcher();
            instance.designParser = nice(IDesignFromDataParser);
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is DesignSolLoadingService", instance is DesignSolLoadingService);
        }

        public function testIsService():void
        {
            assertTrue("instance is robotlegs Actor", instance is Actor);
        }

        public function test_implements_interface():void
        {
            assertTrue("Implements interface ", instance is IDesignLoadingService);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_fires_LOAD_FAILED_if_design_not_found():void
        {
            var handler:Function = addAsync(check_fires_LOAD_FAILED_if_design_not_found, 500);
            instance.eventDispatcher.addEventListener(DesignLoadEvent.LOAD_FAILED, handler);

            instance.loadDesign(NON_EXISTANT_DESIGN);
        }

        protected function check_fires_LOAD_FAILED_if_design_not_found(e:DesignLoadEvent):void
        {
            assertEquals("has correct design name", NON_EXISTANT_DESIGN, e.designName);
        }

        public function test_fires_LOAD_COMPLETED_if_parser_finds_nothing_missing():void
        {
            var handler:Function = addAsync(check_fires_LOAD_COMPLETED_if_parser_finds_nothing_missing, 500);
            instance.eventDispatcher.addEventListener(DesignLoadEvent.LOAD_COMPLETED, handler);

            stub(instance.designParser).method("populateDesignFromData").returns(true);

            instance.loadDesign(EXISTING_DESIGN);
        }

        protected function check_fires_LOAD_COMPLETED_if_parser_finds_nothing_missing(e:DesignLoadEvent):void
        {
            assertEquals("has correct design name", EXISTING_DESIGN, e.designName);
        }


        public function test_fires_LOAD_FAILED_if_parser_finds_something_missing():void
        {
            var handler:Function = addAsync(check_fires_LOAD_COMPLETED_if_parser_finds_nothing_missing, 500);
            instance.eventDispatcher.addEventListener(DesignLoadEvent.LOAD_FAILED, handler);

            stub(instance.designParser).method("populateDesignFromData").returns(false);

            instance.loadDesign(EXISTING_DESIGN);
        }

        protected function check_fires_LOAD_FAILED_if_parser_finds_something_missing(e:DesignLoadEvent):void
        {
            assertEquals("has correct design name", EXISTING_DESIGN, e.designName);
        }

        protected function writeGoodSol():void
        {
            var sol:SharedObject = SharedObject.getLocal(EXISTING_DESIGN);
            sol.data.date = new Date();

            sol.flush();
            sol.close();
        }

    }
}