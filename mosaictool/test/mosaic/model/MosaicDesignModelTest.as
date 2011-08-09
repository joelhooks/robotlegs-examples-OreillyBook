package mosaic.model
{

    import asunit.framework.TestCase;

    import flash.events.EventDispatcher;

    import mosaic.controller.events.DesignEvent;

    import org.robotlegs.mvcs.Actor;

    public class MosaicDesignModelTest extends TestCase
    {
        protected var instance:MosaicDesignModel;
        protected static const NEW_COLOR:uint = 9;

        protected static const COLOR_WAS:uint = 3;
        protected static const COLOR_NOW:uint = 15;

        public function MosaicDesignModelTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new MosaicDesignModel();
            instance.eventDispatcher = new EventDispatcher();
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is MosaicDesignModel", instance is MosaicDesignModel);
        }

        public function testIsModel():void
        {
            assertTrue("instance is robotlegs Actor", instance is Actor);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_implements_IMosaicDesignModel():void
        {
            assertTrue("Implements IMosaicDesignModel", instance is IMosaicDesignModel);
        }

        public function test_set_testName():void
        {
            var originalDesign:Vector.<Vector.<uint>> = createStartingData(5, 5);
            instance.loadDesign(originalDesign);

            assertEqualsVectors("design saved and returned", originalDesign, instance.getDesign());
        }

        public function test_changeTileColorAt_returns_what_the_color_being_replaced():void
        {
            var originalDesign:Vector.<Vector.<uint>> = createStartingData(5, 5);
            instance.loadDesign(originalDesign);

            var originalColor:uint = originalDesign[1][2];

            var returnedColor:uint = instance.changeTileColorAt(1, 2, NEW_COLOR)

            assertEquals("ChangeTileColorAt returns what the color being replaced ", originalColor, returnedColor);
        }

        public function test_changeTileColorAt_updates_the_grid():void
        {
            var originalDesign:Vector.<Vector.<uint>> = createStartingData(5, 5);
            instance.loadDesign(originalDesign);

            var expectedDesign:Vector.<Vector.<uint>> = createStartingData(5, 5);
            expectedDesign[1][2] = NEW_COLOR;

            instance.changeTileColorAt(1, 2, NEW_COLOR)

            assertEqualsVectors("ChangeTileColorAt updates the grid", expectedDesign, instance.getDesign());
        }

        public function test_switchTileColors_replaces_correct_entries():void
        {
            var originalDesign:Vector.<Vector.<uint>> = createStartingData(5, 5);
            instance.loadDesign(originalDesign);

            var expectedDesign:Vector.<Vector.<uint>> = createAmendedDataAfterColorSwap(5, 5);

            instance.switchTileColors(COLOR_WAS, COLOR_NOW);

            assertEqualsVectors("SwitchTileColors replaces correct entries", expectedDesign, instance.getDesign());
        }

        public function test_dispatches_design_model_changed_when_design_loads():void
        {
            var handler:Function = addAsync(check_dispatches_design_model_changed_when_design_loads, 50);
            instance.eventDispatcher.addEventListener(DesignEvent.DESIGN_MODEL_CHANGED, handler);

            var originalDesign:Vector.<Vector.<uint>> = createStartingData(5, 5);
            instance.loadDesign(originalDesign);
        }

        private function check_dispatches_design_model_changed_when_design_loads(e:DesignEvent):void
        {
            var originalDesign:Vector.<Vector.<uint>> = createStartingData(5, 5);
            assertEqualsVectors('colors vectors sent correctly', originalDesign, e.colors);
        }

        protected function createStartingData(rows:uint, columns:uint):Vector.<Vector.<uint>>
        {
            var grid:Vector.<Vector.<uint>> = new Vector.<Vector.<uint>>();

            var iLength:uint = rows;
            var jLength:uint = columns;

            for (var i:int = 0; i < iLength; i++)
            {
                grid[i] = new Vector.<uint>();
                for (var j:int = 0; j < jLength; j++)
                {
                    grid[i][j] = (i + j) % 5;
                }
            }

            return grid;
        }

        protected function createAmendedDataAfterColorSwap(rows:uint, columns:uint):Vector.<Vector.<uint>>
        {
            var grid:Vector.<Vector.<uint>> = new Vector.<Vector.<uint>>();

            var iLength:uint = rows;
            var jLength:uint = columns;

            for (var i:int = 0; i < iLength; i++)
            {
                grid[i] = new Vector.<uint>();
                for (var j:int = 0; j < jLength; j++)
                {
                    var colorID:uint = (i + j) % 5;
                    if (colorID == COLOR_WAS)
                    {
                        colorID = COLOR_NOW;
                    }
                    grid[i][j] = colorID;
                }
            }

            return grid;
        }


    }
}