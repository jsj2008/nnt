
# ifndef __NNT_SECURITY_EC_1C1EE0C930FE43A4B1D2E4ADEA8707F0_H_INCLUDED
# define __NNT_SECURITY_EC_1C1EE0C930FE43A4B1D2E4ADEA8707F0_H_INCLUDED

NNT_BEGIN_HEADER_CXX

NNTCLASS(ecc);

NNTDECL_PRIVATE_HEAD_CXX(ecc);

class ecc
{
    NNTDECL_PRIVATE_CXX(ecc);

public:

    ecc();
    ~ecc();

    //! generate public & private key.
    bool generate();


};

NNT_END_HEADER_CXX

# endif
