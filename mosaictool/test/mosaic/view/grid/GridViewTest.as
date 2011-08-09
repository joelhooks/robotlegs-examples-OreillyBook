package mosaic.view.grid
{

    import asunit.framework.TestCase;

    import com.newloop.util.UnitHelpers;

    import flash.display.Sprite;

    import mosaic.controller.events.TileColorChangeEvent;

    public class GridViewTest extends TestCase
    {
        protected var instance:GridView;

        protected static const ROWS:uint = 10;
        protected static const COLUMNS:uint = 12;
        protected static const SELECTION_COLOR:uint = 0x005588;
        protected static const GROUT_COLOR:uint = 0x334455;
        protected static const SELECTED_ROW:uint = 2;
        protected static const SELECTED_COLUMN:uint = 3;

        public function GridViewTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new GridView(new TileFactorySupport());
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is GridView", instance is GridView);
        }

        public function testIsSprite():void
        {
            assertTrue("instance is Sprite", instance is Sprite);
        }

        public function test_implements_IGridView():void
        {
            assertTrue("Implements IGridView ", instance is IGridView);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_setGridSize_draws_correct_number_of_tiles():void
        {
            var expectedItems:uint = ROWS * COLUMNS;
            instance.setGridSize(ROWS, COLUMNS);

            assertEquals("SetGridSize draws correct number of tiles", expectedItems, UnitHelpers.countInstancesOf(instance, ITileView, 1));
        }

        public function test_setGridSize_lays_out_tiles_with_correct_width():void
        {
            var expectedWidth:Number = (COLUMNS * TileFactorySupport.TILE_SIZE);
            instance.setGridSize(ROWS, COLUMNS);

            assertEquals("SetGridSize lays out tiles with correct width", expectedWidth, instance.width);
        }

        public function test_setGridSize_lays_out_tiles_with_correct_height():void
        {
            var expectedHeight:Number = (ROWS * TileFactorySupport.TILE_SIZE);
            instance.setGridSize(ROWS, COLUMNS);

            assertEquals("SetGridSize lays out tiles with correct height ", expectedHeight, instance.height);
        }

        public function test_clicking_a_tile_changes_it_to_selectionColor():void
        {
            instance.setGridSize(ROWS, COLUMNS);

            instance.selectionColor = SELECTION_COLOR;

            var anyTile:TileView = UnitHelpers.findInstanceOf(instance, TileView, 1);
            UnitHelpers.clickItem(anyTile);

            var tileViewSupport:TileViewSupport = new TileViewSupport(anyTile);

            assertEquals("Clicking a tile changes it to selectionColor", SELECTION_COLOR, tileViewSupport.tileColor);
        }


        public function test_applyColorsToWholeGrid_applies_colors_correctly():void
        {
            instance.setGridSize(ROWS, COLUMNS);

            var colorsToSet:Vector.<Vector.<uint>> = createColorsToSet();
            instance.applyColorsToWholeGrid(colorsToSet);

            var actualColors:Vector.<Vector.<uint>> = captureColorsInInstance();

            assertEqualsVectors("ApplyColorsToWholeGrid applies colors correctly", colorsToSet, actualColors);
        }

        public function test_setGridSize_adds_grout_lines():void
        {
            instance.setGridSize(ROWS, COLUMNS);

            assertNotNull("SetGridSize adds grout lines", UnitHelpers.findInstanceOf(instance, GroutLinesView));
        }

        public function test_setting_groutColor_applies_it_to_grout_lines():void
        {
            instance.setGridSize(ROWS, COLUMNS);
            instance.groutColor = GROUT_COLOR;

            var groutLines:GroutLinesView = UnitHelpers.findInstanceOf(instance, GroutLinesView);

            assertEquals("Setting groutColor applies it to grout lines", GROUT_COLOR, UnitHelpers.getColorTransformOf(groutLines));
        }

        public function test_clicking_a_tile_dispatches_TileColorChangeEvent_CHANGED():void
        {
            instance.setGridSize(ROWS, COLUMNS);
            instance.selectionColor = SELECTION_COLOR;

            var handler:Function = addAsync(check_clicking_a_tile_dispatches_TileColorChangeEvent_CHANGED, 50);
            instance.addEventListener(TileColorChangeEvent.CHANGED, handler);

            var allTiles:Array = UnitHelpers.findAllInstancesOf(instance, TileView, 1);
            var tileIndex:uint = (SELECTED_ROW * COLUMNS) + SELECTED_COLUMN;
            var selectedTile:TileView = allTiles[tileIndex];

            UnitHelpers.clickItem(selectedTile);
        }

        protected function check_clicking_a_tile_dispatches_TileColorChangeEvent_CHANGED(e:TileColorChangeEvent):void
        {
            assertEquals("correct row index", SELECTED_ROW, e.row);
            assertEquals("correct column index", SELECTED_COLUMN, e.column);
            assertEquals("correct color", SELECTION_COLOR, e.color);
        }

        public function test_sets_selection_color_to_contrast_with_default_until_set_manually():void
        {
            instance.setGridSize(ROWS, COLUMNS);

            var anyTile:TileView = UnitHelpers.findInstanceOf(instance, TileView, 1);
            UnitHelpers.clickItem(anyTile);

            var tileViewSupport:TileViewSupport = new TileViewSupport(anyTile);

            assertEquals("Sets selected color to contrast with default", 0xFFFFFF, tileViewSupport.tileColor);
        }


        protected function captureColorsInInstance():Vector.<Vector.<uint>>
        {
            var allTiles:Array = UnitHelpers.findAllInstancesOf(instance, TileView, 1);

            var tileCount:uint = 0;
            var tile:TileView;
            var tileViewSupport:TileViewSupport;
            var nextColor:uint;

            var iLength:uint = ROWS;
            var jLength:uint = COLUMNS;

            var colorVector:Vector.<Vector.<uint>> = new Vector.<Vector.<uint>>();

            for (var i:int = 0; i < iLength; i++)
            {
                colorVector.push(new Vector.<uint>());
                for (var j:int = 0; j < jLength; j++)
                {
                    tile = allTiles[tileCount];
                    tileViewSupport = new TileViewSupport(tile);
                    nextColor = tileViewSupport.tileColor;

                    colorVector[i][j] = nextColor;

                    tileCount++;

                }
            }

            return colorVector;
        }

        protected function createColorsToSet():Vector.<Vector.<uint>>
        {
            var iLength:uint = ROWS;
            var jLength:uint = COLUMNS;

            var colorVector:Vector.<Vector.<uint>> = new Vector.<Vector.<uint>>();

            for (var i:int = 0; i < iLength; i++)
            {
                colorVector.push(new Vector.<uint>());
                for (var j:int = 0; j < jLength; j++)
                {
                    var nextColor:uint = randomColor();
                    colorVector[i][j] = nextColor;
                }
            }

            return colorVector;
        }

        protected function randomColor():uint
        {
            return Math.round(Math.random() * 0xFFFFFF);
        }

    }
}