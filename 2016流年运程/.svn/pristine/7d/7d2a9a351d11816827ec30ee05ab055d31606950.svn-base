//
//  SqliteForPeople.m
//  LiuNianYunCheng
//
//  Created by 吴冬 on 15/8/13.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import "SqliteForPeople.h"

@implementation SqliteForPeople
{
   
    NSArray *arrForKey;
    char *errorMsg;
}

- (instancetype)init
{
  
    if (self = [super init]) {
        
        arrForKey = @[@"name",@"yangli",@"wuxing",@"geju",@"shuxiang",@"ageForHomePage",@"yearsNow",@"monthNow",@"dayNow",@"hoursNow",@"hours",@"day",@"month",@"yinliSTR",@"dizhiSTR",@"tiangan",@"yinyang",@"age"];
        
        [self openDB];
        
           }
    
    return self;

}

//创建路径
- (NSString *)filePath
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    
    return [documentsDir stringByAppendingPathComponent:@"save.sqlite"];
}

- (void)openSQL
{
     NSString *pathStr = [self filePath];
    
    sqlite3_open([pathStr UTF8String], &_database);

}

//创建,打开数据库
- (BOOL)openDB
{
    //创建路径
    NSString *pathStr = [self filePath];
    
    NSLog(@"%@",pathStr);
    
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //   判断数据库是否存在
    BOOL find = [fileManager fileExistsAtPath:pathStr];
    
    
    //存在数据库的情况
    if (find) {
        
        NSLog(@"直接打开");
        
        if (sqlite3_open([pathStr UTF8String], &_database) != SQLITE_OK) {
            
            //进入这里说明打开失败
            
            sqlite3_close(_database);
            
            NSLog(@"打开失败");
            
            return NO;
            
        }
        
        
        [self createNewSQL:_database];
        
        return YES;
        
        
    }
    
    
    //如果发现数据库不存在则利用sqlite3_open创建数据库（上面已经提到过），与上面相同，路径要转换为C字符串
    if(sqlite3_open([pathStr UTF8String], &_database) == SQLITE_OK) {
        
        //创建一个新表
        [self createNewSQL:_database];
        
        //实例
        [self insertRecordIntoTableName:@"savePeopleData" name:@"name" nameValue:@"张三" yangli:@"yangli" yangliValue:@"1991年06月21日 13时" wuxing:@"wuxing" wuxingValue:@"金命 路傍土 幸运数字 10 颜色 红色" geju:@"geju" gejuValue:@"木三局" shuxiang:@"shuxiang" shuxiangValue:@"羊" ageForHomePage:@"ageForHomePage" ageForHomePageValue:@"25 阴男" yearsNow:@"yearsNow" yearsNowValue:@"1992" monthNow:@"monthNow" monthNowValue:@"9" dayNow:@"dayNow" dayNowValue:@"8" hoursNow:@"hoursNow" hoursNowValue:@"17" hours:@"hours" hoursValue:@"10" day:@"day" dayValue:@"12" month:@"month" monthValue:@"8" yinliSTR:@"yinliSTR" yinliSTRValue:@"辛未年五月初十 未时" dizhiSTR:@"dizhiSTR" dizhiSTRValue:@"申" tiangan:@"tiangan" tianganValue:@"壬" yinyang:@"yinyang" yinyangValue:@"阴男" age:@"age" ageValue:@"25"];
        
        return YES;
        
    } else {
        //如果创建并打开数据库失败则关闭数据库
        sqlite3_close(_database);
        NSLog(@"Error: open database file.");
        return NO;
    }
    
}

//创建新的数据库，如果没创建
- (BOOL)createNewSQL:(sqlite3 *)db
{
    
    char *sql = "create table if not exists savePeopleData(ID INTEGER PRIMARY KEY AUTOINCREMENT, peopleID int,name text,yangli text,wuxing text,geju text,shuxiang text,ageForHomePage text,yearsNow int,monthNow int,dayNow int,hoursNow int,hours int,day int,month int,yinliSTR text,dizhiSTR text,tiangan text,yinyang text,age text)";
    
    sqlite3_stmt *statement;
    //sqlite3_prepare_v2 接口把一条SQL语句解析到statement结构里去. 使用该接口访问数据库是当前比较好的的一种方法
    
    NSInteger sqlReturn = sqlite3_prepare_v2(_database, sql, -1, &statement, nil);
    //第一个参数跟前面一样，是个sqlite3 * 类型变量，
    //第二个参数是一个 sql 语句。
    //第三个参数我写的是-1，这个参数含义是前面 sql 语句的长度。如果小于0，sqlite会自动计算它的长度（把sql语句当成以\0结尾的字符串）。
    //第四个参数是sqlite3_stmt 的指针的指针。解析以后的sql语句就放在这个结构里。
    //第五个参数是错误信息提示，一般不用,为nil就可以了。
    //如果这个函数执行成功（返回值是 SQLITE_OK 且 statement 不为NULL ），那么下面就可以开始插入二进制数据。
    
    
    //如果SQL语句解析出错的话程序返回
    if (sqlReturn != SQLITE_OK) {
        
        NSLog(@"解析出错1");
        
        return NO;
    }
    
    //执行sql
    int success = sqlite3_step(statement);
    
    //释放statement
    sqlite3_finalize(statement);
    
    //执行sql语句失败
    if (success != SQLITE_OK) {
        
        
        NSLog(@"解析出错2");
        return NO;
        
    }
    
    
    NSLog(@"解析成功");
    
    return YES;
}



