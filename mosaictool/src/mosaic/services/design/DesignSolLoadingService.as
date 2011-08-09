package mosaic.services.design
{
    import mosaic.controller.events.DesignLoadEvent;
    import mosaic.services.BaseSolLoadingService;

    public class DesignSolLoadingService extends BaseSolLoadingService implements IDesignLoadingService
    {
        [Inject]
        public var designParser:IDesignFromDataParser;

        public function loadDesign(designName:String):void
        {
            _requiredPropertyName = "date";
            loadSolData(designName);
        }

        override protected function updateModel(data:Object):Boolean
        {
            return designParser.populateDesignFromData(data);
        }

        override protected function dispatchNotFound(solName:String):void
        {
            dispatchLoadFailed(solName);
        }

        ;

        override protected function dispatchLoadCompleted(solName:String):void
        {
            var evt:DesignLoadEvent = new DesignLoadEvent(DesignLoadEvent.LOAD_COMPLETED, solName);
            dispatch(evt);
        }

        ;

        override protected function dispatchLoadFailed(solName:String):void
        {
            var evt:DesignLoadEvent = new DesignLoadEvent(DesignLoadEvent.LOAD_FAILED, solName);
            dispatch(evt);
        }

    }
}