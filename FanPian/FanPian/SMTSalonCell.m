//
//  SMTSalonCell.m
//  FanPian
//
//  Created by sa.xiong on 16/1/26.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTSalonCell.h"
#import "SMTSalonListModel.h"

@interface SMTSalonCell()
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *threadnum;// 评论数
@end

@implementation SMTSalonCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.icon];
        self.name = [self factoryForLabelWithTextColor:UIColorFromRGB(0x000000) fontSize:15];
        self.threadnum = [self factoryForLabelWithTextColor:UIColorFromRGB(0x7e7e7e) fontSize:13];
        [self.contentView addSubview:self.self.name];
        [self.contentView addSubview:self.self.threadnum];
    }
    return self;
}

- (void)configureData:(SMTSalonListModel *)listModel {
    [self.icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",kBaseURL,listModel.icon]] placeholderImage:nil options:SDWebImageProgressiveDownload];
    self.name.text = listModel.name;
    self.threadnum.text = [NSString stringWithFormat:@"已有%@人参与",listModel.threadnum];
    [self configureFrameWithRatio:[listModel.width floatValue]/[listModel.height floatValue]];
}

- (void)configureFrameWithRatio:(CGFloat)ratio {
    
    // 还是根据数据吧
    CGFloat iconHeight = CGRectGetHeight(self.frame)-2*kEdge;
    
    [self.icon setFrame:CGRectMake(kEdge, kEdge, iconHeight*ratio, iconHeight)];
    
    CGFloat labelHeight = (CGRectGetHeight(self.frame)-4*kEdge)/2;
    [self.name setFrame:CGRectMake(CGRectGetMaxX(self.icon.frame)+kEdge, 2*kEdge, CGRectGetWidth(self.frame)-CGRectGetMaxX(self.icon.frame)-2*kEdge, labelHeight)];
    [self.threadnum setFrame:CGRectMake(CGRectGetMinX(self.name.frame), CGRectGetMaxY(self.name.frame)+kEdge, CGRectGetWidth(self.name.frame), labelHeight)];
    
}

- (UIImageView *)icon
{
    if (!_icon)
    {
        _icon = [[UIImageView alloc] init];
    }
    return _icon;
}

- (UILabel *)factoryForLabelWithTextColor:(UIColor *)textColor fontSize:(CGFloat)fontSize {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = textColor;
    label.font = kFontOfSize(fontSize);
    return label;
}

@end
