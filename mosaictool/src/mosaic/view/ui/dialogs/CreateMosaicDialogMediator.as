package mosaic.view.ui.dialogs
{
    import flash.events.MouseEvent;

    import mosaic.controller.events.DesignCreationEvent;

    import org.robotlegs.mvcs.Mediator;

    public class CreateMosaicDialogMediator extends Mediator
    {
        [Inject]
        public var view:CreateMosaicDialog;

        override public function onRegister():void
        {
            eventMap.mapListener(view.createButton, MouseEvent.CLICK, dispatchDesignCreated, MouseEvent);
        }

        protected function dispatchDesignCreated(e:MouseEvent):void
        {
            dispatch(new DesignCreationEvent(DesignCreationEvent.DESIGN_CREATED, view.rows, view.columns, view.designName));
        }

    }
}