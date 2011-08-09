package mosaic {

    import asunit.framework.TestCase;

    import flash.display.Sprite;

    import org.robotlegs.mvcs.Context;

    public class MosaicContextTest extends TestCase {
		protected var instance:MosaicContext;

		public function MosaicContextTest(methodName:String=null) {
			super(methodName)
		}

		override protected function setUp():void {
			super.setUp();
			instance = new MosaicContext(new Sprite());
		}

		override protected function tearDown():void {
			super.tearDown();
			instance = null;
		}

		public function testInstantiated():void {
			assertTrue("instance is MosaicContext", instance is MosaicContext);
		}

		public function testIsContext():void{
			assertTrue("instance is robotlegs Context", instance is Context);
		}

		public function testFailure():void {
			assertTrue("Failing test", true);
		}

	}
}