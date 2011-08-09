package mosaic.view.ui
{

    import asunit.framework.TestCase;

    import com.newloop.util.UnitHelpers;

    import flash.display.Sprite;

    public class WorkspaceTest extends TestCase
    {
        protected var instance:Workspace;
        protected static const WIDTH:Number = 100;
        protected static const HEIGHT:Number = 50;
        protected static const COLOR:uint = 0x330000;

        public function WorkspaceTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new Workspace(WIDTH, HEIGHT);
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is Workspace", instance is Workspace);
        }

        public function testIsSprite():void
        {
            assertTrue("instance is Sprite", instance is Sprite);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_draws_correct_width():void
        {
            assertEquals("Draws correct width", WIDTH, instance.width);
        }

        public function test_draws_correct_height():void
        {
            assertEquals("Draws correct height", HEIGHT, instance.height);
        }

        public function test_set_color_changes_color():void
        {
            instance.color = COLOR;
            assertEquals("Set color changes color", COLOR, UnitHelpers.getColorTransformOf(instance));
        }

    }
}