package mosaic.view.grid
{
    public class Griderator
    {
        public function build(rows:uint, columns:uint, action:Function, rowClass:Class):Array
        {
            var builtVector:Array = [];
            var iLength:uint = rows;
            var jLength:uint = columns;

            for (var i:int = 0; i < iLength; i++)
            {
                builtVector[i] = new rowClass();
                for (var j:int = 0; j < jLength; j++)
                {
                    builtVector[i][j] = action(i, j);
                }
            }
            return builtVector;
        }

        public function apply(to:*, using:*, action:Function):void
        {
            if (to.length != using.length || to[0].length != using[0].length)
            {
                return;
            }

            var iLength:uint = to.length;
            var jLength:uint = to[0].length;

            for (var i:int = 0; i < iLength; i++)
            {
                for (var j:int = 0; j < jLength; j++)
                {
                    action(to[i][j], using[i][j]);
                }
            }
        }
    }
}