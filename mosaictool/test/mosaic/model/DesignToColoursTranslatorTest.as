package mosaic.model
{

    import asunit.framework.TestCase;

    public class DesignToColorsTranslatorTest extends TestCase
    {
        private var instance:DesignToColorsTranslator;

        protected var _designGrid:Vector.<Vector.<uint>>;
        protected var _expectedColorGrid:Vector.<Vector.<uint>>;

        public function DesignToColorsTranslatorTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new DesignToColorsTranslator();
            createDesignGrid();
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is DesignToColorsTranslator", instance is DesignToColorsTranslator);
        }

        public function test_implements_IDesignToColorsTranslator():void
        {
            assertTrue("Implements IDesignToColorsTranslator", instance is IDesignToColorsTranslator);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_createsExpected_color_grid():void
        {

            var tileSupplies:Vector.<TileSupplyVO> = createTileSupplies();
            var defaultColor:uint = 0x000000;

            var colorGridCreated:Vector.<Vector.<uint>> = instance.processDesign(_designGrid, tileSupplies, defaultColor);

            assertEqualsVectors("CreatesExpected color grid", _expectedColorGrid, colorGridCreated);
        }


        protected function createTileSupplies():Vector.<TileSupplyVO>
        {
            var supplyList:Vector.<TileSupplyVO> = new Vector.<TileSupplyVO>();

            var iLength:uint = 5;
            for (var i:int = 0; i < iLength; i++)
            {
                var id:uint = i + 1;
                var color:uint = id * 0x111111;
                var supply:TileSupplyVO = new TileSupplyVO(id, color, 0)

                supplyList.push(supply);
            }

            return supplyList;
        }

        protected function createDesignGrid():void
        {
            _designGrid = new Vector.<Vector.<uint>>();
            _expectedColorGrid = new Vector.<Vector.<uint>>();

            var iLength:uint = 3;
            var jLength:uint = 4;

            var count:uint = 0;

            for (var i:int = 0; i < iLength; i++)
            {
                _designGrid[i] = new Vector.<uint>();
                _expectedColorGrid[i] = new Vector.<uint>();

                for (var j:int = 0; j < jLength; j++)
                {
                    var id:uint = count % 5;
                    count++;
                    _designGrid[i][j] = id;
                    _expectedColorGrid[i][j] = id * 0x111111;
                }
            }
        }
    }
}