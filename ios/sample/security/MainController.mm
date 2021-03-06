
# include "Foundation+NNT.h"
# include "MainController.h"
# include "Security+NNT.h"

NNTAPP_BEGIN

MainView::MainView()
{    
    btn_base64_decode.set_text(@"base64::decode");
    btn_base64_encode.set_text(@"base64::encode");
    add_sub(btn_base64_decode);
    add_sub(btn_base64_encode);
    btn_base64_decode.connect(kSignalButtonClicked, _action(MainView::act_base64_decode), this);
    btn_base64_encode.connect(kSignalButtonClicked, _action(MainView::act_base64_encode), this);
    
    btn_sha1.set_text(@"SHA1");
    btn_sha2.set_text(@"SHA2");
    add_sub(btn_sha1);
    add_sub(btn_sha2);
    btn_sha1.connect(kSignalButtonClicked, _action(_class::act_sha1), this);
    btn_sha2.connect(kSignalButtonClicked, _action(_class::act_sha2), this);
    
    btn_ec_en.set_text(@"EC::encode");
    btn_ec_de.set_text(@"EC::decode");
    add_sub(btn_ec_en);
    add_sub(btn_ec_de);
    btn_ec_en.connect(kSignalButtonClicked, _action(_class::act_ec_en), this);
    btn_ec_de.connect(kSignalButtonClicked, _action(_class::act_ec_de), this);
}

void MainView::act_base64_decode()
{
    core::string str = "SGVsbG8sIEJhc2U2NCE=";
    core::data da = base64::decode(core::type_cast<core::data>(str));
    str = core::type_cast<core::string>(da);
    core::Msgbox::info(core::type_cast<ns::String>(str));
}

void MainView::act_base64_encode()
{
    core::string str = "Hello, Base64!";
    core::data da = base64::encode(core::type_cast<core::data>(str));
    str = core::type_cast<core::string>(da);
    core::Msgbox::info(core::type_cast<ns::String>(str));
}

void MainView::act_sha1()
{
    core::string str = "ABC";
    core::data da = sha1::digest(core::type_cast<core::data>(str));
    str = core::present_cast<core::string>(da);
    core::Msgbox::info(core::type_cast<ns::String>(str));
}

void MainView::act_sha2()
{
    core::string str = "ABC";
    core::data da = sha2::digest384(core::type_cast<core::data>(str));
    str = core::present_cast<core::string>(da);
    core::Msgbox::info(core::type_cast<ns::String>(str));
}

void MainView::act_ec_en()
{
    /*
    //core::data pass = core::type_cast<core::data, core::string>("KEY");
    ecc ec;
    ec.generate();//(pass);
    core::string str = "ABC";
    core::data result;
    ec.encrypt(core::type_cast<core::data>(str), result);
    str = core::present_cast<core::string>(result);
    core::Msgbox::info(core::type_cast<ns::String>(str));
     */
}

void MainView::act_ec_de()
{
    
}

void MainView::layout_subviews()
{
    layout::vbox lyt_main(bounds(), 5);
    layout::linear lnr_main(lyt_main);
    lnr_main << (flex)1 << (flex)1 << (flex)1;
    
    {
        layout::hbox lyt(lyt_main << lnr_main);
        layout::linear lnr(lyt);
        lnr << (flex)1 << (flex)1;
        
        btn_base64_decode.set_frame(lyt << lnr);
        btn_base64_encode.set_frame(lyt << lnr);
    }
    
    {
        layout::hbox lyt(lyt_main << lnr_main);
        layout::linear lnr(lyt);
        lnr << (flex)1 << (flex)1;
        
        btn_sha1.set_frame(lyt << lnr);
        btn_sha2.set_frame(lyt << lnr);
    }
    
    {
        layout::hbox lyt(lyt_main << lnr_main);
        layout::linear lnr(lyt);
        lnr << (flex)1 << (flex)1;
        
        btn_ec_en.set_frame(lyt << lnr);
        btn_ec_de.set_frame(lyt << lnr);
    }
}

void MainController::view_loaded()
{
    
}

NNTAPP_END
