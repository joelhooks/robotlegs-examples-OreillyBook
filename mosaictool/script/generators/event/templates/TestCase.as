package <%= package_name %> {

	import asunit.framework.TestCase;
	
	import flash.events.Event;

	public class <%= test_case_name  %> extends TestCase {
		protected var instance:<%= class_name %>;
		protected static const EVENT_TYPE:String = "someEvent";

		public function <%= test_case_name %>(methodName:String=null) {
			super(methodName)
		}

		override protected function setUp():void {
			super.setUp();
			instance = new <%= class_name %>(EVENT_TYPE);
		}

		override protected function tearDown():void {
			super.tearDown();
			instance = null;
		}

		public function testInstantiated():void {
			assertTrue("instance is <%= class_name %>", instance is <%= class_name %>);
		}
        
		public function testIsEvent():void{
			assertTrue("instance is Event", instance is Event);
		}
        
        public function testCloneReturnsSameEvent():void{
			var clone:<%= class_name %> = instance.clone() as <%= class_name %>;
			assertTrue("<%= class_name %> can be cloned to correct class", clone is <%= class_name %>);
			assertEquals("<%= class_name %> clone retains event type", clone.type, EVENT_TYPE);
		}
		
		public function testEventType():void{
		   	assertEquals("Event has set correct type for <%= class_name %>.<%= subject_class_name %>", <%= class_name %>.<%= subject_class_name %>, "<%= class_name %>.something");
		}

		public function testFailure():void {
			assertTrue("Failing test", false);
		}
		
	}
}