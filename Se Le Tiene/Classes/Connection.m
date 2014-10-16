//
//  Connection.m
//  Hackaton
//
//  Created by Jorge Raul Ovalle Zuleta on 3/29/14.
//  Copyright (c) 2014 jomobile.co. All rights reserved.
//

#import "Connection.h"

@implementation Connection
@synthesize returnList;

-(id)init{
    self = [super init];
    if (self) {
        returnList = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void) copyDataBase{
    NSString *path1 =[[NSBundle bundleForClass:[self class]] pathForResource:@"SLT" ofType:@"db"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *writableDBPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"SLT.db"];
    NSError *err;
    NSLog(@"Copiando");
    [[NSFileManager defaultManager] removeItemAtPath:writableDBPath error:&err];
    [[NSFileManager defaultManager] copyItemAtPath:path1 toPath:writableDBPath error:&err];
    if (err != nil) {
        NSLog(@"Err desc-%@", [err localizedDescription]);
        NSLog(@"Err reason-%@", [err localizedFailureReason]);
    }
}

-(NSString *) filePath{
    //return [[NSBundle bundleForClass:[self class]] pathForResource:@"eldorado" ofType:@"db"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"SLT.db"];
    NSFileManager *fileManager = [NSFileManager defaultManager];//create instance of NSFileManager
    if ( ![fileManager fileExistsAtPath:writableDBPath] ) {
        /* File doesn't exist. Save the image at the path */
        [self copyDataBase];
    }
    return writableDBPath;
}

//open the db
-(void)openDB {
    if(sqlite3_open([[self filePath] UTF8String], &db)!= SQLITE_OK){
        sqlite3_close(db);
        NSAssert(0,@"Database failed to open");
    }else{
        NSLog(@"database opened");
    }
}

-(void)createSession:(NSString*)token{
    char *errorMsg;
    NSString *query = [NSString stringWithFormat:@"INSERT INTO User (token) VALUES ('%@');",token];
    if (sqlite3_exec(db, [query UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
        NSLog(@"DB Error. '%s'", sqlite3_errmsg(db));
    }
}
-(void)deleteSession{
    char *errorMsg;
    NSString *query = @"delete from User";
    if (sqlite3_exec(db, [query UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
        NSLog(@"DB Error. '%s'", sqlite3_errmsg(db));
    }
}
-(NSString*)checkSession{
    NSString* token = @"";
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM User;"];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK)
    {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            char *field1 = (char *) sqlite3_column_text(statement, 1);
            token = [[NSString alloc]initWithUTF8String:field1];
        }
    }else{
        NSLog(@"Fallo al realizar query");
    }
    return token;
}

@end



