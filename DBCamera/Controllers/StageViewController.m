//
//  StageViewController.m
//  SmallSound
//
//  Created by XINGYAN on 16/4/27.
//  Copyright © 2016年 onion. All rights reserved.
//

#import "StageViewController.h"
#import "DBCameraManager.h"
#import <Masonry.h>


@interface StageViewController ()<DBCameraViewControllerDelegate>

@end

@implementation StageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate = self;
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

#pragma mark - DBCameraViewControllerDelegate

- (void) dismissCamera:(id)cameraViewController{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    [cameraViewController restoreFullScreenMode];
}

- (void) camera:(id)cameraViewController didFinishWithImage:(UIImage *)image withMetadata:(NSDictionary *)metadata
{
    if ([self.cameraViewController isKindOfClass:[DBCameraViewController class]]){
        DBCameraViewController *dbCameraViewController = (DBCameraViewController*)self.cameraViewController;
        DBCameraManager *manager = [dbCameraViewController cameraManager];
        [manager startRunning];
//        [manager performSelector:@selector(startRunning) withObject:nil afterDelay:0.0];
      
    }else{
        //        [self.cameraViewController close:^{
        //            //显示所有文件
        //        }];
    }
}

- (BOOL)prefersStatusBarHidden{return YES;}

- (void)updateViewConstraints{
   
}

@end


