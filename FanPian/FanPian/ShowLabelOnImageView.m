//
//  ShowLabelOnImageView.m
//  LabelOnImageView
//
//  Created by sa.xiong on 16/1/25.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "ShowLabelOnImageView.h"

#define WHITE_SPACE 10

@interface ShowLabelOnImageView()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UILabel *introlLabel;
@property (nonatomic, strong) UILabel *subjectLabel;
@property (nonatomic, copy) LabelOnImageViewClickBlock clickBlock;

@end

@implementation ShowLabelOnImageView


- (id)initWithClickBlock:(LabelOnImageViewClickBlock)clickBlock {
    if (self = [super init]) {
        self.userInteractionEnabled = YES;
        self.clickBlock = clickBlock;
        self.introlLabel = [self factoryForLabelWithFontSize:14 textAlignment:NSTextAlignmentCenter];
        self.subjectLabel = [self factoryForLabelWithFontSize:18 textAlignment:NSTextAlignmentRight];
        [self addSubview:self.introlLabel];
        [self addSubview:self.subjectLabel];
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        [self addGestureRecognizer:tapGes];
    }
    return self;
}

- (void)handleTapGesture:(UITapGestureRecognizer *)tgr {
    if (self.clickBlock) {
        self.clickBlock(self);
    }
}

- (void)showImageWithImagePath:(NSString *)imagePath {
    
    [self sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",kBaseURL,imagePath]] placeholderImage:nil options:SDWebImageProgressiveDownload];
    
}

- (void)showTextWithIntro:(NSString *)intro subject:(NSString *)subject {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:intro];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    [paragraphStyle setLineSpacing:5];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [intro length])];
    self.introlLabel.attributedText = attributedString;
    
    if (subject && ![subject isEqualToString:@""]) {
        self.subjectLabel.text = [NSString stringWithFormat:@"-- %@",subject];
    }
    
    [self adjustLabelSize];
}

- (void)adjustLabelSize {
    
    // 先计算 计算完再调整
    CGSize boundingSize = CGSizeMake(CGRectGetWidth(self.frame)-2*WHITE_SPACE, 0);
    
    CGSize introSize = [self sizeWithLabel:self.introlLabel boundingSize:boundingSize];
    CGSize subjectSize = [self sizeWithLabel:self.subjectLabel boundingSize:boundingSize];
    
    if (introSize.height+subjectSize.height+WHITE_SPACE*1.5>CGRectGetHeight(self.frame)) {
        self.subjectLabel.frame = CGRectMake(WHITE_SPACE, CGRectGetHeight(self.frame)-WHITE_SPACE/2-WHITE_SPACE-subjectSize.height, boundingSize.width, subjectSize.height);
        
        CGFloat minusHeight = subjectSize.height>0?CGRectGetMinY(self.subjectLabel.frame):CGRectGetMinY(self.subjectLabel.frame)+WHITE_SPACE/2;
        CGFloat introHeight = introSize.height <= minusHeight?introSize.height:minusHeight;
        
        self.introlLabel.frame = CGRectMake(WHITE_SPACE, (minusHeight-introHeight)/2, boundingSize.width, introHeight);
    }else {
        CGFloat fromY = (CGRectGetHeight(self.frame)-(introSize.height+subjectSize.height+WHITE_SPACE*1.5))/2;
        self.introlLabel.frame = CGRectMake(WHITE_SPACE, fromY, boundingSize.width, introSize.height);
        self.subjectLabel.frame = CGRectMake(WHITE_SPACE, CGRectGetMaxY(self.introlLabel.frame)+0.5*WHITE_SPACE, boundingSize.width, subjectSize.height);
    }
}

- (UILabel *)factoryForLabelWithFontSize:(CGFloat)fontSize textAlignment:(NSTextAlignment)align
{
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = align;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    
    return label;
}

@end
