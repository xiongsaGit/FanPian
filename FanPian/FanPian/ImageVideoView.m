//
//  ImageVideoView.m
//  ShowImagePlayVideo
//
//  Created by sa.xiong on 16/3/2.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "ImageVideoView.h"
#import "PlayVideoView.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AudioToolbox/AudioToolbox.h>

#define kSkipbuttonWidth 6*kEdge
#define kSkipbuttonHeight 3*kEdge




@interface ImageVideoView()<UIScrollViewDelegate>
@property (nonatomic, strong) UIButton *skipButton;// 跳过
@property (nonatomic, strong) UIImageView *defaultImageView;
@property (nonatomic, strong) UIScrollView *imageScrollView;
@property (nonatomic, strong) NSMutableArray *imagesArray;
@property (nonatomic, strong) PlayVideoView *playVideoView;
@property (nonatomic, copy) ImageVideoViewFinishBlock finishBlock;

@end

@implementation ImageVideoView

- (id)initWithFinishBlock:(ImageVideoViewFinishBlock)finishBlock {
    if (self = [super init]) {
        self.finishBlock = finishBlock;
        self.imagesArray = [NSMutableArray array];
        [self addSubview:self.skipButton];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(videoPlayFinishedCallback)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:nil];
        
//        [self saveImage];
    }
    return self;
}

- (void)videoPlayFinishedCallback {
    if (self.finishBlock) {
        self.finishBlock();
    }
}



- (void)deleteFileFromPath:(NSString *)filePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        BOOL deleteResult = [fileManager removeItemAtPath:filePath error:nil];
        if (deleteResult) {
            NSLog(@"删除成功");
        }else
            NSLog(@"删除失败");
    }
}


- (void)loadViewData:(NSDictionary *)dataDict {
    
    if ([dataDict[@"type"] isEqualToString:@"image"]) {
        // 图片
        [self addImageViewToScrollViewFromImageList:dataDict[@"dataList"]];
    }else {
        // 视频
        
        self.playVideoView.frame = self.bounds;
        [PlayVideoView sharedManager].shouldAutoplay = YES;
        [PlayVideoView sharedManager].view.frame = self.playVideoView.frame;
        [PlayVideoView sharedManager].controlStyle = MPMovieControlStyleNone;
        [self.playVideoView addSubview:[PlayVideoView sharedManager].view];
        [self addSubview:self.playVideoView];

        [self.playVideoView startPlayWithPath:dataDict[@"dataList"][0] fileIsLocal:NO];
    }
}

- (void)addImageViewToScrollViewFromImageList:(NSArray *)imageList {

    if (imageList==nil||imageList.count <= 0) {
        // 展示默认图片
        [self addSubview:self.defaultImageView];
        [self.defaultImageView setFrame:self.bounds];

    }else {
        
        [self addSubview:self.imageScrollView];
        [self.imageScrollView setFrame:self.bounds];
        
        self.imageScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*imageList.count, SCREEN_HEIGHT);
        for (int i = 0; i < imageList.count; i ++) {
            // 本地图
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            
            
            [self downloadToImageView:imageView withStringUrl:imageList[i] successBlock:^(UIImage *image) {
                imageView.image = image;

            }];
            
            [self.imageScrollView addSubview:imageView];
        }
    
    }
    
    [self bringSubviewToFront:self.skipButton];
}



- (void)downloadToImageView:(UIImageView *)imageView withStringUrl:(NSString *)stringUrl
                           successBlock:(void(^)(UIImage *image))successBlock{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *imageName = [[stringUrl componentsSeparatedByString:@"/"] lastObject];
    NSString *filePath = [[self fileFolderDir] stringByAppendingPathComponent:imageName];
    
    if (![fileManager fileExistsAtPath:filePath]) {
        NSURL *downloadURL = [NSURL URLWithString:stringUrl];
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:downloadURL options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            NULL;
        } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            if (image && finished) {
            
                if ([filePath containsString:@".png"]) {
                    [UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];
                }else
                    [UIImageJPEGRepresentation(image, 1) writeToFile:filePath atomically:YES];
                
                if (successBlock) {
                    successBlock([UIImage imageWithContentsOfFile:filePath]);
                }
            } else if (error) {
                NSLog(@"download fail request=%@, errorCode=%ld", [downloadURL absoluteString], (long)error.code);
            }
        }];
    }else {//图片存在,读取
        imageView.image = [UIImage imageWithContentsOfFile:filePath];
       
    }
    
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


- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    [self.skipButton setFrame:CGRectMake(CGRectGetWidth(frame)-kEdge-kSkipbuttonWidth, 3*kEdge, kSkipbuttonWidth, kSkipbuttonHeight)];
    
    [self.skipButton setTitle:@"跳过" forState:UIControlStateNormal];
    
}


/*
    数据请求返回
 */

- (UIButton *)skipButton {
    if (!_skipButton) {
        _skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _skipButton.layer.borderWidth = 2;
        _skipButton.layer.cornerRadius = 4;
        _skipButton.layer.borderColor = [[UIColor redColor]CGColor];//[UIColorFromRGB(0xffffff) CGColor];
        [_skipButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
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

- (PlayVideoView *)playVideoView {
    if (!_playVideoView) {
        _playVideoView = [[PlayVideoView alloc] init];
    }
    return _playVideoView;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
