package mosaic.model.values
{

    import asunit.framework.TestCase;

    public class ConfigNameTest extends TestCase
    {
        protected var instance:ConfigName;
        protected static const CONFIG_NAME:String = "config name";

        public function ConfigNameTest(methodName:String = null)
        {
            super(methodName);
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new ConfigName(CONFIG_NAME);
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is ConfigName", instance is ConfigName);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_explicitly_casts_to_string_as_value_given():void
        {

            var configAsCast:String = String(instance);

            assertEquals("Casts to string as value given", CONFIG_NAME, configAsCast);
        }

        public function test_implicitly_casts_to_string_as_value_given():void
        {

            var holdingValue:* = instance;
            var configAsCast:String = holdingValue;

            assertEquals("Casts to string as value given", CONFIG_NAME, configAsCast);
        }
    }
}
