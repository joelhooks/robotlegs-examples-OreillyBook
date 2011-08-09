package robotlegs.examples.kanban.controller.bootstrap
{
    import flash.filesystem.File;

    import org.robotlegs.mvcs.Command;

    import robotlegs.examples.kanban.service.events.DatabaseReadyEvent;
    import robotlegs.examples.kanban.service.helpers.DatabaseCreator;
    import robotlegs.examples.kanban.service.helpers.ISQLRunnerDelegate;
    import robotlegs.examples.kanban.service.helpers.SQLRunnerDelegate;

    public class ConfigureDatabaseCommand extends Command
    {
        private static const DB_FILE_NAME:String = "KanBan.db";

        override public function execute():void
        {
            var dbFile:File = File.applicationStorageDirectory.resolvePath(DB_FILE_NAME);
            var sqlRunner:ISQLRunnerDelegate = new SQLRunnerDelegate(dbFile);

            injector.mapValue(ISQLRunnerDelegate, sqlRunner);

            if (!dbFile.exists)
            {
                //We use the injector to instantiate the DatabaseCreator here because
                //we want to inject the SQLRunner that is mapped above. This works
                //well even though the DatabaseCreator is not a mapped object, we still
                //get access to injections from Robotlegs by creating it this way!
                var creator:DatabaseCreator = injector.instantiate(DatabaseCreator);
                creator.createDatabaseStructure();
            }
            else
            {
                dispatch(new DatabaseReadyEvent());
            }


        }
    }
}