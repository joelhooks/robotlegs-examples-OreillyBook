package mosaic.model.utils
{

    import asunit.framework.TestCase;

    public class FileNameFixerTest extends TestCase
    {
        private var instance:FileNameFixer;
        protected static const REAL_TEXT:String = "Hello there";
        protected static const FILE_NAME_TEXT:String = "Hello_there";

        public function FileNameFixerTest(methodName:String = null)
        {
            super(methodName);
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new FileNameFixer('hi');
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is FileNameFixer", instance is FileNameFixer);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_creates_FileName_from_real_text():void
        {
            assertEquals("Creates file name from real text", FILE_NAME_TEXT, new FileNameFixer(REAL_TEXT).fileName);
        }

        public function test_creates_realText_From_filename():void
        {
            assertEquals("Creates real name from file name text", REAL_TEXT, new FileNameFixer(FILE_NAME_TEXT).realName);
        }
    }
}
