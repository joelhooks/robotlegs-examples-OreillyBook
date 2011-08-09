package mosaic.model
{
    import flash.events.IEventDispatcher;

    public interface IConfigModel
    {

        function get designNames():Vector.<String>;

        function set designNames(names:Vector.<String>):void;

        function get hasDesign():Boolean;

        function get currentDesign():String;

        function set currentDesign(designName:String):void;

        function get workspaceColor():uint;

        function set workspaceColor(color:uint):void;

        function get eventDispatcher():IEventDispatcher;

        function set eventDispatcher(value:IEventDispatcher):void;
    }
}