//
//  SMTMLMovielinesCell.m
//  FanPian
//
//  Created by sa.xiong on 16/2/24.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTMLMovielinesCell.h"
#import "SMTBarView.h"
#import "SMTMovieImageView.h"

#import "SMTMEListItemModel.h"

@interface SMTMLMovielinesCell()
@property (nonatomic, strong) SMTMovieImageView *mlImageView;
@property (nonatomic, strong) UILabel *subjectLabel;
@property (nonatomic, strong) UILabel *introLabel;
@property (nonatomic, strong) SMTBarView *barView;
@property (nonatomic, strong) UIView *blackView;

@end

@implementation SMTMLMovielinesCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = UIColorFromRGB(0xffffff);
        
        self.subjectLabel = [self factoryForLabel];
        self.introLabel = [self factoryForLabel];
       
        [self.contentView addSubview:self.mlImageView];
        [self.contentView addSubview:self.blackView];
        [self.contentView addSubview:self.self.subjectLabel];
        [self.contentView addSubview:self.self.introLabel];
        [self.contentView addSubview:self.barView];
        [self.contentView bringSubviewToFront:self.type];
        
        self.subjectLabel.textAlignment = NSTextAlignmentRight;
        
    }
    return self;
}

- (void)configureCellForData:(SMTMEListItemModel *)itemModel {
    
    SMTShortMovieListModel *listModel = itemModel.itemdata;
    
    [self.mlImageView downLoadImageWithPath:listModel.image];
    self.subjectLabel.text = [NSString stringWithFormat:@"-- %@",listModel.subject];
    self.introLabel.text = listModel.intro;
   
    [self showTypeTextWithType:itemModel.type];
    
    CGFloat ratio = [listModel.height floatValue]/[listModel.width floatValue];

    [self configureCellItemFrameWithRatio:ratio];
}

- (void)configureCellItemFrameWithRatio:(CGFloat)ratio {

    [self.mlImageView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*ratio)];
    [self.blackView setFrame:self.mlImageView.bounds];

    CGSize boundingSize = CGSizeMake(CGRectGetWidth(self.frame)-2*kEdge, 0);
    CGSize subjectSize = [self sizeWithLabel:self.subjectLabel boundingSize:boundingSize];
    
    CGSize introSize = [self sizeWithLabel:self.introLabel boundingSize:boundingSize];
    
    if (subjectSize.height + introSize.height +2*kEdge <= CGRectGetHeight(self.mlImageView.frame)) {
        CGFloat originY = (CGRectGetHeight(self.mlImageView.frame)-subjectSize.height - introSize.height - 2*kEdge)/2;
        
        self.introLabel.frame = CGRectMake(kEdge, originY, introSize.width, introSize.height);
        self.subjectLabel.frame = CGRectMake(SCREEN_WIDTH-kEdge-subjectSize.width, CGRectGetMaxX(self.introLabel.frame)+2*kEdge, subjectSize.width, subjectSize.height);
        
    }
    [self.barView setFrame:CGRectMake(0, CGRectGetMaxY(self.mlImageView.frame)-30, SCREEN_WIDTH, 30)];
    self.barView.backgroundColor = [UIColor clearColor];
    
    self.cellHeight = CGRectGetMaxY(self.mlImageView.frame);
}

- (SMTMovieImageView *)mlImageView {
    if (!_mlImageView) {
        _mlImageView = [[SMTMovieImageView alloc] init];
        [_mlImageView hideVideoPlayIcon:YES];
    }
    return _mlImageView;
}


- (SMTBarView *)barView {
    if (!_barView) {
        __weak typeof(self)weakSelf = self;
        _barView = [[SMTBarView alloc] initWithFrame:CGRectZero clickBlock:^(NSInteger itemTag) {
            if (weakSelf.itemBlock) {
                weakSelf.itemBlock(weakSelf,itemTag);
            }
        }];
        NSDictionary *leftDict = @{@"imageName":@"good",
                                   @"title":@"赞"};
        NSDictionary *middleDict = @{@"imageName":@"reply",
                                     @"title":@"评论"};
        NSDictionary *rightDict = @{@"imageName":@"more",
                                    @"title":@""};
        
        _barView.items = @[leftDict,middleDict,rightDict];
        [_barView itemLabelTextColor:[UIColor whiteColor]];
    }
    return _barView;
}

- (UIView *)blackView {
    if (!_blackView) {
        _blackView = [[UIView alloc] init];
        _blackView.backgroundColor = UIColorFromRGB(0x444444);
        _blackView.alpha = 0.5;
    }
    return _blackView;
}

- (UILabel *)factoryForLabel {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = UIColorFromRGB(0xffffff);
    label.font = [UIFont systemFontOfSize:15];
    label.adjustsFontSizeToFitWidth = YES;
    label.numberOfLines = 0;
    //    label.contentMode = UIViewContentModeTop;
    return label;
}
@end
