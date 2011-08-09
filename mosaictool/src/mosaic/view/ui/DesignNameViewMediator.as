package mosaic.view.ui
{
    import mosaic.controller.events.DesignCreationEvent;
    import mosaic.controller.events.DesignLoadEvent;
    import mosaic.controller.events.DesignSaveEvent;

    import org.robotlegs.mvcs.Mediator;

    public class DesignNameViewMediator extends Mediator
    {
        [Inject]
        public var view:DesignNameView;

        override public function onRegister():void
        {
            addContextListener(DesignLoadEvent.LOAD_COMPLETED, updateDesignNameAfterLoad, DesignLoadEvent);
            addContextListener(DesignSaveEvent.SAVE_COMPLETED, updateDesignNameAfterSave, DesignSaveEvent);
            addContextListener(DesignCreationEvent.DESIGN_CREATED, updateDesignNameAfterCreation, DesignCreationEvent);
        }

        protected function updateDesignNameAfterLoad(e:DesignLoadEvent):void
        {
            updateViewText(e.designName);
        }

        protected function updateDesignNameAfterSave(e:DesignSaveEvent):void
        {
            updateViewText(e.designName);
        }

        protected function updateDesignNameAfterCreation(e:DesignCreationEvent):void
        {
            updateViewText(e.designName);
        }

        protected function updateViewText(designName:String):void
        {
            view.setText(designName);
        }
    }
}