//
//  RFPlayMovieView.m
//  RFByStages
//
//  Created by sa.xiong on 16/3/7.
//  Copyright © 2016年 renren-fenqi. All rights reserved.
//

#import "RFPlayMovieView.h"
#import <AVFoundation/AVFoundation.h>
#import "RFManageFile.h"

#define SystemVersion       [[[UIDevice currentDevice] systemVersion] floatValue]

#define IOS_VERSION_8_OR_LATER ((SystemVersion >=8.0)? (YES):(NO))

static MPMoviePlayerController *playerCtrl = nil;

@interface RFPlayMovieView()
@property (nonatomic, strong) MPMoviePlayerController *playerCtrl;
@property (nonatomic, strong) AVPlayerItem * playerItem;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, copy) NSString *movieName;

@end


@implementation RFPlayMovieView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        if (IOS_VERSION_8_OR_LATER) {
                       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
        }else {

            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(videoPlayFinishedCallback)
                                                         name:MPMoviePlayerPlaybackDidFinishNotification
                                                       object:nil];
        }
    }
    return self;
}

- (void)startPlayWithPath:(NSString *)videoPath {
    
    [self downloadVideoWithUrlString:videoPath];
}

- (void)downloadVideoWithUrlString:(NSString *)urlString {
    
    //判断是否存在
    NSString *videoName = [[urlString componentsSeparatedByString:@"/"] lastObject];
    NSString *filePath = [[RFManageFile sharedInstance]filePathWithFileName:videoName];
    
    self.movieName = videoName;
    if (![[RFManageFile sharedInstance] isExistWithFileName:videoName]) {
        __block BOOL result = NO;
        
        dispatch_queue_t queue = dispatch_queue_create("saveVideoQueue", DISPATCH_QUEUE_CONCURRENT);
        dispatch_async(queue, ^{
            
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
            result = [[RFManageFile sharedInstance] saveFile:data withFileName:videoName];
            if (result) {
                
                dispatch_barrier_async(queue, ^{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [self playVideoWithPath:filePath];
                    });
                    
                });
            }else {
                // 展示默认图片
                if (self.successBlock) {
                    self.successBlock(videoName,result);
                }
            }
        });
    
    }else {
        
        [self playVideoWithPath:filePath];
        
    }
}

- (void)playVideoWithPath:(NSString *)path {
    
    NSURL *videoUrl = [NSURL fileURLWithPath:path];

    if (IOS_VERSION_8_OR_LATER) {
        self.playerItem = [AVPlayerItem playerItemWithURL:videoUrl];
        
        self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
        [self.player play];
        
    }else {
        self.playerCtrl.view.frame = self.frame;
        [self addSubview:self.playerCtrl.view];
        
        [self.playerCtrl setContentURL:videoUrl];
        [self.playerCtrl play];
    }
    NSString *fileName = [[path componentsSeparatedByString:@"/"] lastObject];
    if (self.successBlock) {
        self.successBlock(fileName,YES);
    }
}

- (void)moviePlayFinished {
    
    [self stopPlay];
    
    if (self.playEndBlock) {
        self.playEndBlock();
    }
}

- (void)stopPlay {
    if (IOS_VERSION_8_OR_LATER) {
        [self.player pause];
    }else {
        [self.playerCtrl stop];
    }
}

- (void)videoPlayFinishedCallback {
    [self moviePlayFinished];
}

// 播放完毕执行方法
- (void)moviePlayDidEnd:(NSNotification *)notification {
    NSLog(@"AVPLAYER");
    [self moviePlayFinished];
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


- (MPMoviePlayerController *)playerCtrl {
    if (!_playerCtrl) {
        _playerCtrl = [[MPMoviePlayerController alloc] init];
        _playerCtrl.shouldAutoplay = YES;
        _playerCtrl.controlStyle = MPMovieControlStyleNone;
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
