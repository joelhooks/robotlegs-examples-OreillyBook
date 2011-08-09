package mosaic.view.ui
{
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.events.Event;

    import mosaic.view.tilesupply.TileSupplyMenu;
    import mosaic.view.ui.buttons.CreateButton;
    import mosaic.view.ui.buttons.SaveAsButton;
    import mosaic.view.ui.buttons.SaveButton;
    import mosaic.view.ui.colorselectors.DefaultTileColorSelectorView;
    import mosaic.view.ui.colorselectors.GroutSelectorView;
    import mosaic.view.ui.colorselectors.WorkspaceColorSelectorView;

    public class EditPanelView extends Sprite
    {
        protected static const SPACING:Number = 10;
        protected static const BUTTON_X:Number = 20;
        protected static const PADDING:Number = 10;

        public function EditPanelView()
        {
            addEventListener(Event.ADDED_TO_STAGE, init)
        }

        protected function init(e:Event):void
        {
            addMainButtons();
            addColorSelectors();
            var nextPosition:Number = addAtPosition(new DesignNameView(), BUTTON_X, PADDING);
            addAtPosition(new TileSupplyMenu(), PADDING - 30, nextPosition - PADDING);
        }

        protected function addMainButtons():void
        {
            var startY:Number = stage.stageHeight - 160;
            addDistributedVertically([new SaveButton(), new SaveAsButton(), new CreateButton(), new LoadSelector()],
                    BUTTON_X, startY);
        }

        protected function addColorSelectors():void
        {
            var startY:Number = stage.stageHeight - (this.height + 50);
            addDistributedVertically([new DefaultTileColorSelectorView(), new GroutSelectorView(),
                new WorkspaceColorSelectorView()], PADDING, startY);
        }

        protected function addDistributedVertically(items:Array, xPos:Number, yPos:Number):Number
        {
            var iLength:uint = items.length;
            for (var i:int = 0; i < iLength; i++)
            {
                yPos = addAtPosition(items[i], xPos, yPos);
            }
            return yPos;
        }

        protected function addAtPosition(item:DisplayObject, xPos:Number, yPos:Number):Number
        {
            addChild(item);
            item.x = xPos;
            item.y = yPos;
            return yPos + item.height + SPACING;
        }
    }
}