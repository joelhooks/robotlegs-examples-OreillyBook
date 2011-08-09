package mosaic.view.tilesupply
{

    import fl.controls.RadioButton;

    import mosaic.view.ui.colorselectors.CommonColorSelectorViewTestBase;
    import mosaic.view.ui.parts.DeleteTileSupplyButton;

    public class TileSupplyDetailViewTest extends CommonColorSelectorViewTestBase
    {
        protected var tileSupplyView:TileSupplyDetailView;

        protected static const ID:uint = 3;
        protected static const COLOR:uint = 0x330000;
        protected static const COUNT:Number = 150.5;
        protected static const UPDATED_COUNT:Number = 140;

        public function TileSupplyDetailViewTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            instance = tileSupplyView = new TileSupplyDetailView(ID, DEFAULT_COLOR, COUNT);
            super.setUp();
        }

        public function testInstantiated():void
        {
            assertTrue("instance is TileSupplyDetailView", instance is TileSupplyDetailView);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_get_count():void
        {
            assertEquals("Get count", COUNT, tileSupplyView.count);
        }

        public function test_set_count():void
        {
            tileSupplyView.count = UPDATED_COUNT;
            assertEquals("Set count", UPDATED_COUNT, tileSupplyView.count);
        }

        public function test_exposes_delete_button():void
        {
            assertTrue("Exposes delete button", tileSupplyView.deleteButton is DeleteTileSupplyButton);
        }

        public function test_get_id():void
        {
            assertEquals("Get id", ID, tileSupplyView.id);
        }

        public function test_get_radio_button():void
        {
            assertNotNull("Get radio button returns a RB", tileSupplyView.radioButton as RadioButton);
        }

        public function test_visually():void
        {
            _visualTest = true;
            addChild(instance);
            assertTrue("Visually verified", true);
            removeChild(instance);
        }
    }
}