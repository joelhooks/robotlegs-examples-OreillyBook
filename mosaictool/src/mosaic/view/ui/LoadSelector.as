package mosaic.view.ui
{
    import fl.controls.Button;
    import fl.controls.ComboBox;
    import fl.data.DataProvider;

    import flash.display.Sprite;
    import flash.events.MouseEvent;

    import mosaic.view.ui.events.LoadSelectorEvent;

    public class LoadSelector extends Sprite
    {
        protected static const LIST_Y:Number = 28;

        protected var _loadButton:Button;
        protected var _namesList:ComboBox;

        public function LoadSelector()
        {
            init();
        }

        public function set designList(listOfNames:Vector.<String>):void
        {
            var namesData:DataProvider = new DataProvider();
            var iLength:uint = listOfNames.length;
            for (var i:int = 0; i < iLength; i++)
            {
                var item:Object = {label:listOfNames[i]};
                namesData.addItem(item);
            }
            _namesList.dataProvider = namesData;
        }

        protected function dispatchSelection(e:MouseEvent):void
        {
            var evt:LoadSelectorEvent = new LoadSelectorEvent(LoadSelectorEvent.LOAD_CLICKED, _namesList.selectedLabel);
            dispatchEvent(evt);
        }

        protected function init():void
        {
            _loadButton = new Button();
            _loadButton.label = "Load";
            _loadButton.addEventListener(MouseEvent.CLICK, dispatchSelection);
            addChild(_loadButton);

            _namesList = new ComboBox();
            _namesList.y = LIST_Y;
            addChild(_namesList);
        }

    }
}