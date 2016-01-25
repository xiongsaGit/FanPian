//
//  ShowLabelOnImageView.m
//  LabelOnImageView
//
//  Created by sa.xiong on 16/1/25.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "ShowLabelOnImageView.h"
#import "UIView+Size.h"
#define WHITE_SPACE 20

@interface ShowLabelOnImageView()
@property (nonatomic, strong) UILabel *introlLabel;
@property (nonatomic, strong) UILabel *subjectLabel;
@end

@implementation ShowLabelOnImageView


- (id)init {
    if (self = [super init]) {
        
        self.introlLabel = [self factoryForLabelWithFontSize:18 textAlignment:NSTextAlignmentCenter];
        self.subjectLabel = [self factoryForLabelWithFontSize:20 textAlignment:NSTextAlignmentRight];
        [self addSubview:self.introlLabel];
        [self addSubview:self.subjectLabel];
    }
    return self;
}

- (void)showImageWithImagePath:(NSString *)imagePath {
    self.image = [UIImage imageNamed:imagePath];
    self.frame = CGRectMake(0, 0, self.image.size.width, self.image.size.height);
}

- (void)showTextWithIntro:(NSString *)intro subject:(NSString *)subject {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:intro];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [intro length])];
    self.introlLabel.attributedText = attributedString;
    
    self.subjectLabel.text = [NSString stringWithFormat:@"-- %@",subject];
    
    [self adjustLabelSize];
}

- (void)adjustLabelSize {
    
    CGSize boundingSize = CGSizeMake(CGRectGetWidth(self.frame)-4*WHITE_SPACE, 0);
    
    CGSize introSize = [self sizeWithLabel:self.introlLabel boundingSize:boundingSize];
    CGSize subjectSize = [self sizeWithLabel:self.subjectLabel boundingSize:boundingSize];

    
    CGFloat minusHeight = CGRectGetHeight(self.frame)-2*WHITE_SPACE-subjectSize.height;
    CGFloat introHeight = introSize.height <= minusHeight?introSize.height:minusHeight;
    
    self.introlLabel.frame = CGRectMake(2*WHITE_SPACE, 0, boundingSize.width, introHeight);
    self.subjectLabel.frame = CGRectMake(2*WHITE_SPACE, CGRectGetMaxY(self.introlLabel.frame)+WHITE_SPACE/2, boundingSize.width, subjectSize.height);
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
