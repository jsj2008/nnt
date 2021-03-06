
# ifndef __MAIN_CTLR_B72131B63D10417CBE74FAFC5DA61C05_H_INCLUDED
# define __MAIN_CTLR_B72131B63D10417CBE74FAFC5DA61C05_H_INCLUDED

NNTAPP_BEGIN

class MainView
: public ui::View<MainView>
{
public:
    
    MainView();
    void layout_subviews();
    
    void act_click();
    
    ui::LayoutGrid grid;
};

class MainController
: public ui::Controller<MainController, MainView>
{
public:
    
    MainController();
    void view_loaded();
    
};

NNTAPP_END

# endif
