package mosaic.model.utils
{

    import asunit.framework.TestCase;

    import flash.utils.Dictionary;

    import mosaic.model.TileSupplyVO;
    import mosaic.model.TileSupplyVOSupport;

    public class IDIndexerTest extends TestCase
    {
        protected var instance:IDIndexer;

        protected static const VO1:TileSupplyVO = new TileSupplyVOSupport(1);
        protected static const VO3:TileSupplyVO = new TileSupplyVOSupport(3);
        protected static const VO12:TileSupplyVO = new TileSupplyVOSupport(12);

        protected static const ITEM_LIST:Vector.<ID> = Vector.<ID>([VO1, VO3, VO12]);

        public function IDIndexerTest(methodName:String = null)
        {
            super(methodName);
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new IDIndexer();
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is IDIndexer", instance is IDIndexer);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_createIndex_returns_dictionary_with_correct_items_1():void
        {
            var index:Dictionary = instance.createIndex(ITEM_LIST);
            assertEquals("CreateIndex returns dictionary with correct items", VO1, index[1]);
        }

        public function test_createIndex_returns_dictionary_with_correct_items_3():void
        {
            var index:Dictionary = instance.createIndex(ITEM_LIST);
            assertEquals("CreateIndex returns dictionary with correct items", VO3, index[3]);
        }

        public function test_createIndex_returns_dictionary_with_correct_items_12():void
        {
            var index:Dictionary = instance.createIndex(ITEM_LIST);
            assertEquals("CreateIndex returns dictionary with correct items", VO12, index[12]);
        }

        public function test_createIndex_other_entries_unpopulated():void
        {
            var index:Dictionary = instance.createIndex(ITEM_LIST);
            assertTrue("CreateIndex other entries unpopulated", index[4] == null);
        }


    }
}