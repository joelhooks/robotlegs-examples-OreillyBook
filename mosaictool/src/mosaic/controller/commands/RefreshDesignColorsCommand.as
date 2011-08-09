package mosaic.controller.commands
{

    import mosaic.controller.events.DesignEvent;
    import mosaic.model.IDesignToColorsTranslator;
    import mosaic.model.IMosaicDesignModel;
    import mosaic.model.IMosaicSpecModel;
    import mosaic.model.ITileSuppliesModel;
    import mosaic.model.TileSupplyVO;

    import org.robotlegs.mvcs.Command;

    public class RefreshDesignColorsCommand extends Command
    {
        [Inject]
        public var tileSupplies:ITileSuppliesModel;

        [Inject]
        public var designModel:IMosaicDesignModel;

        [Inject]
        public var designToColorsTranslator:IDesignToColorsTranslator;

        [Inject]
        public var specModel:IMosaicSpecModel;

        override public function execute():void
        {
            var designGrid:Vector.<Vector.<uint>> = designModel.getDesign();

            var defaultTileColor:uint = specModel.defaultTileColor;
            var supplyList:Vector.<TileSupplyVO> = tileSupplies.supplyList;

            var processedDesign:Vector.<Vector.<uint>>;
            processedDesign = designToColorsTranslator.processDesign(designGrid, supplyList, defaultTileColor);

            dispatchDesign(processedDesign);
        }

        protected function dispatchDesign(design:Vector.<Vector.<uint>>):void
        {
            var evt:DesignEvent = new DesignEvent(DesignEvent.DESIGN_COLORS_CHANGED, design);
            dispatch(evt);
        }

    }
}