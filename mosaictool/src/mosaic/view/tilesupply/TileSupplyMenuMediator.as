package mosaic.view.tilesupply
{
    import flash.events.MouseEvent;

    import mosaic.controller.events.TileSupplyEvent;
    import mosaic.controller.events.TileSupplyListEvent;
    import mosaic.model.TileSupplyVO;

    import org.robotlegs.mvcs.Mediator;

    public class TileSupplyMenuMediator extends Mediator
    {
        [Inject]
        public var view:TileSupplyMenu;

        override public function onRegister():void
        {
            eventMap.mapListener(view.addButton, MouseEvent.CLICK, dispatchSupplyAdditionRequested, MouseEvent);
            addContextListener(TileSupplyEvent.SUPPLY_ADDED, addSupplyToView, TileSupplyEvent);
            addContextListener(TileSupplyListEvent.CHANGED, setNewSupplyListOnView, TileSupplyListEvent);
        }

        protected function dispatchSupplyAdditionRequested(e:MouseEvent):void
        {
            var evt:TileSupplyEvent = new TileSupplyEvent(TileSupplyEvent.SUPPLY_ADDITION_REQUESTED, 0, 0xFF0000, 0);
            dispatch(evt);
        }

        protected function addSupplyToView(e:TileSupplyEvent):void
        {
            view.addSupply(e.id, e.color, 0);
        }

        protected function setNewSupplyListOnView(e:TileSupplyListEvent):void
        {
            view.clear();

            var supplyList:Vector.<TileSupplyVO> = e.supplyList;

            var iLength:uint = supplyList.length;
            for (var i:int = 0; i < iLength; i++)
            {
                var supply:TileSupplyVO = supplyList[i];
                view.addSupply(supply.id, supply.color, supply.count);
            }
        }
    }
}