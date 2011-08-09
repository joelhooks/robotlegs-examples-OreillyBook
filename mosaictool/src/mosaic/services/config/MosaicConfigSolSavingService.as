package mosaic.services.config
{
    import mosaic.controller.events.MosaicConfigServiceEvent;
    import mosaic.model.IConfigModel;
    import mosaic.services.BaseSolSavingService;

    public class MosaicConfigSolSavingService extends BaseSolSavingService implements IMosaicConfigSavingService
    {
        [Inject]
        public var configModel:IConfigModel;

        public function saveConfig(configName:String):void
        {
            save(configName);
        }

        override protected function copyData():void
        {
            var solData:Object = _sol.data;
            solData.workspaceColor = configModel.workspaceColor;
            solData.currentDesign = configModel.currentDesign;
            solData.designNames = configModel.designNames;
        }

        override protected function dispatchCompleteEvent(solName:String):void
        {
            var evt:MosaicConfigServiceEvent = new MosaicConfigServiceEvent(MosaicConfigServiceEvent.SAVE_COMPLETED);
            dispatch(evt);
        }
    }
}