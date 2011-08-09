package robotlegs.examples.kanban.view
{
    import org.robotlegs.mvcs.Mediator;

    import robotlegs.examples.kanban.controller.events.DeleteTaskEvent;
    import robotlegs.examples.kanban.controller.events.UpdateTaskWithStatusEvent;

    public class TaskLaneMediator extends Mediator
    {
        override public function onRegister():void
        {
            addViewListener(UpdateTaskWithStatusEvent.UPDATE, dispatch);
            addViewListener(DeleteTaskEvent.DELETE, dispatch);
        }
    }
}