package mosaic.services.design
{
    import mosaic.controller.events.DesignSaveEvent;
    import mosaic.services.BaseSolSavingService;

    public class DesignSolSavingService extends BaseSolSavingService implements IDesignSavingService
    {
        [Inject]
        public var designToDataParser:IDesignToDataParser;

        public function saveDesign(designName:String):void
        {
            save(designName);
        }

        override protected function copyData():void
        {
            var solData:Object = _sol.data;
            solData.date = new Date();
            designToDataParser.populateDataFromDesign(solData);
        }

        override protected function dispatchCompleteEvent(solName:String):void
        {
            var evt:DesignSaveEvent = new DesignSaveEvent(DesignSaveEvent.SAVE_COMPLETED, solName);
            dispatch(evt);
        }
    }
}