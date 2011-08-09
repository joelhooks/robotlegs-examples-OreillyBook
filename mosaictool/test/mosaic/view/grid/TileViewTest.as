package mosaic.view.grid
{

    import asunit.framework.TestCase;

    import flash.display.DisplayObject;
    import flash.display.Sprite;

    public class TileViewTest extends TestCase
    {
        protected var instance:TileView;
        protected var tileViewSupport:TileViewSupport;

        protected static const COLOR:uint = 0x437892;
        protected static const HEIGHT_AND_WIDTH:Number = 23;
        protected static const START_COLOR:uint = 0xFFFFFF;

        public function TileViewTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = createInstance();
            tileViewSupport = new TileViewSupport(instance);
        }

        protected function createInstance():TileView
        {
            return new TileView(HEIGHT_AND_WIDTH, START_COLOR);
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
            tileViewSupport = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is TileView", instance is TileView);
        }

        public function test_implements_ITileView():void
        {
            assertTrue("Implements ITileView", instance is ITileView);
        }


        public function testIsSprite():void
        {
            assertTrue("instance is Sprite", instance is Sprite);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_displays_starting_color_correctly():void
        {
            assertEquals("displays correct starting graphic color", START_COLOR, tileViewSupport.tileColor);
        }


        public function test_set_color_changes_color_of_graphic():void
        {
            instance.color = COLOR;
            assertEquals("set color changes graphic color", COLOR, tileViewSupport.tileColor);
        }

        public function test_width_and_height_match_dimension_given():void
        {
            assertEquals("width matches", HEIGHT_AND_WIDTH, instance.width);
            assertEquals("height matches", HEIGHT_AND_WIDTH, instance.height);
        }


        public function test_visually():void
        {
            addChild(instance);
            instance.color = COLOR;
            assertTrue("Visually verified", true);
            removeChild(instance);
        }

        public function test_asDisplayObject_returns_a_DisplayObject():void
        {
            var dispObject:DisplayObject = instance.asDisplayObject;

            assertNotNull("AsDisplayObject returns a DisplayObject", dispObject);
        }

    }
}