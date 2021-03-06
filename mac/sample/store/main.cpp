
# include <wsi/WSIFoundation.h>

# include <wsi/Store/WSISqlServer.h>
# include <wsi/Store/WSIPostgreSql.h>
# include <wsi/Store/WSIBdb.h>
# include <wsi/Store/WSIMySql.h>
# include <wsi/Store/WSISqlite.h>
# include <wsi/Store/WSIOracle.h>

# include <wsi/Store/ArchiveZip.h>
# include <wsi/Store/ArchiveRAR.h>
# include <wsi/Store/Archive7Z.h>

using namespace wsi;

static void test_database()
{
    // connect sqlite.
    if (0)
    {
        store::Sqlite sqlite;
        store::connection_info info;
        info.url = "sqlite.db";
        sqlite.connect(info);
        
        store::datatable_t* dt = NULL;
        
        if (1)
        {
            dt = sqlite.exec("select * from TEST");
            trace_msg(dt->to_string());
            dt->drop();
        }
        
        if (1)
        {
            dt = sqlite.exec("select * from TEST where ID = :id",
                             core::push_back<store::Sqlite::params_type>(
                                                                         core::make_pair(":id", variant_t(1))
                                                                         ));
            trace_msg(dt->to_string());
            dt->drop();
        }
    }
    
    // connect mysql.
    if (0)
    {
        store::MySql mysql;
        store::connection_info info;
        info.url = "localhost";
        info.user = "root";
        info.passwd = "root";
        info.database = "test";
        mysql.connect(info);
        
        store::datatable_t* dt = NULL;
        
        if (1)
        {
            dt = mysql.exec("select * from test");
            trace_msg(dt->to_string());
            dt->drop();
        }
        
        if (1)
        {
            dt = mysql.exec("select * from test where test = ?", 
                            core::push_back<store::MySql::params_type>(
                                                                       core::make_pair("", variant_t(1))
                                                                       ));
            //dt = mysql.exec("select * from test where test = 1", store::MySql::params_type());
            trace_msg(dt->to_string());
            dt->drop();
        }
    }
    
    // connect sqlserver.
    if (0)
    {
        store::SqlServer sqlsrv;
        store::connection_info info;
        info.url = "wybo-win";
        info.user = "test";
        info.passwd = "test";
        info.database = "TEST";
        sqlsrv.connect(info);
        
        store::datatable_t* dt = NULL;
        
        if (1)
        {
            dt = sqlsrv.exec("select * from TEST");
            trace_msg(dt->to_string());
            dt->drop();
        }
        
        if (1)
        {
            dt = sqlsrv.exec("select * from TEST where ID = @id; select * from TEST where NAME = @name;", 
                             core::push_back<store::MySql::params_type>(
                                                                        core::make_pair("id", variant_t(1)),
                                                                        core::make_pair("name", variant_t("DDDDD", core::assign))
                                                                        ));
            store::datatable_t* next = dt;
            while (next)
            {
                trace_msg(next->to_string());
                next = next->next;
            }
            dt->drop();
        }
    }
    
    // connect postgresql.
    if (0)
    {
        store::PostgreSql pgsql;
        store::connection_info info;
        info.url = "localhost:5432";
        info.user = "postgres";
        info.passwd = "root";
        info.database = "postgres";
        pgsql.connect(info);
        
        store::datatable_t* dt = NULL;
        
        if (0)
        {
            dt = pgsql.exec("select * from \"TEST\"");
            trace_msg(dt->to_string());
            dt->drop();
        }
        
        if (1)
        {
            dt = pgsql.exec("select * from \"TEST\" where \"TEST\".\"ID\" = $1::int4",
                            core::push_back<store::PostgreSql::params_type>(
                                                                            core::make_pair("", variant_t(1))
                                                                            ));
            trace_msg(dt->to_string());
            dt->drop();
        }
    }
    
    // connect oracle.
    if (1)
    {
        store::test::Oracle ora;
        ut::Suite su;
        su.add(&ora);
        su.run();
    }
    
    // connect bdb.
    if (0)
    {
        store::test::Bdb ca;
        ut::Suite su;
        su.add(&ca);
        su.run();
    }
}

static void test_compress() {
    store::UnZip unzip("phpext.zip");
    
    store::Zip zip;
    zip.target("phpext.zip.zip", true);
}

int main (int argc, const char * argv[])
{
    if (1) {
        test_database();
    }
    
    if (1) {
        test_compress();
    }
    
    return 0;
}