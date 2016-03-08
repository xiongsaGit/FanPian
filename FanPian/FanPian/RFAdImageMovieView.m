//
//  RFAdImageMovieView.m
//  RFByStages
//
//  Created by sa.xiong on 16/3/7.
//  Copyright © 2016年 renren-fenqi. All rights reserved.
//

#import "RFAdImageMovieView.h"
#import "RFPlayMovieView.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AudioToolbox/AudioToolbox.h>
#import "SDWebImageManager.h"
#import "RFManageFile.h"

#define kEdge 10
#define kSkipbuttonWidth 6*kEdge
#define kSkipbuttonHeight 3*kEdge

@interface RFAdImageMovieView()<UIScrollViewDelegate>
@property (nonatomic, strong) UIButton *skipButton;// 跳过
@property (nonatomic, strong) UIImageView *defaultImageView;
@property (nonatomic, strong) UIScrollView *imageScrollView;
@property (nonatomic, strong) NSMutableArray *imagesArray;
@property (nonatomic, strong) RFPlayMovieView *playMovieView;
@property (nonatomic, copy) ImageVideoViewSkipBlock skipBlock;

@property (nonatomic, strong) NSTimer *timer;
@end

@implementation RFAdImageMovieView

- (id)initWithSkipBlock:(ImageVideoViewSkipBlock)skipBlock {
    if (self = [super init]) {

        self.skipBlock = skipBlock;
        self.imagesArray = [NSMutableArray array];
        [self addSubview:self.skipButton];
        
        
        self.timeDuration = 5;// 默认是5秒
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshSkipButtonTitle) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        [self.timer pauseTimer];
        
    }
    return self;
}

#pragma mark - 加载数据
// 根据数据类型判断是图片还是视频
- (void)loadViewData:(NSDictionary *)dataDict {
    
    if ([dataDict[@"type"] isEqualToString:@"image"]) {
        // 图片
        [self addImageViewToScrollViewFromImageList:dataDict[@"dataList"]];
    }else {
        // 视频
  
        self.playMovieView.frame = self.bounds;
        
        [self addSubview:self.playMovieView];
        [self bringSubviewToFront:self.skipButton];
        [self.playMovieView startPlayWithPath:dataDict[@"dataList"][0]];
    }
}

- (void)addImageViewToScrollViewFromImageList:(NSArray *)imageList {
    
    if (imageList==nil||imageList.count <= 0) {
        // 展示默认图片
        [self loadDefaultImage];
    }else {
        
        [self addSubview:self.imageScrollView];
        [self.imageScrollView setFrame:self.bounds];
        
        self.imageScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*imageList.count, SCREEN_HEIGHT);
        for (int i = 0; i < imageList.count; i ++) {
            // 本地图
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            
            
            [self downloadToImageView:imageView withStringUrl:imageList[i] successBlock:^(UIImage *image) {
                imageView.image = image;
                // 成功
                [self showSkipButtonAndTimer];
            }];
            
            [self.imageScrollView addSubview:imageView];
        }
    }
    [self bringSubviewToFront:self.skipButton];
}

#pragma mark 下载、加载图片
- (void)downloadToImageView:(UIImageView *)imageView withStringUrl:(NSString *)stringUrl
               successBlock:(void(^)(UIImage *image))successBlock{
    
    NSString *imageName = [[stringUrl componentsSeparatedByString:@"/"] lastObject];
    NSString *filePath = [[RFManageFile sharedInstance] filePathWithFileName:imageName];
    
    if (![[RFManageFile sharedInstance] isExistWithFileName:imageName]) {

        NSURL *downloadURL = [NSURL URLWithString:stringUrl];
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:downloadURL options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            NULL;
        } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            if (image && finished) {
                
                [[RFManageFile sharedInstance] saveFile:image withFileName:imageName];

                if (successBlock) {
                    successBlock([UIImage imageWithContentsOfFile:filePath]);
                }
            } else if (error) {
                NSLog(@"download fail request=%@, errorCode=%ld", [downloadURL absoluteString], (long)error.code);
                
            }else {
                [self loadDefaultImage];
                
            }
        }];
    }else {//图片存在,读取
        imageView.image = [UIImage imageWithContentsOfFile:filePath];
        [self showSkipButtonAndTimer];
    }
    
}

