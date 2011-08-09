package mosaic.services.design
{

    import asunit.framework.TestCase;

    import flash.events.Event;
    import flash.events.IEventDispatcher;

    import mockolate.nice;
    import mockolate.prepare;
    import mockolate.verify;

    import mosaic.model.utils.IAutoIncrementor;

    import org.hamcrest.object.equalTo;

    public class TileSupplyFromSolParserTest extends TestCase
    {
        protected var instance:TileSupplyFromSolParser;

        protected static const ROWS:uint = 5;
        protected static const COLUMNS:uint = 6;
        protected static const NO_OF_TILE_SUPPLIES:uint = 7;


        /*

         READ ME:
         The main functionality of this class is tested through the
         DesignFromSolParser test.

         */

        public function TileSupplyFromSolParserTest(methodName:String = null)
        {
            super(methodName);
        }

        override public function run():void
        {
            var mockolateMaker:IEventDispatcher = prepare(IAutoIncrementor);
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
            instance = new TileSupplyFromSolParser();
            instance.tileAutoIncrementor = nice(IAutoIncrementor);
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is TileSupplyFromSolParser", instance is TileSupplyFromSolParser);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_sets_autoincrementor_to_highest_id():void
        {
            instance.createTileSuppliesFrom(createRawPropertiesObject());

            verify(instance.tileAutoIncrementor).setter("currentIndex").args(equalTo(NO_OF_TILE_SUPPLIES));
        }

        protected function createRawPropertiesObject():Object
        {
            var obj:Object = {};

            obj.gridDesign = createColorGrid();
            obj.supplyList = createTileSupplies();

            return obj;
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