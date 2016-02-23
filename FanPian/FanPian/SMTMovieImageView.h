//
//  SMTMovieImageView.h
//  FanPian
//
//  Created by sa.xiong on 16/1/21.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MovieImageViewClickBlock)();

@interface SMTMovieImageView : UIImageView

// 要有点击事件，需调用此方法
- (id)initWithClickBlock:(MovieImageViewClickBlock)clickBlock;

- (void)downLoadImageWithPath:(NSString *)path;

- (void)hideVideoPlayIcon:(BOOL)hidden;
@end
