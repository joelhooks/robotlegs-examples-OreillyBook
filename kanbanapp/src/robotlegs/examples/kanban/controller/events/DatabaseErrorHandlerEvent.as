package robotlegs.examples.kanban.controller.events
{
    import flash.events.Event;

    public class DatabaseErrorHandlerEvent extends Event
    {
        public static const ERROR:String = "DatabaseErrorHandlerEvent";

        private var _message:String;

        public function get message():String
        {
            return _message;
        }

        public function DatabaseErrorHandlerEvent(message:String)
        {
            super(ERROR);
            _message = message;
        }

        override public function clone():Event
        {
            return new DatabaseErrorHandlerEvent(message)
        }
    }
}