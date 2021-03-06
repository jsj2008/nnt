
# include "Core.h"
# include "DBMS.h"

# include "Bdb+NNT.h"
# include "Sqlite+NNT.h"
# include "MySql+NNT.h"
//# include "Oracle+NNT.h"
//# include "PostgreSql+NNT.h"
# include "SqlServer+NNT.h"

NNT_BEGIN_CXX
NNT_BEGIN_NS(store)

class map_drivers
{
public:
    map_drivers()
    {
        drivers[Bdb::identity] = Bdb::dbmsInstance;
        drivers[Sqlite::identity] = Sqlite::dbmsInstance;
        drivers[MySql::identity] = MySql::dbmsInstance;
        //drivers[Oracle::identity] = Oracle::dbmsInstance;
        //drivers[PostgreSql::identity] = PostgreSql::dbmsInstance;
        drivers[SqlServer::identity] = SqlServer::dbmsInstance;
    }
    
    typedef core::map<core::string, IDBMS* (*)()> drivers_type;
    drivers_type drivers;
};

IDBMS* instanceDatabaseByIdentity(core::string const& identity)
{
    static map_drivers drivers;
    
    map_drivers::drivers_type::const_iterator found = drivers.drivers.find(identity);
    if (found == drivers.drivers.end())
        return NULL;
    
    IDBMS* ret = found->second();
    
    return ret;
}

NNT_END_NS
NNT_END_CXX
