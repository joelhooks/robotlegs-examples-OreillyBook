package mosaic.view.grid
{

    import com.newloop.util.UnitHelpers;

    import flash.display.Shape;

    public class TileViewSupport
    {

        protected var _tileView:TileView;

        public function TileViewSupport(tileView:ITileView)
        {
            _tileView = tileView as TileView;
        }

        public function get tileColor():uint
        {
            return squareGraphic.transform.colorTransform.color;
        }

        public function get width():Number
        {
            return _tileView.width;
        }

        public function get height():Number
        {
            return _tileView.height;
        }

        protected function get squareGraphic():Shape
        {
            return UnitHelpers.findInstanceOf(_tileView, Shape) as Shape;
        }

    }
}