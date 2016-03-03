//
//  SMTMLChannelCell.m
//  FanPian
//
//  Created by sa.xiong on 16/2/24.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTMLChannelCell.h"
#import "SMTMEListItemModel.h"
#import "SMTMovieImageView.h"

@interface SMTMLChannelCell()
@property (nonatomic, strong) SMTMovieImageView *icon;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *desc;

@property (nonatomic, strong) UIView *blackView;
@end

@implementation SMTMLChannelCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = UIColorFromRGB(0xffffff);
        self.name = [self factoryForLabel];
        self.desc = [self factoryForLabel];
        [self.contentView addSubview:self.self.desc];
       
        [self.contentView addSubview:self.icon];
        [self.icon addSubview:self.blackView];
        [self.icon addSubview:self.self.name];

        self.name.textColor = [UIColor whiteColor];
        self.name.font = [UIFont boldSystemFontOfSize:18];
        
        [self.contentView addSubview:self.lookBtn];
        [self.contentView bringSubviewToFront:self.type];
    }
    return self;
}


- (void)configureCellForData:(SMTMEListItemModel *)itemModel {

    [self.icon downLoadImageWithPath:itemModel.itemdata.image];
    
    self.name.text = itemModel.itemdata.name;
    self.desc.text = itemModel.itemdata.desc;
    
    [self showTypeTextWithType:itemModel.type];
    
    // 设置frame
    CGFloat ratio = [itemModel.itemdata.height floatValue]/[itemModel.itemdata.width floatValue];

    [self configureCellItemFrameWithRatio:ratio];
}

- (void)configureCellItemFrameWithRatio:(CGFloat)ratio {
    
    [self.icon setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.6)];
    [self.blackView setFrame:self.icon.bounds];
    [self.name setFrame:CGRectMake(0, CGRectGetHeight(self.icon.frame)-55, SCREEN_WIDTH, 20)];
    
    CGSize boundingSize = CGSizeMake(CGRectGetWidth(self.frame)-2*kEdge, 0);
    CGSize descSize = [self sizeWithLabel:self.desc boundingSize:boundingSize];

    [self.desc setFrame:CGRectMake(kEdge, CGRectGetMaxY(self.icon.frame)+5, SCREEN_WIDTH-2*kEdge, descSize.height)];
    [self.lookBtn setFrame:CGRectMake((SCREEN_WIDTH-100)/2, CGRectGetMaxY(self.desc.frame)+kEdge, 100, 30)];
    
    self.cellHeight = CGRectGetMaxY(self.lookBtn.frame)+kEdge;
    
}


- (SMTMovieImageView *)icon {
    if (!_icon) {
        _icon = [[SMTMovieImageView alloc] init];
        [_icon hideVideoPlayIcon:YES];
    }
    return _icon;
}

- (UILabel *)factoryForLabel {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = UIColorFromRGB(0x808080);
    label.font = kFontOfSize(14);
    label.adjustsFontSizeToFitWidth = YES;
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    //    label.contentMode = UIViewContentModeTop;
    return label;
}

- (UIView *)blackView {
    if (!_blackView) {
        _blackView = [[UIView alloc] init];
        _blackView.backgroundColor = UIColorFromRGB(0x444444);
        _blackView.alpha = 0.4;
    }
    return _blackView;
}
@end
