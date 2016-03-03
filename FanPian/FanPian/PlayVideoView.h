//
//  PlayVideoView.h
//  ShowImagePlayVideo
//
//  Created by sa.xiong on 16/3/2.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MediaPlayer;

@interface PlayVideoView : UIView

- (void)startPlayWithPath:(NSString *)videoPath fileIsLocal:(BOOL)isLocal;

+ (MPMoviePlayerController *)sharedManager;

@end
