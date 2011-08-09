package mosaic.view.ui
{
    import fl.controls.Label;

    import flash.display.Sprite;

    import mosaic.view.ui.parts.RightAlignedWhiteLabel;

    public class DesignNameView extends Sprite
    {
        protected var _label:Label;

        public function DesignNameView()
        {
            init();
        }

        public function setText(value:String):void
        {
            _label.text = value;
        }

        protected function init():void
        {
            _label = new RightAlignedWhiteLabel();
            addChild(_label);
        }

    }
}