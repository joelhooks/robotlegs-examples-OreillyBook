package mosaic.controller.bootstraps
{
    import mosaic.controller.commands.AddTileSupplyCommand;
    import mosaic.controller.commands.ChangeDefaultTileColorCommand;
    import mosaic.controller.commands.ChangeTileSupplyColorCommand;
    import mosaic.controller.commands.RefreshDesignColorsCommand;
    import mosaic.controller.commands.SelectTileSupplyCommand;
    import mosaic.controller.commands.UpdateDesignCommand;
    import mosaic.controller.events.TileColorChangeEvent;
    import mosaic.controller.events.TileSupplyEvent;

    import org.robotlegs.core.ICommandMap;

    public class BootstrapTileSupplyCommands extends Object
    {

        public function BootstrapTileSupplyCommands(commandMap:ICommandMap)
        {
            commandMap.mapEvent(TileSupplyEvent.COLOR_CHANGED, ChangeTileSupplyColorCommand, TileSupplyEvent);
            commandMap.mapEvent(TileSupplyEvent.COLOR_CHANGED, RefreshDesignColorsCommand, TileSupplyEvent);
            commandMap.mapEvent(TileSupplyEvent.SUPPLY_ADDITION_REQUESTED, AddTileSupplyCommand, TileSupplyEvent);
            commandMap.mapEvent(TileSupplyEvent.SUPPLY_SELECTED, SelectTileSupplyCommand, TileSupplyEvent);

            commandMap.mapEvent(TileColorChangeEvent.CHANGED, UpdateDesignCommand, TileColorChangeEvent);
            commandMap.mapEvent(TileColorChangeEvent.DEFAULT_CHANGED, ChangeDefaultTileColorCommand, TileColorChangeEvent);
            commandMap.mapEvent(TileColorChangeEvent.DEFAULT_CHANGED, RefreshDesignColorsCommand, TileColorChangeEvent);
        }
    }
}       