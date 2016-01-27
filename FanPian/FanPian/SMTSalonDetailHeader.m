//
//  SMTSalonDetailHeader.m
//  FanPian
//
//  Created by sa.xiong on 16/1/27.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTSalonDetailHeader.h"
#import "SMTNavTitleView.h"
#import "SMTSalonDetailModel.h"

@interface SMTSalonDetailHeader()
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UIView *threadnumBg;
@property (nonatomic, strong) UILabel *threadnum;// 参与
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UIImageView *image;// 头像
@property (nonatomic, strong) UILabel *founderusername_createtime;
@property (nonatomic, strong) UILabel *desc;

@property (nonatomic, strong) SMTNavTitleView *segmentView;
@end

@implementation SMTSalonDetailHeader

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureUI];
    }
    return self;
}

- (void)configureData:(SMTSalonDetailModel *)model {
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",kBaseURL,model.icon]] placeholderImage:nil options:SDWebImageProgressiveDownload];
    self.name.text = model.name;

    self.threadnum.text = [NSString stringWithFormat:@"%@人参与",model.threadnum];
   
    SMTSalonDetailListModel *listModel = model.list[0];
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",kBaseURL,listModel.image]] placeholderImage:nil options:SDWebImageProgressiveDownload];
    self.founderusername_createtime.text = [NSString stringWithFormat:@"%@ %@",model.founderusername,model.createtime];

    self.desc.text = model.desc;

    [self configureFrame];
}

- (void)configureFrame {

    [self.icon setFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 0.8*CGRectGetWidth(self.frame))];
    
    CGSize boundingSize = CGSizeMake(CGRectGetWidth(self.frame)-2*kEdge, 0);
    
    CGSize nameSize = [self sizeWithLabel:self.name boundingSize:boundingSize];
    CGSize threadnumSize = [self sizeWithLabel:self.threadnum boundingSize:boundingSize];
    CGFloat originY = (CGRectGetHeight(self.icon.frame)-nameSize.height-40-kEdge)/2;
    [self.name setFrame:CGRectMake(kEdge, originY, boundingSize.width, nameSize.height)];
    
    [self.threadnumBg setFrame:CGRectMake((CGRectGetWidth(self.frame)-threadnumSize.width-kEdge)/2, CGRectGetMaxY(self.name.frame)+kEdge, threadnumSize.width+kEdge, threadnumSize.height+kEdge)];
    [self.threadnum setFrame:CGRectMake(kEdge/2, kEdge/2, threadnumSize.width, threadnumSize.height)];

    [self.image setFrame:CGRectMake(kEdge, 0.5*kEdge+CGRectGetMaxY(self.icon.frame), 30, 30)];
    self.image.layer.cornerRadius = 15;
    [self.founderusername_createtime setFrame:CGRectMake(CGRectGetMaxX(self.image.frame), CGRectGetMinY(self.image.frame),CGRectGetWidth(self.frame)-CGRectGetMaxX(self.image.frame)-kEdge , 30)];
    
    CGSize descSize = [self sizeWithLabel:self.desc boundingSize:boundingSize];
    [self.desc setFrame:CGRectMake(kEdge, CGRectGetMaxY(self.image.frame), CGRectGetWidth(self.frame)-2*kEdge, descSize.height)];
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.desc.frame)+kEdge, CGRectGetWidth(self.frame), 1)];
    line.backgroundColor = UIColorFromRGB(0xdddddd);
    [self addSubview:line];
    
    [self.segmentView setFrame:CGRectMake(0, CGRectGetMaxY(self.desc.frame)+kEdge, CGRectGetWidth(self.frame), 40)];
    CGFloat height = CGRectGetMaxY(self.segmentView.frame);
    
    if (self.headerDelegate &&[self.headerDelegate respondsToSelector:@selector(refreshHeightOfHeader:)]) {
        [self.headerDelegate refreshHeightOfHeader:height];
    }
}



- (void)configureUI {
    self.name = [self factoryForLabelWithTextColor:UIColorFromRGB(0xffffff) fontSize:15];
    self.founderusername_createtime = [self factoryForLabelWithTextColor:UIColorFromRGB(0x444444) fontSize:14];
    self.desc = [self factoryForLabelWithTextColor:UIColorFromRGB(0x444444) fontSize:14];
    self.icon = [self factoryForImageView];
    self.image = [self factoryForImageView];
    self.threadnumBg = [[UIView alloc] init];
    self.threadnum = [self factoryForLabelWithTextColor:UIColorFromRGB(0x444444) fontSize:13];
    [self addSubview:self.icon];
    [self.icon addSubview:self.name];
    [self.icon addSubview:self.threadnumBg];
    [self.threadnumBg addSubview:self.threadnum];
    
    [self addSubview:self.image];
    [self addSubview:self.founderusername_createtime];
    [self addSubview:self.desc];
    [self addSubview:self.segmentView];
}


- (UILabel *)factoryForLabelWithTextColor:(UIColor *)textColor fontSize:(CGFloat)fontSize {
    UILabel *label = [[UILabel alloc]init];
    label.font = kFontOfSize(fontSize);
    label.textColor = textColor;
    label.numberOfLines = 0;
    return label;
}

- (SMTNavTitleView *)segmentView {
    if (!_segmentView) {
        _segmentView = [[SMTNavTitleView alloc] initWithFrame:CGRectZero items:@[@"最新",@"热门"] clickBlock:^(NSInteger itemTag) {
            NSLog(@"log 最新 热门");
        }];
    }
    return _segmentView;
}

- (UIImageView *)factoryForImageView {
    UIImageView *imageView = [[UIImageView alloc] init];
    return imageView;
}

@end
