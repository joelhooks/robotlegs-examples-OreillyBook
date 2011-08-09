package robotlegs.examples.kanban.service.mock
{
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;

    public class MockEventDispatcher implements IEventDispatcher
    {
        private var eventDispatcher:EventDispatcher = new EventDispatcher();

        public var dispatchedEventTypes:Array = [];

        public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
        {
            eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
        }

        public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
        {
            eventDispatcher.removeEventListener(type, listener, useCapture);
        }

        public function dispatchEvent(event:Event):Boolean
        {
            dispatchedEventTypes.push(event.type);
            return eventDispatcher.dispatchEvent(event);
        }

        public function hasEventListener(type:String):Boolean
        {
            return true;
        }

        public function willTrigger(type:String):Boolean
        {
            return eventDispatcher.willTrigger(type);
        }

        public function MockEventDispatcher()
        {
        }
    }
}