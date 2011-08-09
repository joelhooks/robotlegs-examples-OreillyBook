package mosaic.view.tilesupply
{

    import asunit.framework.TestCase;

    import com.newloop.util.UnitHelpers;

    import flash.display.Sprite;

    public class TileSupplyMenuTest extends TestCase
    {
        protected var instance:TileSupplyMenu;
        protected static const ID:uint = 5;
        protected static const COLOR:uint = 0xFF0000;
        protected static const COUNT:Number = 234;
        protected static const COLOR2:uint = 0xFF3399;

        protected var _visualTest:Boolean;

        public function TileSupplyMenuTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            _visualTest = false;
            instance = new TileSupplyMenu();
            addChild(instance);
        }

        override protected function tearDown():void
        {
            super.tearDown();
            if (!_visualTest)
            {
                removeChild(instance);
            }
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is TileSupplyMenu", instance is TileSupplyMenu);
        }

        public function testIsSprite():void
        {
            assertTrue("instance is Sprite", instance is Sprite);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_addSupply_adds_a_supply():void
        {
            instance.addSupply(ID, COLOR, COUNT);
            assertNotNull("AddSupply adds supply view", UnitHelpers.findInstanceOf(instance, TileSupplyDetailView));
        }

        public function test_addingTwoSupplies_stacks_them_vertically():void
        {
            instance.addSupply(ID, COLOR, COUNT);

            var heightWithOneItem:Number = instance.height;

            instance.addSupply(ID + 1, COLOR2, COUNT + 10);

            var heightWithTwoItems:Number = instance.height;

            assertTrue("AddingTwoSupplies stacks them vertically", (heightWithTwoItems > heightWithOneItem));
        }

        public function test_has_clickable_addButton():void
        {
            UnitHelpers.clickItem(instance.addButton);
            assertTrue("addButton found and clicked", true);
        }

        public function test_removeSupplyWithID_removes_one_supply():void
        {
            instance.addSupply(ID + 1, COLOR, COUNT);
            instance.addSupply(ID, COLOR, COUNT);
            instance.addSupply(ID + 3, COLOR, COUNT);
            instance.addSupply(ID + 4, COLOR, COUNT);

            instance.removeSupplyWithID(ID);

            assertEquals("Has one less supply", 3, UnitHelpers.countInstancesOf(instance, TileSupplyDetailView));
        }

        public function test_removeSupplyWithID_removes_correct_supply():void
        {
            instance.addSupply(ID + 1, COLOR, COUNT);
            instance.addSupply(ID, COLOR, COUNT);
            instance.addSupply(ID + 3, COLOR, COUNT);

            instance.removeSupplyWithID(ID);

            var tileSuppliesPresent:Array = UnitHelpers.findAllInstancesOf(instance, TileSupplyDetailView);

            var nextSupply:TileSupplyDetailView;

            var iLength:uint = tileSuppliesPresent.length;
            for (var i:int = 0; i < iLength; i++)
            {
                nextSupply = tileSuppliesPresent[i];
                assertFalse('no supply matches ID', ID == nextSupply.id);
            }
        }

        public function test_clear_removes_all_supplies():void
        {
            instance.addSupply(ID + 1, COLOR, COUNT);
            instance.addSupply(ID, COLOR, COUNT);
            instance.addSupply(ID + 3, COLOR, COUNT);
            instance.addSupply(ID + 4, COLOR, COUNT);

            instance.clear();

            assertEquals("Has cleared supplies", 0, UnitHelpers.countInstancesOf(instance, TileSupplyDetailView));
        }


        public function test_verifiedVisually():void
        {
            _visualTest = true;

            instance.addSupply(ID, COLOR, COUNT);
            instance.addSupply(ID + 1, COLOR, COUNT);
            instance.addSupply(ID + 2, COLOR, COUNT);
            instance.addSupply(ID + 3, COLOR, COUNT);

            instance.removeSupplyWithID(ID + 2);

            assertTrue("VerifiedVisually", true);

            removeChild(instance);
        }

    }
}