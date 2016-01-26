//
//  SMTCollectionCell.m
//  FanPian
//
//  Created by sa.xiong on 16/1/22.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTCollectionCell.h"
#import "SMTCollectionListModel.h"
@interface SMTCollectionCell()
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *descLabel;
@end

@implementation SMTCollectionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        self.nameLabel = [self factoryForLabelWithFont:kFontOfSize(17) textColor:kColor_Title];
        self.descLabel = [self factoryForLabelWithFont:kFontOfSize(15) textColor:kColor_Detail];
        
        [self.contentView addSubview:self.coverImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.descLabel];
        
        
    }
    return self;
}

- (void)configureCellData:(SMTCollectionListModel *)listModel {

    self.nameLabel.text = listModel.name;
    self.descLabel.text = listModel.desc;
    
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",kBaseURL,listModel.image]] placeholderImage:nil options:SDWebImageProgressiveDownload];
    [self configureCellFrame];
}

- (void)configureCellFrame {
    
    self.coverImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetWidth(self.frame)*0.6);
    
    CGSize nameSize = [self sizeWithLabel:self.nameLabel boundingSize:CGSizeMake(CGRectGetWidth(self.frame)-2*kEdge, 0)];
    CGSize descSize = [self sizeWithLabel:self.descLabel boundingSize:CGSizeMake(CGRectGetWidth(self.frame)-2*kEdge, 0)];

    self.nameLabel.frame = CGRectMake(kEdge, CGRectGetMaxY(self.coverImageView.frame)+kEdge*1.5, CGRectGetWidth(self.coverImageView.frame)-2*kEdge, nameSize.height);
    self.descLabel.frame = CGRectMake(kEdge, CGRectGetMaxY(self.nameLabel.frame)+kEdge, CGRectGetWidth(self.nameLabel.frame), descSize.height);
}

- (UILabel *)factoryForLabelWithFont:(UIFont *)font textColor:(UIColor *)textColor
{
    UILabel *label = [[UILabel alloc] init];
    label.font = font;
    label.textColor = textColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    return label;
}

- (UIImageView *)coverImageView
{
    if (!_coverImageView)
    {
        _coverImageView = [[UIImageView alloc] init];
    }
    return _coverImageView;
}

@end
