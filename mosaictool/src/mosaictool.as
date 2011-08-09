package
{
    import flash.display.Sprite;

    import mosaic.MosaicContext;

    public class mosaictool extends Sprite
    {

        protected var _context:MosaicContext;

        public function mosaictool()
        {
            _context = new MosaicContext(this);
        }
    }
}