//
//  RFManageFile.h
//  FanPian
//
//  Created by sa.xiong on 16/3/8.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RFManageFile : NSObject

+ (RFManageFile *)sharedInstance;

- (BOOL)isExistWithFileName:(NSString *)fileName;

- (NSString *)filePathWithFileName:(NSString *)fileName;

- (BOOL)saveFile:(id)file withFileName:(NSString *)fileName;

- (void)deleteFileWithoutFileName:(NSString *)fileName;

@end
