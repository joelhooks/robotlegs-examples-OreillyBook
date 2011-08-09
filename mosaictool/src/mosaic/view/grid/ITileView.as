package mosaic.view.grid
{
    import flash.display.DisplayObject;
    import flash.events.IEventDispatcher;

    public interface ITileView extends IEventDispatcher
    {
        function set color(color_to_use:uint):void;

        function get asDisplayObject():DisplayObject;
    }

}