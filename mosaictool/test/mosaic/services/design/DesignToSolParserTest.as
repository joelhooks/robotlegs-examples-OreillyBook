package mosaic.services.design
{

    import asunit.framework.TestCase;

    import flash.events.EventDispatcher;

    import mosaic.model.MosaicDesignModel;
    import mosaic.model.MosaicDesignModelSupport;
    import mosaic.model.MosaicSpecModel;
    import mosaic.model.TileSuppliesModel;
    import mosaic.model.TileSuppliesModelSupport;
    import mosaic.model.TileSupplyVO;

    import org.robotlegs.mvcs.Actor;

    public class DesignToSolParserTest extends TestCase
    {
        protected var instance:DesignToSolParser;

        protected static const ROWS:uint = 5;
        protected static const COLUMNS:uint = 6;
        protected static const GROUT_COLOR:uint = 0x330044;
        protected static const DEFAULT_TILE_COLOR:uint = 0x887766;
        protected static const NO_OF_TILE_SUPPLIES:uint = 7;

        public function DesignToSolParserTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new DesignToSolParser();
            instance.designModel = createDesignModel();
            instance.designSpec = createSpecModel();
            instance.tileSuppliesModel = createTileSuppliesModel();
            instance.tileSupplyParser = new TileSupplyToSolParser();
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is DesignToSolParser", instance is DesignToSolParser);
        }

        public function testIsService():void
        {
            assertTrue("instance is robotlegs Actor", instance is Actor);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_sets_rows_on_data():void
        {
            var objectToPopulate:Object = {};
            instance.populateDataFromDesign(objectToPopulate);

            assertEquals("Sets rows on data", ROWS, objectToPopulate.rows);
        }

        public function test_sets_columns_on_data():void
        {
            var objectToPopulate:Object = {};
            instance.populateDataFromDesign(objectToPopulate);

            assertEquals("Sets columns on data", COLUMNS, objectToPopulate.columns);
        }

        public function test_sets_groutColor_on_data():void
        {
            var objectToPopulate:Object = {};
            instance.populateDataFromDesign(objectToPopulate);

            assertEquals("Sets groutColor on data", GROUT_COLOR, objectToPopulate.groutColor);
        }

        public function test_sets_defaultTileColor_on_data():void
        {
            var objectToPopulate:Object = {};
            instance.populateDataFromDesign(objectToPopulate);

            assertEquals("Sets defaultTileColor on data", DEFAULT_TILE_COLOR, objectToPopulate.defaultTileColor);
        }

        public function test_sets_gridDesign_on_data():void
        {
            var objectToPopulate:Object = {};
            instance.populateDataFromDesign(objectToPopulate);

            var expectedGrid:Vector.<Vector.<uint>> = createDesignModel().getDesign();

            assertEqualsVectors("Sets gridDesign on data", expectedGrid, objectToPopulate.gridDesign);
        }

        public function test_creates_tileSupply_with_right_number_of_items():void
        {
            var objectToPopulate:Object = {};
            instance.populateDataFromDesign(objectToPopulate);

            var tileSuppliesPopulated:Vector.<Object> = objectToPopulate.supplyList;

            assertEquals("Creates tileSupply with right number of items", NO_OF_TILE_SUPPLIES, tileSuppliesPopulated.length);
        }

        public function test_tileSupply_items_have_correct_ids():void
        {
            var objectToPopulate:Object = {};
            instance.populateDataFromDesign(objectToPopulate);

            var tileSuppliesPopulated:Vector.<Object> = objectToPopulate.supplyList;
            var expectedID:uint = 3;

            var itemToVerify:Object = tileSuppliesPopulated[expectedID - 1]

            assertEquals("TileSupply items have correct ids", expectedID, itemToVerify.id);
        }

        public function test_tileSupply_items_have_correct_colors():void
        {
            var objectToPopulate:Object = {};
            instance.populateDataFromDesign(objectToPopulate);

            var tileSuppliesPopulated:Vector.<Object> = objectToPopulate.supplyList;
            var id:uint = 3;
            var expectedColor:uint = (id - 1) * 0x111111;

            var itemToVerify:Object = tileSuppliesPopulated[id - 1]

            assertEquals("TileSupply items have correct colors", expectedColor, itemToVerify.color);
        }

        protected function createDesignModel():MosaicDesignModel
        {
            var designModel:MosaicDesignModelSupport = new MosaicDesignModelSupport();
            designModel.eventDispatcher = new EventDispatcher();
            var designGrid:Vector.<Vector.<uint>> = createColorGrid();

            designModel.loadDesign(designGrid);

            return designModel;
        }

        protected function createSpecModel():MosaicSpecModel
        {
            var spec:MosaicSpecModel = new MosaicSpecModel();
            spec.rows = ROWS;
            spec.columns = COLUMNS;
            spec.defaultTileColor = DEFAULT_TILE_COLOR;
            spec.groutColor = GROUT_COLOR;

            return spec;
        }

        protected function createColorGrid():Vector.<Vector.<uint>>
        {
            var gridVector:Vector.<Vector.<uint>> = new Vector.<Vector.<uint>>();

            var iLength:uint = ROWS;
            var jLength:uint = COLUMNS;

            for (var i:int = 0; i < iLength; i++)
            {
                gridVector[i] = new Vector.<uint>();
                for (var j:int = 0; j < jLength; j++)
                {
                    var id:uint = (i * j) % (NO_OF_TILE_SUPPLIES - 2);
                    gridVector[i][j] = id;
                }
            }

            return gridVector;
        }

        protected function createTileSuppliesModel():TileSuppliesModel
        {
            var tileSupplies:Vector.<TileSupplyVO> = new Vector.<TileSupplyVO>();

            var iLength:uint = NO_OF_TILE_SUPPLIES;
            for (var i:int = 0; i < iLength; i++)
            {
                var id:uint = i + 1;
                var color:uint = i * 0x111111;
                var count:Number = 0;
                var nextSupply:TileSupplyVO = new TileSupplyVO(id, color, count);
                tileSupplies.push(nextSupply);
            }

            var suppliesModel:TileSuppliesModel = new TileSuppliesModelSupport();
            suppliesModel.supplyList = tileSupplies;

            return suppliesModel;
        }

    }
}