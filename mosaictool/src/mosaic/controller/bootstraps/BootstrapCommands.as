package mosaic.controller.bootstraps
{
    import mosaic.controller.commands.ApplyConfigWorkspaceColorCommand;
    import mosaic.controller.commands.ChangeGroutColorCommand;
    import mosaic.controller.commands.ChangeWorkspaceColorCommand;
    import mosaic.controller.commands.CreateConfigCommand;
    import mosaic.controller.commands.CreateDesignColorsCommand;
    import mosaic.controller.commands.LoadConfigCommand;
    import mosaic.controller.commands.LoadDesignCommand;
    import mosaic.controller.commands.NewDesignCommand;
    import mosaic.controller.commands.RequestLoadFirstDesignCommand;
    import mosaic.controller.commands.RestoreGridStatusCommand;
    import mosaic.controller.commands.SaveConfigCommand;
    import mosaic.controller.commands.SaveDesignCommand;
    import mosaic.controller.commands.UpdateCurrentDesignOnConfigCommand;
    import mosaic.controller.events.ConfigChangedEvent;
    import mosaic.controller.events.DesignCreationEvent;
    import mosaic.controller.events.DesignEvent;
    import mosaic.controller.events.DesignLoadEvent;
    import mosaic.controller.events.DesignSaveEvent;
    import mosaic.controller.events.GridReadyEvent;
    import mosaic.controller.events.GroutEvent;
    import mosaic.controller.events.MosaicConfigServiceEvent;
    import mosaic.controller.events.NamedDesignEvent;
    import mosaic.controller.events.WorkspaceColorEvent;

    import org.robotlegs.base.ContextEvent;
    import org.robotlegs.core.ICommandMap;

    public class BootstrapCommands
    {
        public function BootstrapCommands(commandMap:ICommandMap)
        {
            commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, LoadConfigCommand, ContextEvent, true);

            commandMap.mapEvent(MosaicConfigServiceEvent.LOAD_COMPLETED, RequestLoadFirstDesignCommand, MosaicConfigServiceEvent, true);
            commandMap.mapEvent(MosaicConfigServiceEvent.LOAD_COMPLETED, ApplyConfigWorkspaceColorCommand, MosaicConfigServiceEvent, true);
            commandMap.mapEvent(MosaicConfigServiceEvent.CONFIG_NOT_FOUND, CreateConfigCommand, MosaicConfigServiceEvent, true);
            commandMap.mapEvent(MosaicConfigServiceEvent.CONFIG_CREATED, SaveConfigCommand, MosaicConfigServiceEvent, true);

            commandMap.mapEvent(ConfigChangedEvent.CHANGED, SaveConfigCommand, ConfigChangedEvent);

            commandMap.mapEvent(DesignLoadEvent.LOAD_REQUESTED, LoadDesignCommand, DesignLoadEvent);
            commandMap.mapEvent(DesignSaveEvent.SAVE_REQUESTED, SaveDesignCommand, DesignSaveEvent);
            commandMap.mapEvent(DesignCreationEvent.DESIGN_CREATED, NewDesignCommand, DesignCreationEvent);
            commandMap.mapEvent(DesignCreationEvent.DESIGN_CREATED, UpdateCurrentDesignOnConfigCommand, NamedDesignEvent);
            commandMap.mapEvent(DesignLoadEvent.LOAD_COMPLETED, UpdateCurrentDesignOnConfigCommand, NamedDesignEvent);
            commandMap.mapEvent(DesignEvent.DESIGN_MODEL_CHANGED, CreateDesignColorsCommand, DesignEvent);

            commandMap.mapEvent(GroutEvent.COLOR_CHANGED, ChangeGroutColorCommand, GroutEvent);

            commandMap.mapEvent(GridReadyEvent.READY, RestoreGridStatusCommand, GridReadyEvent);

            commandMap.mapEvent(WorkspaceColorEvent.COLOR_CHANGED, ChangeWorkspaceColorCommand, WorkspaceColorEvent);
        }
    }
}