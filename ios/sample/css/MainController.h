
# ifndef __MAIN_CTLR_3760BCBDD48341F194A558832CD20781_H_INCLUDED
# define __MAIN_CTLR_3760BCBDD48341F194A558832CD20781_H_INCLUDED

NNTAPP_BEGIN

class MainView
: public ui::View<MainView>
{
public:
    MainView();
    void layout_subviews();
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
