package mosaic.model
{
    public class EmptyDesignGrid
    {

        protected var _grid:Vector.<Vector.<uint>>

        public function EmptyDesignGrid(rows:uint, columns:uint)
        {
            _grid = createGrid(rows, columns);
        }

        public function get grid():Vector.<Vector.<uint>>
        {
            return _grid;
        }

        protected function createGrid(rows:uint, columns:uint):Vector.<Vector.<uint>>
        {
            var vectorOfZeros:Vector.<Vector.<uint>> = new Vector.<Vector.<uint>>();

            var iLength:uint = rows;
            var jLength:uint = columns;

            for (var i:int = 0; i < iLength; i++)
            {
                vectorOfZeros[i] = new Vector.<uint>;

                for (var j:int = 0; j < jLength; j++)
                {
                    vectorOfZeros[i][j] = 0;
                }
            }

            return vectorOfZeros;
        }

    }

}