//插入数据方法
- (void)insertRecordIntoTableName:(NSString *)tableName
                             name:(NSString *)name
                        nameValue:(NSString *)nameValue
                           yangli:(NSString *)yangli
                      yangliValue:(NSString *)yangliValue
                           wuxing:(NSString *)wuxing
                      wuxingValue:(NSString *)wuxingValue
                             geju:(NSString *)geju
                        gejuValue:(NSString *)gejuValue
                         shuxiang:(NSString *)shuxiang
                    shuxiangValue:(NSString *)shuxiangValue
                   ageForHomePage:(NSString *)ageForHomePage
              ageForHomePageValue:(NSString *)ageForHomePageValue
                         yearsNow:(NSString *)yearsNow
                    yearsNowValue:(NSString *)yearsNowValue
                         monthNow:(NSString *)monthNow
                    monthNowValue:(NSString *)monthNowValue
                           dayNow:(NSString *)dayNow
                      dayNowValue:(NSString *)dayNowValue
                         hoursNow:(NSString *)hoursNow
                    hoursNowValue:(NSString *)hoursNowValue
                            hours:(NSString *)hours
                       hoursValue:(NSString *)hoursValue
                              day:(NSString *)day
                         dayValue:(NSString *)dayValue
                            month:(NSString *)month
                       monthValue:(NSString *)monthValue
                         yinliSTR:(NSString *)yinliSTR
                    yinliSTRValue:(NSString *)yinliSTRValue
                         dizhiSTR:(NSString *)dizhiSTR
                    dizhiSTRValue:(NSString *)dizhiSTRValue
                          tiangan:(NSString *)tiangan
                     tianganValue:(NSString *)tianganValue
                          yinyang:(NSString *)yinyang
                     yinyangValue:(NSString *)yinyangValue
                              age:(NSString *)age
                         ageValue:(NSString *)ageValue



{
    //方法1：经典方法
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO '%@' ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@') VALUES('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')", tableName, name, yangli, wuxing, geju, shuxiang, ageForHomePage,yearsNow,monthNow,dayNow,hoursNow,hours,day,month,yinliSTR,dizhiSTR,tiangan,yinyang ,age,nameValue,yangliValue,wuxingValue,gejuValue,shuxiangValue,ageForHomePageValue,yearsNowValue,monthNowValue,dayNowValue,hoursNowValue,hoursValue,dayValue,monthValue,yinliSTRValue,dizhiSTRValue,tianganValue,yinyangValue,ageValue];
    char *err;
    
    if (sqlite3_exec(_database, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(_database);
        NSAssert(0, @"插入数据错误！");
    }
    
    // 用完了一定记得关闭，释放内存
    sqlite3_close(_database);
    
}

//查询数据
- (NSArray *)getAllContacts{
    NSString *sql = @"SELECT * FROM savePeopleData";
    sqlite3_stmt *statement;
    
    //存储数据字典
    NSMutableArray *arrForPeople = [NSMutableArray array];
    
    if (sqlite3_prepare_v2(_database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            NSMutableDictionary *dicForP = [NSMutableDictionary dictionary];
            
            for (int i = 2; i < 20; i++) {
                
                char *strFo = (char *)sqlite3_column_text(statement, i);
                NSString *strForPeople = [[NSString alloc] initWithUTF8String:strFo];
                NSString *strForKey = [arrForKey objectAtIndex:i - 2];
                
                //存储方法
                [dicForP setObject:strForPeople forKey:strForKey];
                
            }
            
            //存储字典
            [arrForPeople addObject:dicForP];
            
        }
        sqlite3_finalize(statement);
    }
    
    return arrForPeople;
}

//删除方法
- (BOOL)deleteaNote:(NSString *)nameForP{
    //删除某条数据
    
    NSInteger _idForP = [self forDeletePeople:nameForP];
    
    NSString *deleteString=[NSString stringWithFormat:@"delete from savePeopleData where ID=%ld",_idForP];
    //转成utf-8的c的风格
    const char *deleteSql=[deleteString UTF8String];
    //执行删除语句
    if(sqlite3_exec(_database, deleteSql, NULL, NULL, &errorMsg)==SQLITE_OK){
       
        NSLog(@"删除成功");
    }
    
   // 用完了一定记得关闭，释放内存
    sqlite3_close(_database);
    
    return YES;
}

//根据名字寻找id
- (NSInteger )forDeletePeople:(NSString *)nameForPeople
{
    NSInteger _id = 0;
    NSString *quary = @"SELECT * FROM savePeopleData";//SELECT ROW,FIELD_DATA FROM FIELDS ORDER BY ROW
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(_database, [quary UTF8String], -1, &stmt, nil) == SQLITE_OK) {
    
        while (sqlite3_step(stmt)==SQLITE_ROW) {
        
    
            char *strFo = (char *)sqlite3_column_text(stmt, 2);
            NSString *strForPeople = [[NSString alloc] initWithUTF8String:strFo];
           
            if ([strForPeople isEqualToString:nameForPeople]) {
                
                char *strForID = (char *)sqlite3_column_text(stmt, 0);
                
                NSString *strForIId = [[NSString alloc] initWithUTF8String:strForID];
                
                _id = [strForIId integerValue];
                
            }
    }
    
    sqlite3_finalize(stmt);
}
//用完了一定记得关闭，释放内存
//sqlite3_close(_database);
    
    return _id;
}

@end
