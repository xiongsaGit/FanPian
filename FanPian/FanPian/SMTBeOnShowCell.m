//
//  SMTBeOnShowCell.m
//  FanPian
//
//  Created by sa.xiong on 16/1/20.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTBeOnShowCell.h"
#import "SMTBeOnShowListModel.h"

#define CoverImageViewWidth 180*SCREEN_WIDTH/MIN_SCREEN_WIDTH

@interface SMTBeOnShowCell()
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *movieTitleLabel;//
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *moviePubDateLabel;//
@property (nonatomic, strong) UILabel *pubdateLabel;
@property (nonatomic, strong) UILabel *movieDirectorLabel;//
@property (nonatomic, strong) UILabel *directorLabel;
@property (nonatomic, strong) UILabel *movieCastsLabel;//
@property (nonatomic, strong) UILabel *castsLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@end

@implementation SMTBeOnShowCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configureUI];
        [self baseDataSetting];
    }
    return self;
}

- (void)configureCellData:(SMTBeOnShowListModel *)listModel {
    
    self.titleLabel.text = listModel.moviedata.title;
    self.pubdateLabel.text = listModel.moviedata.pubdate;
    self.directorLabel.text = listModel.moviedata.directors;
    self.castsLabel.text = listModel.moviedata.casts;
    self.messageLabel.text = listModel.message;
    
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",kBaseURL,listModel.moviedata.image]] placeholderImage:nil options:SDWebImageProgressiveDownload];
    
    CGFloat ratio = [listModel.moviedata.height floatValue]/[listModel.moviedata.width floatValue];
    [self configureFrameWithRatio:ratio];
}

- (void)configureFrameWithRatio:(CGFloat)ratio {
    
    self.coverImageView.frame = CGRectMake(kEdge, kEdge*1.5, CoverImageViewWidth, CoverImageViewWidth*ratio);
    
    CGSize movieTitleSize = [self sizeWithLabel:self.movieTitleLabel];
    
    CGSize titleSize = [self sizeWithLabel:self.titleLabel];
    
    CGSize moviePubDateSize = [self sizeWithLabel:self.moviePubDateLabel];
    
    CGSize pubDateSize = [self sizeWithLabel:self.pubdateLabel];
    
    CGSize movieDirectorSize = [self sizeWithLabel:self.movieDirectorLabel];
    
    CGSize directorSize = [self sizeWithLabel:self.directorLabel];
    
    CGSize movieCastsSize = [self sizeWithLabel:self.movieCastsLabel];
    
    CGSize castsSize = [self sizeWithLabel:self.castsLabel];
    
    
    self.movieTitleLabel.frame = CGRectMake(CGRectGetMaxX(self.coverImageView.frame)+kEdge, CGRectGetMinX(self.coverImageView.frame), movieTitleSize.width, movieTitleSize.height);
     self.titleLabel.frame = CGRectMake(CGRectGetMinX(self.movieTitleLabel.frame), CGRectGetMaxY(self.movieTitleLabel.frame)+kEdge/2, titleSize.width,titleSize.height);
    
    self.moviePubDateLabel.frame = CGRectMake(CGRectGetMinX(self.movieTitleLabel.frame), CGRectGetMaxY(self.titleLabel.frame)+kEdge*1.5, moviePubDateSize.width,moviePubDateSize.height);
    self.pubdateLabel.frame = CGRectMake(CGRectGetMinX(self.movieTitleLabel.frame), CGRectGetMaxY(self.moviePubDateLabel.frame)+kEdge/2, pubDateSize.width,pubDateSize.height);
    
    self.movieDirectorLabel.frame = CGRectMake(CGRectGetMinX(self.movieTitleLabel.frame), CGRectGetMaxY(self.pubdateLabel.frame)+kEdge*1.5, movieDirectorSize.width,movieDirectorSize.height);
    self.directorLabel.frame = CGRectMake(CGRectGetMinX(self.movieTitleLabel.frame), CGRectGetMaxY(self.movieDirectorLabel.frame)+kEdge/2, directorSize.width,directorSize.height);
    
    self.movieCastsLabel.frame = CGRectMake(CGRectGetMinX(self.movieTitleLabel.frame), CGRectGetMaxY(self.directorLabel.frame)+kEdge*1.5, movieCastsSize.width,movieCastsSize.height);
    self.castsLabel.frame = CGRectMake(CGRectGetMinX(self.movieTitleLabel.frame), CGRectGetMaxY(self.movieCastsLabel.frame)+kEdge/2,castsSize.width,castsSize.height);
    
    self.messageLabel.frame = CGRectMake(CGRectGetMinX(self.coverImageView.frame), CGRectGetMaxY(self.coverImageView.frame)+1.5*kEdge, CGRectGetWidth(self.frame)-2*kEdge, kLabelCommonHeight);
    
    if (CGRectGetMaxY(self.castsLabel.frame)>CGRectGetMinY(self.messageLabel.frame)) {
        CGRect castRect = self.castsLabel.frame;
        castRect.size.height = CGRectGetMinY(self.messageLabel.frame)-castRect.origin.y;
        self.castsLabel.frame = castRect;
    }
}

- (CGSize)sizeWithLabel:(UILabel *)label {
   
    CGSize resultSize = [label.text boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.frame)-CGRectGetMaxX(self.coverImageView.frame)-2*kEdge, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName:label.font} context:nil].size;
    
    return resultSize;
}


- (void)baseDataSetting {
    self.movieTitleLabel.text = @"片名";
    self.moviePubDateLabel.text = @"上映时间";
    self.movieDirectorLabel.text = @"导演";
    self.movieCastsLabel.text = @"主演";
}


- (void)configureUI {
    [self.contentView addSubview:self.coverImageView];
    
    self.movieTitleLabel = [self factoryForLabel];
    self.titleLabel = [self factoryForLabel];
   
    self.moviePubDateLabel = [self factoryForLabel];
    self.pubdateLabel = [self factoryForLabel];
    
    self.movieDirectorLabel = [self factoryForLabel];
    self.directorLabel = [self factoryForLabel];
    
    self.movieCastsLabel = [self factoryForLabel];
    self.castsLabel = [self factoryForLabel];
    
    self.messageLabel = [self factoryForLabel];
    
    [self.contentView addSubview:self.self.movieTitleLabel];
    [self.contentView addSubview:self.self.titleLabel];
   
    [self.contentView addSubview:self.self.moviePubDateLabel];
    [self.contentView addSubview:self.self.pubdateLabel];
    
    [self.contentView addSubview:self.self.movieDirectorLabel];
    [self.contentView addSubview:self.self.directorLabel];
    
    [self.contentView addSubview:self.self.movieCastsLabel];
    [self.contentView addSubview:self.self.castsLabel];
    
    [self.contentView addSubview:self.self.messageLabel];
  
}

- (UIImageView *)coverImageView
{
    if (!_coverImageView)
    {
        _coverImageView = [[UIImageView alloc] init];
    }
    return _coverImageView;
}

- (UILabel *)factoryForLabel {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = UIColorFromRGB(0x808080);
    label.font = kFontOfSize(13);
    label.minimumScaleFactor = 12/13;
    label.adjustsFontSizeToFitWidth = YES;
    label.numberOfLines = 0;
    label.contentMode = UIViewContentModeTop;
    return label;
}
@end
