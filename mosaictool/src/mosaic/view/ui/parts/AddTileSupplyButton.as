package mosaic.view.ui.parts
{

    public class AddTileSupplyButton extends DeleteTileSupplyButton
    {

        public function AddTileSupplyButton()
        {
            super();
        }

        override protected function addIcon():void
        {
            _icon = new DeleteIcon();
            _icon.rotationX = 0;
            _icon.rotationY = 0;
            _icon.rotation = 45;
            addChild(_icon);
        }

    }

}