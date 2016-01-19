//
//  SMTFooter.m
//  FanPian
//
//  Created by sa.xiong on 16/1/19.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTFooter.h"

@interface SMTFooter()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, copy) FooterClickBlock clickBlock;

@end

@implementation SMTFooter

- (id)initWithClickBlock:(FooterClickBlock)clickBlock {
    if (self = [super init]) {
        self.titleLabel = [self factoryForLabelWithTextAlignment:NSTextAlignmentLeft];
        self.detailLabel = [self factoryForLabelWithTextAlignment:NSTextAlignmentRight];

        [self addSubview:self.titleLabel];
        [self addSubview:self.detailLabel];
        [self addSubview:self.arrowImageView];

        self.clickBlock = clickBlock;
        
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        [self addGestureRecognizer:tapGes];
    }
    return self;
}

- (void)handleTapGesture:(UITapGestureRecognizer *)tap {
    if (self.clickBlock) {
        self.clickBlock();
    }
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    self.titleLabel.frame = CGRectMake(10, 0, frame.size.width/2, frame.size.height);
    self.arrowImageView.frame = CGRectMake(CGRectGetWidth(frame)-CGRectGetWidth(self.arrowImageView.frame)-10, (CGRectGetHeight(frame)-CGRectGetHeight(self.arrowImageView.frame))/2, CGRectGetWidth(self.arrowImageView.frame), CGRectGetHeight(self.arrowImageView.frame));
    self.detailLabel.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame)+10, 0,CGRectGetMinX(self.arrowImageView.frame)-CGRectGetMaxX(self.titleLabel.frame)-10-5, frame.size.height);

}


- (void)configureTitleLabel:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)configureDetailLabel:(NSString *)title {
    self.detailLabel.text = title;
}

- (UILabel *)factoryForLabelWithTextAlignment:(NSTextAlignment)align {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = align;
    label.adjustsFontSizeToFitWidth = YES;
    return label;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        UIImage *image = [UIImage imageNamed:@"icon_arrow"];
        _arrowImageView = [[UIImageView alloc] initWithImage:image];
        _arrowImageView.size = image.size;
    }
    return _arrowImageView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
