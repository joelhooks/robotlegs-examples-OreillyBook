package mosaic.model.utils
{

    import asunit.framework.TestCase;

    public class AutoIncrementorTest extends TestCase
    {
        protected var instance:AutoIncrementor;
        protected static const CURRENT_INDEX:uint = 2;

        public function AutoIncrementorTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new AutoIncrementor();
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is AutoIncrementor", instance is AutoIncrementor);
        }

        public function test_implements_IAutoIncrementor():void
        {
            assertTrue("Implements IAutoIncrementor", instance is IAutoIncrementor);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_if_currentIndex_not_set_next_index_is_1():void
        {
            assertEquals("If currentIndex not set next index is 1", 1, instance.nextIndex);
        }

        public function test_if_currentIndex_is_set_returns_plus_1():void
        {
            instance.currentIndex = CURRENT_INDEX;
            assertEquals("If currentIndex is set returns plus 1", CURRENT_INDEX + 1, instance.nextIndex);
        }

        public function test_after_running_indexUsed_then_nextIndex_gives_highest_plus_1():void
        {
            instance.indexUsed(2);
            instance.indexUsed(5);
            instance.indexUsed(3);
            assertEquals("Running indexUsed then nextIndex gives highest plus 1", 6, instance.nextIndex);
        }

        public function test_after_reset_returns_1_as_nextIndex():void
        {
            instance.nextIndex;
            instance.nextIndex;
            instance.nextIndex;
            instance.reset();
            assertEquals("After reset returns 1 as nextIndex", 1, instance.nextIndex);
        }


    }
}