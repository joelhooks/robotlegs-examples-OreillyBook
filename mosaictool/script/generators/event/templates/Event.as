package <%= package_name %> 
{          
	import flash.events.Event;
	
	public class <%= class_name %> extends Event {
		
		public static const <%= subject_class_name %>:String = "<%= class_name %>.";
		
		public function <%= class_name %>(type:String){
			super(type);		
		}
		
		override public function clone() : Event {
			return new <%= class_name %>(type);
		}
		
	}
}