package mosaic.view
{

    import asunit.framework.TestCase;

    import com.newloop.util.UnitHelpers;

    import flash.display.DisplayObject;
    import flash.display.Sprite;

    import mosaic.view.grid.GridView;
    import mosaic.view.grid.ITileView;
    import mosaic.view.grid.TileFactorySupport;
    import mosaic.view.ui.EditPanelView;

    public class MosaicToolViewTest extends TestCase
    {
        protected var instance:MosaicToolView;
        protected static const ROWS:uint = 3;
        protected static const COLUMNS:uint = 14;
        protected static const TOOL_AREA_WIDTH:Number = 150;

        protected var _grid:DisplayObject;

        public function MosaicToolViewTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new MosaicToolView(new TileFactorySupport(), TOOL_AREA_WIDTH);
            addChild(instance);
        }

        override protected function tearDown():void
        {
            super.tearDown();
            removeChild(instance);
            instance = null;
            _grid = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is MosaicToolView", instance is MosaicToolView);
        }

        public function testIsSprite():void
        {
            assertTrue("instance is Sprite", instance is Sprite);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_showGrid_adds_grid():void
        {
            instance.showGrid(ROWS, COLUMNS);
            assertNotNull("ShowGrid adds grid", UnitHelpers.findInstanceOf(instance, GridView));
        }

        public function test_showGrid_adds_grid_with_correct_number_of_tiles():void
        {
            instance.showGrid(ROWS, COLUMNS);
            var expectedTileCount:uint = ROWS * COLUMNS;

            assertEquals("ShowGrid adds grid", expectedTileCount, UnitHelpers.countInstancesOf(instance, ITileView, 2));
        }

        public function test_showGrid_resizes_grid_to_fit_working_area_if_smaller_constrained_by_columns():void
        {
            var rows:uint = 1;
            var columns:uint = 10;
            instance.showGrid(rows, columns);

            var spareWidth:Number = getSpareWidth();
            var spareHeight:Number = getSpareHeight();

            assertTrue("ShowGrid resizes grid to fit working area if smaller constrained by columns", (spareHeight > spareWidth) && (spareWidth > 0) && (spareWidth < 100));
        }

        public function test_showGrid_resizes_grid_to_fit_working_area_if_smaller_constrained_by_rows():void
        {
            var rows:uint = 10;
            var columns:uint = 1;
            instance.showGrid(rows, columns);

            var spareWidth:Number = getSpareWidth();
            var spareHeight:Number = getSpareHeight();

            assertTrue("ShowGrid resizes grid to fit working area if smaller constrained by rows", (spareWidth > spareHeight) && (spareHeight > 0) && (spareHeight < 100));
        }

        public function test_showGrid_resizes_grid_to_snap_lines_to_pixels():void
        {
            var rows:uint = 8;
            var columns:uint = 7;
            instance.showGrid(rows, columns);

            var gridColumnWidth:Number = (grid.width) / columns;
            var gridRowHeight:Number = (grid.height) / rows;

            assertEquals("ShowGrid resizes grid to snap to pixels - width", Math.round(gridColumnWidth), gridColumnWidth);
            assertEquals("ShowGrid resizes grid to snap to pixels - height", Math.round(gridRowHeight), gridRowHeight);
        }

        public function test_showGrid_resizes_grid_keeping_squares_square():void
        {
            var rows:uint = 8;
            var columns:uint = 7;
            instance.showGrid(rows, columns);

            var gridColumnWidth:Number = (grid.width) / columns;
            var gridRowHeight:Number = (grid.height) / rows;

            assertEquals("ShowGrid resizes grid keeping squares square", gridColumnWidth, gridRowHeight);
        }

        public function test_showGrid_resizes_grid_to_fit_working_area_if_larger_constrained_by_columns():void
        {
            var rows:uint = 30;
            var columns:uint = 150;
            instance.showGrid(rows, columns);

            var spareWidth:Number = getSpareWidth();
            var spareHeight:Number = getSpareHeight();

            assertTrue("ShowGrid resizes grid to fit working area if larger constrained by columns", (spareHeight > spareWidth) && (spareWidth > 0) && (spareWidth < 200));
        }

        public function test_showGrid_resizes_grid_to_fit_working_area_if_larger_constrained_by_rows():void
        {
            var rows:uint = 100;
            var columns:uint = 10;
            instance.showGrid(rows, columns);

            var spareWidth:Number = getSpareWidth();
            var spareHeight:Number = getSpareHeight();

            assertTrue("ShowGrid resizes grid to fit working area if larger constrained by rows", (spareWidth > spareHeight) && (spareHeight > 0) && (spareHeight < 200));
        }

        public function test_places_grid_in_x_using_tool_area_width_and_centered():void
        {
            var rows:uint = 8;
            var columns:uint = 7;
            instance.showGrid(rows, columns);

            var spareWidth:Number = getSpareWidth();
            var expectedBorder:Number = Math.floor(spareWidth / 2);

            var actualBorder:Number = grid.x - TOOL_AREA_WIDTH;

            assertEquals("Places grid using tool area width and centered", expectedBorder, actualBorder);
        }

        public function test_places_grid_in_y_centered():void
        {
            var rows:uint = 8;
            var columns:uint = 7;
            instance.showGrid(rows, columns);

            var spareHeight:Number = getSpareHeight();
            var expectedBorder:Number = Math.floor(spareHeight / 2);

            var actualBorder:Number = grid.y;

            assertEquals("Places grid using tool area width and centered", expectedBorder, actualBorder);
        }

        public function test_contains_editMenu():void
        {
            assertNotNull("Contains editMenu", UnitHelpers.findInstanceOf(instance, EditPanelView));
        }


        // helpers

        protected function get grid():DisplayObject
        {
            return _grid ||= UnitHelpers.findInstanceOf(instance, GridView);
        }

        protected function getSpareWidth():Number
        {
            return (instance.stage.stageWidth - TOOL_AREA_WIDTH) - grid.width - 1;
        }

        protected function getSpareHeight():Number
        {
            return instance.stage.stageHeight - grid.height - 1;

        }

    }
}