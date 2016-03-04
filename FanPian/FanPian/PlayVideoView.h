//
//  PlayVideoView.h
//  ShowImagePlayVideo
//
//  Created by sa.xiong on 16/3/2.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MediaPlayer;

typedef void(^VideoDownloadSuccessBlock)(BOOL successFlag);

@interface PlayVideoView : UIView
@property (nonatomic, copy) VideoDownloadSuccessBlock successBlock;

- (void)startPlayWithPath:(NSString *)videoPath fileIsLocal:(BOOL)isLocal;

+ (MPMoviePlayerController *)sharedManager;

@end
