//
//  ViewController.m
//  LYCache
//
//  Created by LastDays on 16/4/14.
//  Copyright © 2016年 LastDays. All rights reserved.
//

#import "MemoryAndDiskCachePackageVC.h"
#import "LDSImageDownloader.h"
#import "LDSImageCache.h"
#import "LDSCacheManage.h"
#import "UIImageView+Cache.h"

@interface MemoryAndDiskCachePackageVC ()
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation MemoryAndDiskCachePackageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

}
- (IBAction)read:(id)sender {
    
    [[LDSImageCache shareLDImageCache] clearDiskOnCompletion:^{
        NSLog(@"完成清空");
    }];
    
}
- (IBAction)test:(id)sender {
    
    [self.image lds_setImageWithURL:@"http://image.zhangxinxu.com/image/study/s/s256/mm7.jpg" progressBlock:^(NSInteger alreadyReceiveSize,NSInteger expectedContentLength){
        self.progressView.progress = alreadyReceiveSize/(double)expectedContentLength;
        
    } completed:^(NSData *data,UIImage *image,NSError *error,BOOL finished){
        dispatch_async(dispatch_get_main_queue(), ^{
            self.status.text = @"成功";
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
