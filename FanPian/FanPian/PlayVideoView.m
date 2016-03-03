//
//  PlayVideoView.m
//  ShowImagePlayVideo
//
//  Created by sa.xiong on 16/3/2.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "PlayVideoView.h"

static MPMoviePlayerController *playerCtrl = nil;

@implementation PlayVideoView

+ (MPMoviePlayerController *)sharedManager {
    @synchronized(playerCtrl) {
        if (!playerCtrl) {
            playerCtrl = [[MPMoviePlayerController alloc] init];
        }
    }
    return playerCtrl;
}

- (void)startPlayWithPath:(NSString *)videoPath fileIsLocal:(BOOL)isLocal {
    
    [self downloadVideoWithStringUrl:videoPath];

    
}

- (void)downloadVideoWithStringUrl:(NSString *)stringUrl {

    //判断是否存在
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *videoName = [[stringUrl componentsSeparatedByString:@"/"] lastObject];
    NSString *filePath = [[self fileFolderDir] stringByAppendingPathComponent:videoName];
    NSLog(@"视频开始");
    
    NSURL *videoUrl = [NSURL URLWithString:stringUrl];
  
    
    if (![fileManager fileExistsAtPath:filePath]) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSData *data = [NSData dataWithContentsOfURL:videoUrl];
            BOOL result = [data writeToFile:filePath atomically:YES];
            if (result) {
                NSLog(@"视频写入成功");
            }else
                NSLog(@"视频写入失败");
        });
      
    }else {
        videoUrl = [NSURL fileURLWithPath:filePath];
    }
    [[PlayVideoView sharedManager] setContentURL:videoUrl];
    [[PlayVideoView sharedManager] play];
    
}



- (NSString *)fileFolderDir{
    
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *path = [document stringByAppendingPathComponent:@"fileFolder"];
    
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    BOOL isDir = YES;
    
    if(![manager fileExistsAtPath:path isDirectory:&isDir]){
        [manager createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:nil];
        
    }
    return path;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
