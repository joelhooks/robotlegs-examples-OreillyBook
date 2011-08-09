package mosaic.services.design
{

    import asunit.framework.TestCase;

    import flash.events.Event;
    import flash.events.IEventDispatcher;

    import mockolate.nice;
    import mockolate.prepare;
    import mockolate.verify;

    import mosaic.model.IMosaicSpecModel;
    import mosaic.model.MosaicDesignModelSupport;
    import mosaic.model.TileSuppliesModelSupport;
    import mosaic.model.TileSupplyVO;
    import mosaic.model.utils.IAutoIncrementor;

    import org.hamcrest.object.equalTo;

    public class DesignFromSolParserTest extends TestCase
    {
        protected var instance:DesignFromSolParser;

        protected static const ROWS:uint = 5;
        protected static const COLUMNS:uint = 6;
        protected static const GROUT_COLOR:uint = 0x330044;
        protected static const DEFAULT_TILE_COLOR:uint = 0x887766;
        protected static const NO_OF_TILE_SUPPLIES:uint = 7;

        protected var _idsCounter:Array;

        public function DesignFromSolParserTest(methodName:String = null)
        {
            super(methodName)
        }

        override public function run():void
        {
            var mockolateMaker:IEventDispatcher = prepare(IMosaicSpecModel, IAutoIncrementor);
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
            instance = new DesignFromSolParser();
            instance.designModel = new MosaicDesignModelSupport();
            instance.designSpec = nice(IMosaicSpecModel);
            instance.tileSuppliesModel = new TileSuppliesModelSupport();

            var tileSupplyParser:TileSupplyFromSolParser = new TileSupplyFromSolParser();
            tileSupplyParser.tileAutoIncrementor = nice(IAutoIncrementor);
            instance.tileSupplyParser = tileSupplyParser;
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is DesignFromSolParser", instance is DesignFromSolParser);
        }

        public function test_implements_interface():void
        {
            assertTrue("Implements interface", instance is IDesignFromDataParser);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_populateDesignFromData_sets_rows_on_designSpec():void
        {
            var data:Object = createRawPropertiesObject();
            instance.populateDesignFromData(data);

            verify(instance.designSpec).setter("rows").args(equalTo(ROWS));
        }

        public function test_populateDesignFromData_sets_columns_on_designSpec():void
        {
            var data:Object = createRawPropertiesObject();
            instance.populateDesignFromData(data);

            verify(instance.designSpec).setter("columns").args(equalTo(COLUMNS));
        }

        public function test_populateDesignFromData_sets_groutColor_on_designSpec():void
        {
            var data:Object = createRawPropertiesObject();
            instance.populateDesignFromData(data);

            verify(instance.designSpec).setter("groutColor").args(equalTo(GROUT_COLOR));
        }

        public function test_populateDesignFromData_sets_defaultColor_on_designSpec():void
        {
            var data:Object = createRawPropertiesObject();
            instance.populateDesignFromData(data);

            verify(instance.designSpec).setter("defaultTileColor").args(equalTo(DEFAULT_TILE_COLOR));
        }

        public function test_sets_design_on_designModel():void
        {
            var data:Object = createRawPropertiesObject();
            var colorGrid:Vector.<Vector.<uint>> = createColorGrid();

            instance.populateDesignFromData(data);

            assertEqualsVectors("Sets design on designModel", colorGrid, instance.designModel.getDesign());
        }

        public function test_creates_correct_number_of_tileSupplies():void
        {
            var data:Object = createRawPropertiesObject();
            instance.populateDesignFromData(data);

            var suppliesCreated:uint = instance.tileSuppliesModel.supplyList.length;

            assertEquals("creates correct number of tileSupplies", NO_OF_TILE_SUPPLIES, suppliesCreated);
        }

        public function test_puts_the_right_id_on_each_tileSupply():void
        {
            var data:Object = createRawPropertiesObject();
            instance.populateDesignFromData(data);

            var suppliesCreated:Vector.<TileSupplyVO> = instance.tileSuppliesModel.supplyList;

            var rawTileData:Vector.<Object> = createTileSupplies();

            assertEquals("populates tile ids correctly", rawTileData[2].id, suppliesCreated[2].id);
        }

        public function test_puts_the_right_color_on_each_tileSupply():void
        {
            var data:Object = createRawPropertiesObject();
            instance.populateDesignFromData(data);

            var suppliesCreated:Vector.<TileSupplyVO> = instance.tileSuppliesModel.supplyList;

            var rawTileData:Vector.<Object> = createTileSupplies();

            assertEquals("populates tile colors correctly", rawTileData[3].color, suppliesCreated[3].color);
        }

        public function test_puts_the_right_count_on_each_tileSupply():void
        {
            var data:Object = createRawPropertiesObject();
            instance.populateDesignFromData(data);

            var suppliesCreated:Vector.<TileSupplyVO> = instance.tileSuppliesModel.supplyList;

            assertEquals("populates tile counts correctly", 4, suppliesCreated[0].count);
            assertEquals("populates tile counts correctly", 4, suppliesCreated[2].count);
            assertEquals("populates tile counts correctly", 0, suppliesCreated[NO_OF_TILE_SUPPLIES - 1].count);
        }

        public function test_returns_false_if_something_is_missing():void
        {
            var faultyData:Object;
            var propertyNames:Array = ["groutColor","rows","columns","defaultTileColor","gridDesign","supplyList"];

            var iLength:uint = propertyNames.length;
            for (var i:int = 0; i < iLength; i++)
            {
                faultyData = createRawPropertiesObject();
                delete faultyData[propertyNames[i]];

                assertFalse("returns false if something is missing: " + propertyNames[i], instance.populateDesignFromData(faultyData));
            }

        }

        public function test_returns_true_if_everything_is_present():void
        {
            var data:Object = createRawPropertiesObject();

            assertTrue("Returns true when everything present", instance.populateDesignFromData(data));

        }

        protected function createRawPropertiesObject():Object
        {
            var obj:Object = {};

            obj.groutColor = GROUT_COLOR;
            obj.rows = ROWS;
            obj.columns = COLUMNS;
            obj.defaultTileColor = DEFAULT_TILE_COLOR;
            obj.gridDesign = createColorGrid();
            obj.supplyList = createTileSupplies();

            return obj;
        }

        protected function createColorGrid():Vector.<Vector.<uint>>
        {
            var gridVector:Vector.<Vector.<uint>> = new Vector.<Vector.<uint>>();

            var iLength:uint = ROWS;
            var jLength:uint = COLUMNS;

            _idsCounter = [null, 0, 0, 0, 0, 0, 0, 0];

            for (var i:int = 0; i < iLength; i++)
            {
                gridVector[i] = new Vector.<uint>();
                for (var j:int = 0; j < jLength; j++)
                {
                    var id:uint = (i * j) % (NO_OF_TILE_SUPPLIES - 2);
                    gridVector[i][j] = id;


                    _idsCounter[id] += 1;
                }
            }

            return gridVector;
        }

        protected function createTileSupplies():Vector.<Object>
        {
            var tileSupplies:Vector.<Object> = new Vector.<Object>();

            var iLength:uint = NO_OF_TILE_SUPPLIES;
            for (var i:int = 0; i < iLength; i++)
            {
                var nextSupply:Object = {};
                nextSupply.id = i + 1;
                nextSupply.color = i * 0x111111;
                tileSupplies.push(nextSupply);
            }

            return tileSupplies;
        }

    }
}