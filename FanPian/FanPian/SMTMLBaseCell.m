//
//  SMTMLBaseCell.m
//  FanPian
//
//  Created by sa.xiong on 16/2/24.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTMLBaseCell.h"

@implementation SMTMLBaseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = UIColorFromRGB(0xffffff);
    
        [self addSubview:self.type];
    }
    return self;
}

- (void)showTypeTextWithType:(NSString *)type {
    NSDictionary *item = [self movieTypeDataWithType:type];
    if ([item[@"needshow"] boolValue]) {
        self.type.hidden = NO;
        self.type.text = item[@"content"];
    }else {
        self.type.hidden = YES;
    }
}

- (NSDictionary *)movieTypeDataWithType:(NSString *)type {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"movietype" ofType:@"plist"];
    NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    for (NSDictionary *item in data) {
        if ([item[@"type"] isEqualToString:type]) {
            return item;
        }
    }
    return nil;
}

- (UIButton *)lookBtn {
    if (!_lookBtn) {
        _lookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _lookBtn.layer.borderColor = [UIColorFromRGB(0xff655d) CGColor];
        _lookBtn.layer.borderWidth = 1;
        [_lookBtn setTitle:@"查看" forState:UIControlStateNormal];
        [_lookBtn setTitleColor:UIColorFromRGB(0xbf5758) forState:UIControlStateNormal];
    }
    return _lookBtn;
}

- (UILabel *)type
{
    if (!_type)
    {
        _type = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 40, 18)];
        _type.backgroundColor = [SMTRandomColor randomColor];
        _type.font = kFontOfSize(11);
        _type.textColor = [UIColor whiteColor];
        _type.alpha = 0.7;

        _type.textAlignment = NSTextAlignmentCenter;
        _type.adjustsFontSizeToFitWidth = YES;
    }
    return _type;
}

@end
