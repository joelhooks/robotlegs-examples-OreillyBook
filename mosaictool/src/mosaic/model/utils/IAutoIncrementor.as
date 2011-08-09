package mosaic.model.utils
{
    public interface IAutoIncrementor
    {
        function set currentIndex(value:uint):void;

        function get nextIndex():uint;

        function indexUsed(value:uint):void;

        function reset():void;
    }
}

