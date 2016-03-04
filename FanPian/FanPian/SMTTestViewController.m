//
//  SMTTestViewController.m
//  FanPian
//
//  Created by sa.xiong on 16/3/3.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTTestViewController.h"
#import "SMTOtherTestViewController.h"
#import "ImageVideoView.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>

@interface SMTTestViewController ()
@property (nonatomic, strong) ImageVideoView *imageVideoView;

@end

@implementation SMTTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self.view addSubview:self.imageVideoView];
    self.imageVideoView.frame = self.view.bounds;
   // [self.imageVideoView loadViewData:@{@"type":@"image1",
    //                                    @"dataList":@[@"http://morguo.com/data/attachment/movietrailer/threadvideo/2015/35366_LovingVincent.mp4"]}];// http://7xjdla.com1.z0.glb.clouddn.com/apicloud/c002853ae48c407441d76c9a1c1ad1e1.jpg
//
    
   [self.imageVideoView loadViewData:@{@"type":@"image",
                                        @"dataList":@[@"http://7xjdla.com1.z0.glb.clouddn.com/apicloud/c002853ae48c407441d76c9a1c1ad1e1.jpg"]}];// http://7xjdla.com1.z0.glb.clouddn.com/apicloud/c002853ae48c407441d76c9a1c1ad1e1.jpg
//    

    
}


- (ImageVideoView *)imageVideoView {
    if (!_imageVideoView) {
        
        __weak typeof(self)weakSelf = self;
        _imageVideoView = [[ImageVideoView alloc] initWithSkipBlock:^{
            NSLog(@"SKIP");
            SMTOtherTestViewController *viewCtrl = [[SMTOtherTestViewController alloc] init];
            [weakSelf.view.window setRootViewController:viewCtrl];
        }];
    }
    return _imageVideoView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
