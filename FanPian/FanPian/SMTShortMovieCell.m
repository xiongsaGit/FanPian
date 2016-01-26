//
//  SMTShortMovieCell.m
//  FanPian
//
//  Created by sa.xiong on 16/1/21.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTShortMovieCell.h"
#import "SMTShortMovieListModel.h"
#import "SMTMovieImageView.h"
#import "SMTBarView.h"

@interface SMTShortMovieCell()
@property (nonatomic, strong) SMTMovieImageView *coverImageView;
@property (nonatomic, strong) UILabel *subjectLabel;
@property (nonatomic, strong) UILabel *introLabel;
@property (nonatomic, strong) SMTBarView *barView;
@property (nonatomic, copy) NSString *videoUrl;
@end

@implementation SMTShortMovieCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.subjectLabel = [self factoryForLabel];
        self.introLabel = [self factoryForLabel];
        [self.contentView addSubview:self.self.subjectLabel];
        [self.contentView addSubview:self.self.introLabel];
        [self.contentView addSubview:self.coverImageView];
        [self.contentView addSubview:self.barView];
        
    }
    return self;
}

- (void)configureBarViewAtItemTag:(NSInteger)itemTag state:(BOOL)isChecked;
{
    [self.barView configureEventAtItemTag:itemTag state:isChecked];
}

- (void)configureCellData:(SMTShortMovieListModel *)listModel {
    self.subjectLabel.text = listModel.subject;
    self.introLabel.text = listModel.intro;
    [self.coverImageView downLoadImageWithPath:listModel.image];
    self.videoUrl = listModel.videlurl;
    
    NSDictionary *leftDict = @{@"imageName":@"good",
                               @"title":@"赞"};
    NSDictionary *middleDict = @{@"imageName":@"reply",
                               @"title":@"评论"};
    NSDictionary *rightDict = @{@"imageName":@"more",
                                @"title":@""};
    
    self.barView.items = @[leftDict,middleDict,rightDict];
    
    CGFloat ratio = [listModel.height floatValue]/[listModel.width floatValue];
    [self configureCellFrameWithRatio:ratio];
}

- (void)configureCellFrameWithRatio:(CGFloat)ratio {
    self.coverImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetWidth(self.frame)*ratio);
    
    CGSize boundingSize = CGSizeMake(CGRectGetWidth(self.frame)-2*kEdge, 0);
    
    CGSize subjectSize = [self sizeWithLabel:self.subjectLabel boundingSize:boundingSize];
    
    self.subjectLabel.frame = CGRectMake(kEdge, CGRectGetMaxY(self.coverImageView.frame)+kEdge, CGRectGetWidth(self.frame)-2*kEdge, subjectSize.height);
    
    CGSize introSize = [self sizeWithLabel:self.introLabel boundingSize:boundingSize];
    
    self.introLabel.frame = CGRectMake(kEdge, CGRectGetMaxY(self.subjectLabel.frame)+1.5*kEdge, CGRectGetWidth(self.subjectLabel.frame), introSize.height);
    
    self.barView.frame = CGRectMake(0, CGRectGetMaxY(self.introLabel.frame), CGRectGetWidth(self.frame), 40);
}

- (void)showVideo {
    
}

- (SMTMovieImageView *)coverImageView
{
    if (!_coverImageView)
    {
        __weak typeof(self)weakSelf = self;
        _coverImageView = [[SMTMovieImageView alloc] initWithClickBlock:^{
            [weakSelf showVideo];
        }];
    }
    return _coverImageView;
}

- (UILabel *)factoryForLabel {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = UIColorFromRGB(0x808080);
    label.font = kFontOfSize(15);
    label.adjustsFontSizeToFitWidth = YES;
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
//    label.contentMode = UIViewContentModeTop;
    return label;
}

- (SMTBarView *)barView {
    if (!_barView) {
        __weak typeof(self)weakSelf = self;
        _barView = [[SMTBarView alloc] initWithFrame:CGRectZero clickBlock:^(NSInteger itemTag) {
            if (weakSelf.itemBlock) {
                weakSelf.itemBlock(weakSelf,itemTag);
            }
        }];
    }
    return _barView;
}

@end
