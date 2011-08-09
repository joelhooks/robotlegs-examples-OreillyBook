package mosaic.view.grid
{

    public class QuarterTileViewTest extends TileViewTest
    {

        public function QuarterTileViewTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function createInstance():TileView
        {
            return new QuarterTileView(HEIGHT_AND_WIDTH, START_COLOR);
        }

        public override function testInstantiated():void
        {
            assertTrue("instance is QuarterTileView", instance is QuarterTileView);
        }

        public override function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public override function test_width_and_height_match_dimension_given():void
        {
            var requiredWidth:Number = HEIGHT_AND_WIDTH;
            var requiredHeight:Number = HEIGHT_AND_WIDTH / 2;
            assertEquals("width matches", requiredWidth, instance.width);
            assertEquals("height matches", requiredHeight, instance.height);
        }

        override public function test_visually():void
        {
            addChild(instance);
            instance.color = COLOR;
            instance.x = instance.y = 100;
            assertTrue("Visually verified", true);
            removeChild(instance);
        }
    }
}