package mosaic.view.ui.events
{
    import flash.events.Event;

    public class LoadSelectorEvent extends Event
    {

        public static const LOAD_CLICKED:String = "LoadSelectorEvent.loadClicked";

        protected var _designName:String;

        public function LoadSelectorEvent(type:String, designName:String)
        {
            _designName = designName;
            super(type);
        }

        public function get designName():String
        {
            return _designName;
        }

        override public function clone():Event
        {
            return new LoadSelectorEvent(type, _designName);
        }

    }
}