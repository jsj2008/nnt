
# import "Core.h"
# import "SqliteRequest.h"
# import "Sqlite+NNT.h"
# import "Model.h"

NNT_BEGIN_OBJC

::nnt::ns::MutableDictionary __gs_databases;

@implementation SqliteRequest

@synthesize directoryType = _directoryType;

- (id)init {
    self = [super init];
    
    _directoryType = NNTDirectoryTypeBundle;
    
    return self;
}

- (NSObject*)call:(Model *)model withUrl:(NSURL*)url {
    [super call:model withUrl:url];
    
    NNTRPC_CALLROUND;
    
    // open database.
    NNTSqlite* sqlite = nil;
    NNT_SYNCHRONIZED(self)
    sqlite = __gs_databases[url];
    if (sqlite == nil) {
        sqlite = [[NNTSqlite alloc] init];
        if (NO == [sqlite openDbWith:[url relativePath] type:_directoryType]) {
            zero_release(sqlite);
        }
        else {
            __gs_databases[url] = sqlite;
        }
    }
    NNT_SYNCHRONIZED_END
    
    // end.
    if (sqlite == nil)
        return nil;
    
    NSString* method = [model get_method];
    NSArray* params = [model get_params];
    DBMSqlDatatable* dt = nil;
    if (params && params.count) {
        dt = [sqlite exec:method params:params];
    } else {
        dt = [sqlite exec:method];
    }
    
    if (dt == nil) {
        dt = [[[DBMSqlDatatable alloc] init] autorelease];
    }
     
    return dt;
}

@end

@implementation AbsSqliteRequest

- (id)init {
    self = [super init];
    
    self.directoryType = NNTDirectoryTypeAbsolute;
    
    return self;
}

@end

@implementation WritableSqliteRequest

- (id)init {
    self = [super init];
    
    self.directoryType = NNTDirectoryTypeBundleWritable;
    
    return self;
}

@end

NNT_END_OBJC
