package robotlegs.examples.kanban.controller
{
    import org.robotlegs.mvcs.Command;

    import robotlegs.examples.kanban.service.IStatusService;

    public class LoadStatusesCommand extends Command
    {
        [Inject]
        public var statusService:IStatusService;

        override public function execute():void
        {
            statusService.loadStatuses();
        }
    }
}