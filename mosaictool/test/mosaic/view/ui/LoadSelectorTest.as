package mosaic.view.ui
{

    import asunit.framework.TestCase;

    import com.newloop.util.UnitHelpers;

    import fl.controls.Button;
    import fl.controls.ComboBox;

    import flash.display.Sprite;
    import flash.events.Event;

    import mosaic.view.ui.events.LoadSelectorEvent;

    public class LoadSelectorTest extends TestCase
    {
        protected var instance:LoadSelector;
        protected var _visualTest:Boolean;
        protected static const SELECTED_INDEX:uint = 2;

        public function LoadSelectorTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            _visualTest = false;
            instance = new LoadSelector();
            addChild(instance);
            instance.designList = createDesignList();
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
            assertTrue("instance is LoadSelector", instance is LoadSelector);
        }

        public function testIsSprite():void
        {
            assertTrue("instance is Sprite", instance is Sprite);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_clicking_load_after_selection_dispatches_LoadSelectorEvent_with_correct_Design_name():void
        {
            addAsync(null, 50, use_ui_after_wait_for_rendering);
        }

        protected function use_ui_after_wait_for_rendering(e:Event):void
        {
            instance.designList = createDesignList();

            var handler:Function = addAsync(check_clicking_load_after_selection_dispatches_LoadSelectorEvent_with_correct_Design_name, 50);
            instance.addEventListener(LoadSelectorEvent.LOAD_CLICKED, handler);

            var namesComboBox:ComboBox = UnitHelpers.findInstanceOf(instance, ComboBox);
            UnitHelpers.clickItemNumberInComboBox(namesComboBox, SELECTED_INDEX);

            var loadButton:Button = UnitHelpers.findInstanceOf(instance, Button);
            UnitHelpers.clickItem(loadButton);
        }

        private function check_clicking_load_after_selection_dispatches_LoadSelectorEvent_with_correct_Design_name(e:LoadSelectorEvent):void
        {
            var expectedDesignName:String = createDesignList()[SELECTED_INDEX];
            assertEquals("carries correct design name", expectedDesignName, e.designName);
        }

        public function test_verified_visually():void
        {
            _visualTest = true;
            instance.x = 200;
            instance.y = 200;
            addChild(instance);
            assertTrue("Verified visually", true);
            removeChild(instance);
        }

        protected function createDesignList():Vector.<String>
        {
            var designs:Vector.<String> = new Vector.<String>();
            var iLength:uint = 5;
            for (var i:int = 0; i < iLength; i++)
            {
                designs.push('Design' + String(i));
            }

            return designs;
        }

    }
}