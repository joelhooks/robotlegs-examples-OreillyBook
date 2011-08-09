package <%= package_name %> 
{	
	import org.robotlegs.mvcs.Mediator;
	
	public class <%= class_name %>Mediator extends Mediator 
	{
		// declare the view to be injected
		[Inject]
		public var view:<%= class_name %>;
		
		public function <%= class_name %>Mediator() {			
			// Try not to put stuff in the constructor of the mediator
		}
		
		/**
		 * Initialize the view and register for events. 
		 * 
		 */
		override public function onRegister():void
		{			
			
		}
		
	}
}
