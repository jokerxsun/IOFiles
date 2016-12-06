//
//  ViewController.m
//  IOFiles
//
//  Created by 孙旭 on 2016/12/6.
//  Copyright © 2016年 北京红黄蓝儿童教育科技有限公司. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 获取沙盒文件路径
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    // 创建目标文件路径
    NSString *resultFilePath = [documentPath stringByAppendingPathComponent:@"resultFiles.txt"];
    
    // 创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 获取沙盒中文件列表
    NSArray *documentFileList = [[NSArray alloc] init];
    
    NSError *error;
    
    documentFileList = [fileManager contentsOfDirectoryAtPath:documentPath error:&error];
    
    // 读取文件中内容，写入一个文件中，归档
    NSString *resultString = [[NSString alloc] init];
    
    for (NSInteger i = 0; i < documentFileList.count; i++ ) {
        
        NSString *orginFilePath = [documentPath stringByAppendingPathComponent:documentFileList[i] ];
        
        NSString *readString = [NSString stringWithContentsOfFile:orginFilePath encoding:NSUTF8StringEncoding error:&error];
        
        resultString = [resultString stringByAppendingFormat:@"\n%@",readString];
    }
    resultString = [resultString substringFromIndex:8];
    
    // 创建目标文件
    [fileManager createFileAtPath:resultFilePath contents:[resultString dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    
    NSLog(@"%@", resultFilePath);
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
