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
@property (nonatomic, copy) NSString *commonImageName;
@property (nonatomic, copy) NSString *selectImageName;

@end

@implementation SMTImageLabelView

- (id)initWithFrame:(CGRect)frame type:(ImageLabelType)type {
    if (self = [super initWithFrame:frame]) {
        [self baseSetting];
        self.type = type;

    }
    return self;
}

- (void)baseSetting {
    [self addSubview:self.imageView];
    [self addSubview:self.label];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [self addGestureRecognizer:tapGes];
}

- (id)initWithFrame:(CGRect)frame type:(ImageLabelType)type block:(ImageLabelViewBlock)block {
    if (self = [super initWithFrame:frame]) {
        [self baseSetting];
        self.type = type;
        self.clickBlock = block;
    }
    return self;
}


- (void)handleTapGesture:(UITapGestureRecognizer *)tapGes {
    if (self.clickBlock) {
        self.clickBlock();
    }
}

- (void)configureWitState:(BOOL)isChecked {
    self.imageView.image = isChecked ?[UIImage imageNamed:self.selectImageName]:[UIImage imageNamed:self.commonImageName];
}

- (void)configureImageName:(NSString *)imageName labelTitle:(NSString *)title {
    self.commonImageName = imageName;
    self.selectImageName = [NSString stringWithFormat:@"%@Select",imageName];
    UIImage *image = [UIImage imageNamed:imageName];
    self.imageView.image = image;
    self.imageView.size = image.size;
    self.label.text = title;

    [self configureWithType:self.type];
}


- (void)configureWithType:(ImageLabelType)type
{
    CGFloat SpaceX = 5;

    CGSize titileSize = [self.label.text sizeWithAttributes:@{NSFontAttributeName:self.label.font}];
    
    if (type == ImageLabelTypeImageLeft) {
        self.imageView.centerY = self.centerY;

        CGFloat originX = 0;
        if (CGRectGetWidth(self.imageView.frame)+titileSize.width+SpaceX<CGRectGetWidth(self.frame)) {
            originX = (CGRectGetWidth(self.frame)-CGRectGetWidth(self.imageView.frame)-titileSize.width-SpaceX)/2;
        }
        
        CGRect imageRect = self.imageView.frame;
        imageRect.origin.x = originX;
        self.imageView.frame = imageRect;
        
        CGFloat actualHeight = CGRectGetHeight(self.frame)-titileSize.height>0?titileSize.height:CGRectGetHeight(self.frame);
        
        self.label.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame)+SpaceX, (CGRectGetHeight(self.frame)-actualHeight)/2, titileSize.width, actualHeight);
        

    }else {
       
        CGFloat originY = 0;
        if (CGRectGetHeight(self.imageView.frame)+titileSize.height+SpaceX<CGRectGetHeight(self.frame)) {
            originY = (CGRectGetHeight(self.frame)-CGRectGetHeight(self.imageView.frame)-titileSize.height-SpaceX)/2;
        }
        
        CGRect imageRect = self.imageView.frame;
  
//        self.label.frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame)+SpaceX, CGRectGetWidth(self.frame),titileSize.height);
        self.label.frame = CGRectMake(0,CGRectGetHeight(self.frame)-titileSize.height-SpaceX, CGRectGetWidth(self.frame),titileSize.height);
        imageRect.origin = CGPointMake((CGRectGetWidth(self.frame)-CGRectGetWidth(self.imageView.frame))/2, CGRectGetMinY(self.label.frame)-imageRect.size.height-SpaceX);

        self.imageView.frame = imageRect;

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
        _label.textAlignment = NSTextAlignmentCenter;
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
