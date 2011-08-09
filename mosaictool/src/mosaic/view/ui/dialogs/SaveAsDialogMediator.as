package mosaic.view.ui.dialogs
{
    import flash.events.MouseEvent;

    import mosaic.controller.events.DesignSaveEvent;

    import org.robotlegs.mvcs.Mediator;

    public class SaveAsDialogMediator extends Mediator
    {
        [Inject]
        public var view:SaveAsDialog;

        override public function onRegister():void
        {
            eventMap.mapListener(view.saveButton, MouseEvent.CLICK, dispatchSaveAsRequest, MouseEvent);
        }

        protected function dispatchSaveAsRequest(e:MouseEvent):void
        {
            dispatch(new DesignSaveEvent(DesignSaveEvent.SAVE_AS_REQUESTED, view.designName));
        }
    }
}