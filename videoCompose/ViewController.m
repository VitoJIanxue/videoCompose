//
//  ViewController.m
//  videoCompose
//
//  Created by Vito on 2020/2/28.
//  Copyright © 2020 inspur. All rights reserved.
//

#import "ViewController.h"
#import "HandlerVideo.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // 合并视频 (注：将视频导出路径设置为桌面方便测试，实际开发存入沙盒即可)
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"123" ofType:@"mp4"];
    NSString *path3 = [[NSBundle mainBundle] pathForResource:@"456" ofType:@"mp4"];
    
    NSArray *pathDocuments = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *outputURL = pathDocuments[0];
    uint32_t random = arc4random() % 1000;
    NSString * Path = [[outputURL stringByAppendingPathComponent:[NSString stringWithFormat:@"abcd%u", random]] stringByAppendingPathExtension:@"mp4"];
    NSLog(@"路径===%@",Path);
    
    NSMutableArray *conbineVideos = [NSMutableArray arrayWithObjects:path1,path3,nil];
    [[HandlerVideo sharedInstance] combinationVideosWithVideoPath:conbineVideos videoFullPath:Path isHavaAudio:YES progressBlock:^(CGFloat progress) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"进度:%f",progress);
        });
    }  completedBlock:^(BOOL success, NSString *msg) {
        if (success) {
            NSLog(@"---->  SUCCESS");
            
        } else {
            NSLog(@"---->> %@",msg);
        }
    }];
}


@end
