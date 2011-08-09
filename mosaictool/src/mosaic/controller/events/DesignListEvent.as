package mosaic.controller.events
{
    import flash.events.Event;

    public class DesignListEvent extends Event
    {
        public static const CHANGED:String = "DesignListEvent.changed";

        public function DesignListEvent(type:String, designList:Vector.<String>)
        {
            _designList = designList;
            super(type);
        }

        protected var _designList:Vector.<String>;

        public function get designList():Vector.<String>
        {
            return _designList;
        }

        override public function clone():Event
        {
            return new DesignListEvent(type, _designList);
        }

    }
}