//
//  SMTThreadgalleryCell.m
//  FanPian
//
//  Created by sa.xiong on 16/2/24.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTThreadgalleryCell.h"
#import "SMTMovieImageView.h"
#import "SMTMEListItemModel.h"

#import "SMTBarView.h"

#define kBaseTag 1999
#define kItemSpace 5
#define kItemWidth  (SCREEN_WIDTH-2*kItemSpace)/3
#define kBaseCount 9

@interface SMTThreadgalleryCell()
@property (nonatomic, strong) UILabel *subjectLabel;
@property (nonatomic, strong) UILabel *introLabel;
@property (nonatomic, strong) SMTBarView *barView;
@property (nonatomic, assign) NSInteger actualRow;//实际行数
@end

@implementation SMTThreadgalleryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = UIColorFromRGB(0xffffff);
        
        self.subjectLabel = [self factoryForLabel];
        self.introLabel = [self factoryForLabel];
        [self.contentView addSubview:self.self.subjectLabel];
        [self.contentView addSubview:self.self.introLabel];
        [self.contentView addSubview:self.barView];
        
        [self.contentView bringSubviewToFront:self.type];

    }
    return self;
}

- (void)configureGalleryCellData:(SMTMEListItemModel *)itemModel {

    for (UIView *subView in self.contentView.subviews) {
        if ([subView isKindOfClass:[SMTMovieImageView class]]) {
            [subView removeFromSuperview];
        }
    }
    SMTShortMovieListModel *listModel = itemModel.itemdata;
    [self addGalleryItems:[listModel.imagecount integerValue] itemList:listModel.imagelist];
    
    self.subjectLabel.text = listModel.subject;
    self.introLabel.text = listModel.intro;
    
    [self showTypeTextWithType:itemModel.type];
    
    CGFloat ratio = [listModel.height floatValue]/[listModel.width floatValue];
    [self configureCellFrameWithRatio:ratio];
}

- (void)configureCellFrameWithRatio:(CGFloat)ratio {
    
    CGFloat imageMaxY = self.actualRow*(kItemWidth+kItemSpace)-kItemSpace;
    
    CGSize boundingSize = CGSizeMake(CGRectGetWidth(self.frame)-2*kEdge, 0);
    
    CGSize subjectSize = [self sizeWithLabel:self.subjectLabel boundingSize:boundingSize];
    
    self.subjectLabel.frame = CGRectMake(kEdge, imageMaxY+kEdge, CGRectGetWidth(self.frame)-2*kEdge, subjectSize.height);
    
    CGSize introSize = [self sizeWithLabel:self.introLabel boundingSize:boundingSize];
    
    self.introLabel.frame = CGRectMake(kEdge, CGRectGetMaxY(self.subjectLabel.frame)+1.5*kEdge, CGRectGetWidth(self.subjectLabel.frame), introSize.height);
    
    self.barView.frame = CGRectMake(0, CGRectGetMaxY(self.introLabel.frame), CGRectGetWidth(self.frame), 40);
    CGRect cellRect = self.frame;
    cellRect.size.height = CGRectGetMaxY(self.barView.frame);
    self.cellHeight = cellRect.size.height;

}

- (void)addGalleryItems:(NSInteger)itemCount itemList:(NSArray *)itemList {
   
    NSInteger baseCount = itemCount>kBaseCount?kBaseCount:itemCount;
    
    NSInteger row = baseCount%3==0?baseCount/3:baseCount%3; // 保证三列
    self.actualRow = row;
    
    for (NSInteger i = 0; i < row; i ++) {
        for (NSInteger j = 0; j < 3; j ++) {
            if (j + 3*i < baseCount) {
                SMTMovieImageView *imageView = [self imageViewWithIndex:j+3*i];
                imageView.frame = CGRectMake(j*(kItemWidth+kItemSpace), i*(kItemWidth+kItemSpace), kItemWidth, kItemWidth);
                [self.contentView addSubview:imageView];
                
                SMTImageListItemModel *item = itemList[j+3*i];
                [imageView downLoadImageWithPath:item.url];
            }else
                return;
        }
    }
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

- (SMTMovieImageView *)imageViewWithIndex:(NSInteger)index {
    SMTMovieImageView *imageView = [[SMTMovieImageView alloc] init];
    [imageView hideVideoPlayIcon:YES];
    imageView.tag = index+kBaseTag;
    return imageView;
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
    }
    return _barView;
}

@end
