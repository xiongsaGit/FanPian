//
//  SMTImageLabelView.m
//  FanPian
//
//  Created by sa.xiong on 16/1/18.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTImageLabelView.h"

@interface SMTImageLabelView()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, assign) ImageLabelType type;
@property (nonatomic, copy) ImageLabelViewBlock clickBlock;

@end

@implementation SMTImageLabelView

- (id)initWithFrame:(CGRect)frame type:(ImageLabelType)type block:(ImageLabelViewBlock)block {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.imageView];
        [self addSubview:self.label];
        self.type = type;
        self.clickBlock = block;
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        [self addGestureRecognizer:tapGes];
        
        self.backgroundColor = [UIColor greenColor];
        
    }
    return self;
}


- (void)handleTapGesture:(UITapGestureRecognizer *)tapGes {
    if (self.clickBlock) {
        self.clickBlock();
    }
}

- (void)configureImageName:(NSString *)imageName labelTitle:(NSString *)title {
    UIImage *image = [UIImage imageNamed:imageName];
    self.imageView.image = image;
    self.imageView.size = image.size;
    self.label.text = title;

    [self configureWithType:self.type];
}


- (void)configureWithType:(ImageLabelType)type
{
    if (type == ImageLabelTypeImageLeft) {
        self.imageView.centerY = self.centerY;

        self.label.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame)+10, 0, CGRectGetWidth(self.frame)-CGRectGetMaxX(self.imageView.frame)-10, CGRectGetHeight(self.frame));
    }else {
        self.imageView.centerX = self.centerX;
        self.label.frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame)+10, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-CGRectGetMaxY(self.imageView.frame)-10);
    }
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.adjustsFontSizeToFitWidth = YES;
        _label.font = [UIFont systemFontOfSize:15];
    }
    return _label;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
