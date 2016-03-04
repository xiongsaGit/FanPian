//
//  PlayVideoView.m
//  ShowImagePlayVideo
//
//  Created by sa.xiong on 16/3/2.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "PlayVideoView.h"
#import <AVFoundation/AVFoundation.h>

#define NLSystemVersionGreaterOrEqualThan(version)  ([[[UIDevice currentDevice] systemVersion] floatValue] >= version)
#define IOS9_OR_LATER   NLSystemVersionGreaterOrEqualThan(9.0)

static MPMoviePlayerController *playerCtrl = nil;

@interface PlayVideoView()
@property (nonatomic, strong) AVPlayerItem * playerItem;
@property (nonatomic, strong) AVPlayer *player;
@end


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
    
    NSURL *videoUrl = [NSURL URLWithString:stringUrl];
    
    if (![fileManager fileExistsAtPath:filePath]) {
        __block BOOL result = NO;
        
        dispatch_queue_t queue = dispatch_queue_create("saveVideoQueue", DISPATCH_QUEUE_CONCURRENT);
        dispatch_async(queue, ^{
            
            NSData *data = [NSData dataWithContentsOfURL:videoUrl];
            result = [data writeToFile:filePath atomically:YES];
            if (result) {
                NSLog(@"视频写入成功");
            }else
                NSLog(@"视频写入失败");
        });
        if (result) {
         
            dispatch_barrier_async(queue, ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                
                    [self playVideoWithUrl:[NSURL fileURLWithPath:filePath]];
                });
            
            });
           
        }else {
        // 展示默认图片
            if (self.successBlock) {
                self.successBlock(result);
            }
        }
    }else {
        videoUrl = [NSURL fileURLWithPath:filePath];
      
        [self playVideoWithUrl:videoUrl];
       
    }
}

- (void)playVideoWithUrl:(NSURL *)videoUrl {
   
    if (IOS9_OR_LATER) {
        self.playerItem = [AVPlayerItem playerItemWithURL:videoUrl];
        
        [self playEnd:self.playerItem];
        
        self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
        [self.player play];

    }else {
        [PlayVideoView sharedManager].shouldAutoplay = YES;
        [PlayVideoView sharedManager].view.frame = self.frame;
        [PlayVideoView sharedManager].controlStyle = MPMovieControlStyleNone;
        [self addSubview:[PlayVideoView sharedManager].view];

        [[PlayVideoView sharedManager] setContentURL:videoUrl];
        [[PlayVideoView sharedManager] play];
    }
    if (self.successBlock) {
        self.successBlock(NO);
    }
}

-(void)playEnd:(AVPlayerItem *)playerItem
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:playerItem];
    
}

//添加监视者后，播放完毕执行方法
- (void)moviePlayDidEnd:(NSNotification *)notification {
    NSLog(@"Play end");
    
//    __weak typeof(self) weakSelf = self;
//    
//    //播放完毕之后让其回到 seek 视频滴第一帧
//    [self.player seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
//        
//        //播放完毕之后 执行 这个方法
//        NSLog(@"end played");
//        
//    }];
}


+(Class)layerClass
{
    return [AVPlayerLayer class];
    
}

-(AVPlayer *)player
{
    
    return [(AVPlayerLayer *)[self layer]player];
}

-(void)setPlayer:(AVPlayer *)player
{
    
    [(AVPlayerLayer *)[self layer]setPlayer:player];
    
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