- (void)loadDefaultImage {
    if (!_defaultImageView) {
        [self addSubview:self.defaultImageView];
        [self.defaultImageView setFrame:self.bounds];
    }
    [self showSkipButtonAndTimer];
    
}


#pragma mark - 事件处理等

- (void)showSkipButtonAndTimer {
    [self.timer resumeTimer];
    self.skipButton.hidden = NO;
    
}

- (void)refreshSkipButtonTitle {
    
    if (self.timeDuration > 0) {
        [self.skipButton setTitle:[NSString stringWithFormat:@"%ld 跳过",self.timeDuration] forState:UIControlStateNormal];
    }else {
        [self.timer invalidate];
        [self.skipButton setTitle:@"跳过" forState:UIControlStateNormal];
        [self skipDirectly:YES];
    }
    self.timeDuration--;
    
}

#pragma mark - 直接跳过
/*
 directly:YES 直接跳过（视频播放时是未播放完毕状态）
        :NO  （视频播放完毕状态）
 */
- (void)skipDirectly:(BOOL)directly {
    if ([self.timer isValid]) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    BOOL isPlayMovieView = NO;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[RFPlayMovieView class]]) {
            isPlayMovieView = YES;
            break;
        }
    }
    if (isPlayMovieView&&directly) {
        
        [self.playMovieView stopPlay];
    }
    
    if (self.skipBlock) {
        self.skipBlock();
    }
}

#pragma mark - 跳过按钮事件
- (void)handleSkipButtonClicked:(UIButton *)button {
    [self skipDirectly:YES];
}

#pragma mark - base setting
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    [self.skipButton setFrame:CGRectMake(CGRectGetWidth(frame)-kEdge-kSkipbuttonWidth, 3*kEdge, kSkipbuttonWidth, kSkipbuttonHeight)];
    [self.skipButton setTitle:@"跳过" forState:UIControlStateNormal];
}

#pragma mark - getter
- (UIButton *)skipButton {
    if (!_skipButton) {
        _skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _skipButton.layer.borderWidth = 2;
        _skipButton.layer.cornerRadius = 4;
        _skipButton.layer.borderColor = [[UIColor redColor]CGColor];//[UIColorFromRGB(0xffffff) CGColor];
        [_skipButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_skipButton addTarget:self action:@selector(handleSkipButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _skipButton.backgroundColor = [UIColor greenColor];
        _skipButton.hidden = YES;
    }
    return _skipButton;
}

- (UIScrollView *)imageScrollView {
    if (!_imageScrollView) {
        _imageScrollView = [[UIScrollView alloc] init];
        _imageScrollView.delegate = self;
        _imageScrollView.pagingEnabled = YES;
    }
    return _imageScrollView;
}

- (UIImageView *)defaultImageView {
    if (!_defaultImageView) {
        _defaultImageView = [[UIImageView alloc] init];
        _defaultImageView.image = [UIImage imageNamed:@"default_image"];
    }
    return _defaultImageView;
}

- (RFPlayMovieView *)playMovieView {
    if (!_playMovieView) {
        _playMovieView = [[RFPlayMovieView alloc] init];
        __weak typeof(self)weakSelf = self;
        _playMovieView.successBlock = ^(NSString *downloadFileName,BOOL successFlag){
            if (!successFlag) {
                [weakSelf loadDefaultImage];
            }else {
                [weakSelf showSkipButtonAndTimer];
            }
        };
        _playMovieView.playEndBlock = ^(){
            [weakSelf skipDirectly:NO];
        };
    }
    return _playMovieView;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [self.timer invalidate];
    self.timer = nil;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end


@implementation NSTimer(HandleEvent)

-(void)resumeTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate distantPast]];
}

-(void)pauseTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate distantFuture]];
}

@end