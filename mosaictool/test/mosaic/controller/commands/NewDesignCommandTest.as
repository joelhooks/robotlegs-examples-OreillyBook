package mosaic.controller.commands
{

    import asunit.framework.TestCase;

    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;

    import mockolate.nice;
    import mockolate.prepare;
    import mockolate.verify;

    import mosaic.controller.events.DesignCreationEvent;
    import mosaic.model.IMosaicSpecModel;
    import mosaic.model.MosaicDesignModelSupport;
    import mosaic.model.TileSuppliesModel;
    import mosaic.model.TileSupplyVO;
    import mosaic.model.utils.AutoIncrementor;
    import mosaic.model.values.DefaultTileColor;

    import org.hamcrest.object.equalTo;
    import org.robotlegs.mvcs.Command;

    public class NewDesignCommandTest extends TestCase
    {
        protected var instance:NewDesignCommand;

        protected static const ROWS:uint = 4;
        protected static const COLUMNS:uint = 3;
        protected static const DEFAULT_TILE_COLOR:uint = 0x333333;
        protected static const FIRST_SUPPLY_COLOR:uint = 0xFF0000;
        protected static const DESIGN_NAME:String = "design name";

        public function NewDesignCommandTest(methodName:String = null)
        {
            super(methodName)
        }

        override public function run():void
        {
            var mockolateMaker:IEventDispatcher = prepare(IMosaicSpecModel);
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
            instance = new NewDesignCommand();
            instance.designCreationEvent = new DesignCreationEvent(DesignCreationEvent.DESIGN_CREATED, ROWS, COLUMNS, DESIGN_NAME);
            instance.designModel = new MosaicDesignModelSupport();
            instance.specModel = nice(IMosaicSpecModel);
            instance.tileSuppliesModel = new TileSuppliesModel();
            instance.tileSuppliesModel.eventDispatcher = new EventDispatcher();
            instance.defaultTileColor = new DefaultTileColor(DEFAULT_TILE_COLOR);
            instance.autoIncrementor = new AutoIncrementor();
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is NewDesignCommand", instance is NewDesignCommand);
        }

        public function testIsCommand():void
        {
            assertTrue("instance is robotlegs Command", instance is Command);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function testExecute_creates_all_zeros_designGrid_and_populates_model():void
        {
            instance.execute();

            var expectedGrid:Vector.<Vector.<uint>> = new Vector.<Vector.<uint>>();
            expectedGrid.push(Vector.<uint>([0,0,0]));
            expectedGrid.push(Vector.<uint>([0,0,0]));
            expectedGrid.push(Vector.<uint>([0,0,0]));
            expectedGrid.push(Vector.<uint>([0,0,0]));


            var grid:Vector.<Vector.<uint>> = instance.designModel.getDesign();

            assertEqualsVectors('has created grid of 0s and populated design model', expectedGrid, grid);
        }

        public function test_execute_passes_rows_to_spec():void
        {
            instance.execute();
            verify(instance.specModel).setter("rows").args(equalTo(ROWS));
        }

        public function test_execute_passes_columns_to_spec():void
        {
            instance.execute();
            verify(instance.specModel).setter("columns").args(equalTo(COLUMNS));
        }

        public function test_execute_passes_defaultTileColor_to_spec():void
        {
            instance.execute();
            verify(instance.specModel).setter("defaultTileColor").args(equalTo(DEFAULT_TILE_COLOR));
        }

        public function test_execute_creates_first_tileSupply_with_correct_id():void
        {
            instance.execute();
            var tileSupplies:Vector.<TileSupplyVO> = instance.tileSuppliesModel.supplyList;
            var firstSupply:TileSupplyVO = tileSupplies[0];
            assertEquals("supply created with ID 1", 1, firstSupply.id);
        }

        public function test_execute_creates_first_tileSupply_with_color_different_from_dark_default():void
        {
            instance.defaultTileColor = new DefaultTileColor(0x666665);

            instance.execute();
            var tileSupplies:Vector.<TileSupplyVO> = instance.tileSuppliesModel.supplyList;
            var firstSupply:TileSupplyVO = tileSupplies[0];
            assertTrue("supply created with light color", firstSupply.color > 0x999999);
        }

        public function test_execute_creates_first_tileSupply_with_color_different_from_light_default():void
        {
            instance.defaultTileColor = new DefaultTileColor(0x666667);

            instance.execute();
            var tileSupplies:Vector.<TileSupplyVO> = instance.tileSuppliesModel.supplyList;
            var firstSupply:TileSupplyVO = tileSupplies[0];
            assertTrue("supply created with dark color", firstSupply.color < 0x333333);
        }

        public function test_resets_AutoIncrementor():void
        {
            instance.autoIncrementor.currentIndex = 56;

            instance.execute();

            assertEquals("Restarts AutoIncrementor", 2, instance.autoIncrementor.nextIndex);
        }

    }
}