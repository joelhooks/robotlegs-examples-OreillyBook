package mosaic.controller.events
{
    import flash.events.Event;

    public class NamedDesignEvent extends Event
    {

        public function NamedDesignEvent(type:String, designName:String)
        {
            _designName = designName;
            super(type);
        }

        protected var _designName:String;

        public function get designName():String
        {
            return _designName;
        }
    }
}