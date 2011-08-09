package robotlegs.examples.kanban.view
{
    import org.robotlegs.mvcs.Mediator;

    import robotlegs.examples.kanban.model.events.StatusesUpdatedEvent;

    public class StatusGroupMediator extends Mediator
    {
        [Inject]
        public var view:StatusGroup;

        override public function onRegister():void
        {
            addContextListener(StatusesUpdatedEvent.UPDATED, statusesLoadedHandler);
        }

        private function statusesLoadedHandler(event:StatusesUpdatedEvent):void
        {
            view.dataProvider = event.statuses;
        }
    }
}