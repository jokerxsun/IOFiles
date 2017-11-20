//
//  ViewController.m
//  IOFiles
//
//  Created by 孙旭 on 2016/12/6.
//  Copyright © 2016年 北京红黄蓝儿童教育科技有限公司. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSMutableArray *allFiles;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 获取沙盒路径
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    // 创建目标文件路径
    NSString *resultFilePath = [documentPath stringByAppendingPathComponent:@"resultFiles.txt"];
    
    // 创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *error;
    
    // 目录下所有文件
    NSArray *documentFileList = [self p_allFilesAtPath:documentPath];
    
    if (documentFileList.count == 0) {
        return;
    }
    
    // 读取内容
    NSString *resultString = nil;
    
    for (NSInteger i = 0; i < documentFileList.count; i++) {
        
        NSString *orginFilePath = documentFileList[i];
        
        NSString *readString = [NSString stringWithContentsOfFile:orginFilePath encoding:NSUTF8StringEncoding error:&error];
        
        resultString = [resultString stringByAppendingFormat:@"\n%@",readString];
    }
    // 根据文件格式特定要求进行截取
    resultString = [resultString substringFromIndex:8];
    
    // 创建目标文件
    [fileManager createFileAtPath:resultFilePath contents:[resultString dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    
    NSLog(@"目标文件路径：\n%@", [documentPath stringByAppendingPathComponent:resultFilePath]);
}

- (NSArray *)p_allFilesAtPath:(NSString *)documentPath
{
    NSFileManager *fm = [NSFileManager defaultManager];
    
    // 是否是文件夹
    BOOL isDir = NO;
    BOOL isExist = [fm fileExistsAtPath:documentPath isDirectory:&isDir];
    if (!isExist) return @[];
    if (isDir) {
        NSArray *subFiles = [fm contentsOfDirectoryAtPath:documentPath error:nil];
        for (NSString *subPath in subFiles) {
            /// 递归获取文件夹下面的文件， 直到找到所有的文件
            [self p_allFilesAtPath:[documentPath stringByAppendingPathComponent:subPath]];
        }
    } else {
        [_allFiles addObject:documentPath];
    }
    
    return _allFiles;
}

@end
