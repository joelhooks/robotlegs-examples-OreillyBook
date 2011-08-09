package mosaic.controller.bootstraps
{
    import mosaic.model.DesignToColorsTranslator;
    import mosaic.model.IDesignToColorsTranslator;

    import org.robotlegs.core.IInjector;

    public class BootstrapClasses extends Object
    {
        public function BootstrapClasses(injector:IInjector)
        {
            injector.mapClass(IDesignToColorsTranslator, DesignToColorsTranslator);
        }
    }
}