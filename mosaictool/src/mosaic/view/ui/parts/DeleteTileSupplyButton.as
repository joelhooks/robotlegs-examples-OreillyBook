package mosaic.view.ui.parts
{
    import flash.display.Sprite;
    import flash.events.MouseEvent;

    public class DeleteTileSupplyButton extends Sprite
    {
        protected static const OUT_COLOR:uint = 0xFFFFFF;
        protected static const OVER_COLOR:uint = 0xFF0000;

        protected var _icon:DeleteIcon;

        public function DeleteTileSupplyButton()
        {
            addIcon();
            addRolloverBehaviour();
        }

        protected function addIcon():void
        {
            _icon = new DeleteIcon();
            addChild(_icon);
        }

        protected function addRolloverBehaviour():void
        {
            addEventListener(MouseEvent.ROLL_OVER, showRollOver, false, 0, true);
            addEventListener(MouseEvent.ROLL_OUT, showNormal, false, 0, true);
        }

        protected function showRollOver(e:MouseEvent):void
        {
            _icon.iconColor = OVER_COLOR;
        }

        protected function showNormal(e:MouseEvent):void
        {
            _icon.iconColor = OUT_COLOR;
        }
    }
}