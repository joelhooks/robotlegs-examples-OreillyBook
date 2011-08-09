package robotlegs.examples.kanban
{
    import org.robotlegs.mvcs.Context;

    import robotlegs.examples.kanban.controller.*;
    import robotlegs.examples.kanban.controller.bootstrap.ConfigureDatabaseCommand;
    import robotlegs.examples.kanban.controller.events.*;
    import robotlegs.examples.kanban.model.StatusListModel;
    import robotlegs.examples.kanban.model.TaskListModel;
    import robotlegs.examples.kanban.service.*;
    import robotlegs.examples.kanban.service.events.DatabaseReadyEvent;
    import robotlegs.examples.kanban.view.*;

    public class PersonalKanbanContext extends Context
    {
        override public function startup():void
        {
            mediatorMap.mapView(StatusGroup, StatusGroupMediator);
            mediatorMap.mapView(TaskLane, TaskLaneMediator);
            mediatorMap.mapView(TaskEntryBar, TaskEntryBarMediator);

            injector.mapSingletonOf(IStatusService, SQLStatusService);
            injector.mapSingletonOf(ITaskService, SQLTaskService);

            injector.mapSingleton(StatusListModel);
            injector.mapSingleton(TaskListModel);

            commandMap.mapEvent(UpdateTaskWithStatusEvent.UPDATE, UpdateTaskWithStatusCommand);
            commandMap.mapEvent(SaveTaskEvent.SAVE, SaveTaskCommand);
            commandMap.mapEvent(ConfigureDatabaseEvent.CONFIGURE, ConfigureDatabaseCommand);
            commandMap.mapEvent(DatabaseReadyEvent.READY, LoadStatusesCommand);
            commandMap.mapEvent(StatusesLoadedEvent.LOADED, LoadTasksCommand);
            commandMap.mapEvent(DeleteTaskEvent.DELETE, DeleteTaskCommand);
            commandMap.mapEvent(DatabaseErrorHandlerEvent.ERROR, DatabaseErrorHandlerCommand);

            dispatchEvent(new ConfigureDatabaseEvent())
        }
    }
}