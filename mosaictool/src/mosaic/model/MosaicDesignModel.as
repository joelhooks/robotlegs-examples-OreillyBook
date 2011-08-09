package mosaic.model
{
    import mosaic.controller.events.DesignEvent;

    import org.robotlegs.mvcs.Actor;

    public class MosaicDesignModel extends Actor implements IMosaicDesignModel
    {
        protected var _designGrid:Vector.<Vector.<uint>>;

        public function loadDesign(designGrid:Vector.<Vector.<uint>>):void
        {
            _designGrid = designGrid;
            dispatch(new DesignEvent(DesignEvent.DESIGN_MODEL_CHANGED, designGrid));
        }

        public function getDesign():Vector.<Vector.<uint>>
        {
            return _designGrid;
        }

        public function changeTileColorAt(row:uint, column:uint, colorID:uint):uint
        {
            var colorIDWas:uint = _designGrid[row][column];
            _designGrid[row][column] = colorID;
            return colorIDWas;
        }

        public function switchTileColors(colorIDWas:uint, colorIDNow:uint):void
        {
            var iLength:uint = _designGrid.length;
            var jLength:uint = _designGrid[0].length;

            for (var i:int = 0; i < iLength; i++)
            {
                for (var j:int = 0; j < jLength; j++)
                {
                    if (_designGrid[i][j] == colorIDWas)
                    {
                        _designGrid[i][j] = colorIDNow;
                    }
                }
            }
        }
    }
}