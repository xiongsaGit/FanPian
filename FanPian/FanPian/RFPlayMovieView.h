//
//  RFPlayMovieView.h
//  RFByStages
//
//  Created by sa.xiong on 16/3/7.
//  Copyright © 2016年 renren-fenqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@import MediaPlayer;

typedef void(^VideoDownloadSuccessBlock)(NSString *downloadFileName,BOOL successFlag);
typedef void(^VideoPlayEndBlock)();

@interface RFPlayMovieView : UIView
@property (nonatomic, copy) VideoDownloadSuccessBlock successBlock;
@property (nonatomic, copy) VideoPlayEndBlock playEndBlock;

- (void)startPlayWithPath:(NSString *)videoPath;

- (void)stopPlay;
@end
