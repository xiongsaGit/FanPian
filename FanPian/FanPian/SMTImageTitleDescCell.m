//
//  SMTImageTitleDescCell.m
//  FanPian
//
//  Created by sa.xiong on 16/1/21.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTImageTitleDescCell.h"
#import "SMTShortMovieListModel.h"
#import "SMTMovieImageView.h"
#import "SMTBarView.h"

@interface SMTImageTitleDescCell()
@property (nonatomic, strong) SMTMovieImageView *coverImageView;
@property (nonatomic, strong) UILabel *subjectLabel;
@property (nonatomic, strong) UILabel *introLabel;
@property (nonatomic, strong) SMTBarView *barView;
@property (nonatomic, strong) UIButton *lookBtn;
@property (nonatomic, copy) NSString *videoUrl;
@property (nonatomic, assign) BOOL hasMore;
@end

@implementation SMTImageTitleDescCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.hasMore = NO;
        self.subjectLabel = [self factoryForLabel];
        self.subjectLabel.textColor = UIColorFromRGB(0x444444);
        self.introLabel = [self factoryForLabel];
        
        
        [self.contentView addSubview:self.self.subjectLabel];
        [self.contentView addSubview:self.self.introLabel];
        [self.contentView addSubview:self.coverImageView];
        [self.contentView addSubview:self.barView];
        [self.contentView addSubview:self.lookBtn];
        [self.coverImageView hideVideoPlayIcon:YES];
        
    }
    return self;
}

- (void)configureBarViewAtItemTag:(NSInteger)itemTag state:(BOOL)isChecked;
{
    [self.barView configureEventAtItemTag:itemTag state:isChecked];
}

- (void)configureCellData:(SMTShortMovieListModel *)listModel withLookMore:(BOOL)hasMore withType:(NSString *)type{
    self.hasMore = hasMore;
    [self configureCellData:listModel withType:type];
//    if (hasMore) {
//        NSLog(@"has more");
//        self.cellHeight += 50;
//    }
}

- (void)configureCellData:(SMTShortMovieListModel *)listModel withType:(NSString *)type {
    if ([type isEqualToString:@"threadmusic"]||[type isEqualToString:@"threadvideo"]) {
        [self.coverImageView hideVideoPlayIcon:NO];
    }
    [self.coverImageView hideVideoPlayIcon:YES];
    if ([type isEqualToString:@"collection"]) {
        self.subjectLabel.text = listModel.name;
        self.introLabel.text = listModel.desc;
        [self.coverImageView downLoadImageWithPath:listModel.image];
        CGFloat ratio = [listModel.height floatValue]/[listModel.width floatValue];
        [self configureCellFrameWithRatio:ratio showBarView:NO];

    }else {
        [self configureCellData:listModel];
    }
}

- (void)configureCellFrameWithRatio:(CGFloat)ratio showBarView:(BOOL)needShow {
   
    self.coverImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetWidth(self.frame)*ratio);
    
    CGSize boundingSize = CGSizeMake(CGRectGetWidth(self.frame)-2*kEdge, 0);
    
    CGSize subjectSize = [self sizeWithLabel:self.subjectLabel boundingSize:boundingSize];
    
    self.subjectLabel.frame = CGRectMake(kEdge, CGRectGetMaxY(self.coverImageView.frame)+kEdge, CGRectGetWidth(self.frame)-2*kEdge, subjectSize.height);
    
    CGSize introSize = [self sizeWithLabel:self.introLabel boundingSize:boundingSize];
    
    self.introLabel.frame = CGRectMake(kEdge, CGRectGetMaxY(self.subjectLabel.frame)+1.5*kEdge, CGRectGetWidth(self.subjectLabel.frame), introSize.height);
    
    CGRect cellRect = self.frame;
    CGFloat barHeight = needShow?40:0;
   
    [self.barView setHidden:!needShow];
    self.barView.frame = CGRectMake(0, CGRectGetMaxY(self.introLabel.frame), CGRectGetWidth(self.frame), barHeight);
    
    
    CGFloat lookBtnHeight = self.hasMore?30:0;
    self.lookBtn.frame = CGRectMake((SCREEN_WIDTH-100)/2, barHeight>0?(CGRectGetMaxY(self.barView.frame)+2*kEdge):(CGRectGetMaxY(self.introLabel.frame)+2*kEdge), 100, lookBtnHeight);
   
    
    cellRect.size.height = lookBtnHeight>0?(CGRectGetMaxY(self.lookBtn.frame)+kEdge):(CGRectGetMaxY(self.barView.frame)+kEdge);

    self.cellHeight = cellRect.size.height;

}

- (void)hideLookButton:(BOOL)hidden {
    [self.lookBtn setHidden:hidden];
}


- (void)configureCellData:(SMTShortMovieListModel *)listModel {
    
    self.subjectLabel.text = listModel.subject;
    self.introLabel.text = listModel.intro;
    [self.coverImageView downLoadImageWithPath:listModel.image];
    self.videoUrl = listModel.videlurl;
    
    [self addBarItems];
    CGFloat ratio = [listModel.height floatValue]/[listModel.width floatValue];
    [self configureCellFrameWithRatio:ratio showBarView:YES];
}

- (void)addBarItems {
    NSDictionary *leftDict = @{@"imageName":@"good",
                               @"title":@"赞"};
    NSDictionary *middleDict = @{@"imageName":@"reply",
                                 @"title":@"评论"};
    NSDictionary *rightDict = @{@"imageName":@"more",
                                @"title":@""};
    
    self.barView.items = @[leftDict,middleDict,rightDict];
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

- (UIButton *)lookBtn {
    if (!_lookBtn) {
        _lookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _lookBtn.layer.borderColor = [UIColorFromRGB(0xff655d) CGColor];
        _lookBtn.layer.borderWidth = 1;
        [_lookBtn setTitle:@"查看" forState:UIControlStateNormal];
        [_lookBtn setTitleColor:UIColorFromRGB(0xff655d) forState:UIControlStateNormal];
    }
    return _lookBtn;
}

@end
