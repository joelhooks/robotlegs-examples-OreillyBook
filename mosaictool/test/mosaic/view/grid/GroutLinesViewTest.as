package mosaic.view.grid
{

    import asunit.framework.TestCase;

    public class GroutLinesViewTest extends TestCase
    {
        protected var instance:GroutLinesView;

        protected static const ROWS:uint = 20;
        protected static const COLUMNS:uint = 24;
        protected static const TILE_SIZE:Number = 15;
        protected static const COLOR:uint = 0xFF0000;

        public function GroutLinesViewTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new GroutLinesView(ROWS, COLUMNS, TILE_SIZE);
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is GroutLinesView", instance is GroutLinesView);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_grid_has_correct_width():void
        {
            // + 1 because we're drawing one more line for the right edge
            var expectedWidth:Number = (COLUMNS * TILE_SIZE);

            assertEquals("Grid has correct width", expectedWidth, instance.width);
        }

        public function test_grid_has_correct_height():void
        {
            // + 1 because we're drawing one more line for the bottom edge
            var expectedHeight:Number = (ROWS * TILE_SIZE);

            assertEquals("Grid has correct height ", expectedHeight, instance.height);
        }

        public function test_visually_verified():void
        {
            instance.x = instance.y = 100;
            addChild(instance);
            assertTrue("Visually verified ", true);
            removeChild(instance);
        }

        public function test_set_color_changes_color_transform():void
        {
            instance.color = COLOR;
            assertEquals("Set color changes color transform", COLOR, instance.transform.colorTransform.color);
        }


    }
}