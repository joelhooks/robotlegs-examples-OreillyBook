package mosaic.controller.events
{

    import flash.events.Event;

    import mosaic.view.ui.colorselectors.events.ColorChangeEvent;

    public class WorkspaceColorEvent extends ColorChangeEvent
    {

        public static const COLOR_CHANGED:String = "WorkspaceColorEvent.colorChanged";
        public static const COLOR_LOADED:String = "WorkspaceColorEvent.colorLoaded";

        public function WorkspaceColorEvent(type:String, color:uint)
        {
            super(type, color);
        }

        override public function clone():Event
        {
            return new WorkspaceColorEvent(type, _color);
        }

    }
}