
# include "Foundation+NNT.h"
# include "AppDelegate.h"

NNTAPP_BEGIN

void App::load()
{
    ctlr.set_orientation(UIOrientationEnableAll);
    set_root(ctlr);
}

NNTAPP_END
