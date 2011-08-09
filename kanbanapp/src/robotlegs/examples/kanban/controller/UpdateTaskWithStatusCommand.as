package robotlegs.examples.kanban.controller
{
    import org.robotlegs.mvcs.Command;

    import robotlegs.examples.kanban.controller.events.SaveTaskEvent;
    import robotlegs.examples.kanban.controller.events.UpdateTaskWithStatusEvent;
    import robotlegs.examples.kanban.model.vo.Task;

    public class UpdateTaskWithStatusCommand extends Command
    {
        [Inject]
        public var event:UpdateTaskWithStatusEvent;

        override public function execute():void
        {
            var task:Task = event.task;
            task.statusId = event.status.statusId;

            dispatch(new SaveTaskEvent(task));
        }
    }
}