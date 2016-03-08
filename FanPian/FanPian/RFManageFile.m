//
//  RFManageFile.m
//  FanPian
//
//  Created by sa.xiong on 16/3/8.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "RFManageFile.h"

@implementation RFManageFile

static RFManageFile *_sharedInstance = nil;

- (BOOL)isExistWithFileName:(NSString *)fileName {
    NSString *filePath = [self filePathWithFileName:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    return [fileManager fileExistsAtPath:filePath];
}

- (NSString *)filePathWithFileName:(NSString *)fileName {
    NSString *fileFolderPath = [self fileFolderDir];
    NSString *filePath = [fileFolderPath stringByAppendingPathComponent:fileName];

    return filePath;
}

- (BOOL)saveFile:(id)file withFileName:(NSString *)fileName {
    [self deleteFileWithoutFileName:fileName];

    NSString *filePath = [self filePathWithFileName:fileName];
 
    if ([file isKindOfClass:[UIImage class]]) {
        UIImage *image = (UIImage *)file;
        if ([fileName rangeOfString:@".png"].location != NSNotFound) {
            [UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];
        }else {
            [UIImageJPEGRepresentation(image, 1) writeToFile:filePath atomically:YES];
        }
        return YES;
    }else {
        return [file writeToFile:filePath atomically:YES];
    }
}

- (void)deleteFileWithoutFileName:(NSString *)fileName {
    NSString *fileFolderPath = [self fileFolderDir];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:fileFolderPath error:NULL];
    
    NSEnumerator *e = [contents objectEnumerator];
    NSString *filename;
    while ((filename = [e nextObject])) {
        
        if (![fileName isEqualToString:filename]) {
            /*   if ([[filename pathExtension] isEqualToString:@"jpg"])
             只删除jpg格式图片
             */
            [fileManager removeItemAtPath:[fileFolderPath stringByAppendingPathComponent:filename] error:NULL];
        }
    }
}

#pragma mark 文件夹路径

- (NSString *)fileFolderDir {
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *path = [document stringByAppendingPathComponent:@"fileFolder"];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    BOOL isDir = YES;
    
    if(![manager fileExistsAtPath:path isDirectory:&isDir]){
        [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}

+ (RFManageFile*)sharedInstance
{
    if (_sharedInstance != nil) {
        return _sharedInstance;
    }
    
    @synchronized(self) {
        if (_sharedInstance == nil) {
            _sharedInstance = [[self alloc] init];
        }
    }
    
    return _sharedInstance;
}


@end
