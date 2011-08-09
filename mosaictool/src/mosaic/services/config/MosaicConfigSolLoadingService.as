package mosaic.services.config
{
    import mosaic.controller.events.MosaicConfigServiceEvent;
    import mosaic.model.IConfigModel;
    import mosaic.services.BaseSolLoadingService;

    public class MosaicConfigSolLoadingService extends BaseSolLoadingService implements IMosaicConfigLoadingService
    {
        [Inject]
        public var configModel:IConfigModel;

        public function loadConfig(configName:String):void
        {
            _requiredPropertyName = "designNames";
            loadSolData(configName);
        }

        override protected function dispatchNotFound(solName:String):void
        {
            var evt:MosaicConfigServiceEvent = new MosaicConfigServiceEvent(MosaicConfigServiceEvent.CONFIG_NOT_FOUND);
            dispatch(evt);
        }

        override protected function updateModel(data:Object):Boolean
        {
            var designNames:Vector.<String> = Vector.<String>(data.designNames);
            var currentDesign:String = data.currentDesign;
            var workspaceColor:uint = data.workspaceColor;

            // not validating workspaceColor because a null uint is 0 which is black, and thus valid
            if (designNames && currentDesign)
            {
                configModel.designNames = designNames;
                configModel.currentDesign = currentDesign;
                configModel.workspaceColor = workspaceColor;
                return true;
            }
            return false;
        }

        override protected function dispatchLoadCompleted(solName:String):void
        {
            var evt:MosaicConfigServiceEvent = new MosaicConfigServiceEvent(MosaicConfigServiceEvent.LOAD_COMPLETED);
            dispatch(evt);
        }

        override protected function dispatchLoadFailed(solName:String):void
        {
            var evt:MosaicConfigServiceEvent = new MosaicConfigServiceEvent(MosaicConfigServiceEvent.LOAD_FAILED);
            dispatch(evt);
        }
    }
}