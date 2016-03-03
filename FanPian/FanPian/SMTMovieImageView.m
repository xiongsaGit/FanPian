//
//  SMTMovieImageView.m
//  FanPian
//
//  Created by sa.xiong on 16/1/21.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTMovieImageView.h"

@interface SMTMovieImageView()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, copy) MovieImageViewClickBlock clickBlock;

@end

@implementation SMTMovieImageView

- (id)init {
    if (self = [super init]) {
        [self addSubview:self.iconImageView];
        NSLog(@"add iconImageView");
    }
    return self;
}

- (id)initWithClickBlock:(MovieImageViewClickBlock)clickBlock {
    if (self = [super init]) {
        [self addSubview:self.iconImageView];
        self.clickBlock = clickBlock;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        [self addGestureRecognizer:tapGes];
        
    }
    return self;
}

- (void)hideVideoPlayIcon:(BOOL)hidden {
    [self.iconImageView setHidden:hidden];
}

- (void)handleTapGesture:(UITapGestureRecognizer *)tgr {
    if (self.clickBlock) {
        self.clickBlock();
    }
}

- (void)downLoadImageWithPath:(NSString *)path {
    [self sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",kBaseURL,path]] placeholderImage:nil options:SDWebImageProgressiveDownload];

}


- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.iconImageView.center = self.center;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView)
    {
        UIImage *image = [UIImage imageNamed:@"play"];
        _iconImageView = [[UIImageView alloc] initWithImage:image];
        _iconImageView.size = image.size;
    }
    return _iconImageView;
}

@end
