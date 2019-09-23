

//
//  StageViewController.h
//  SmallSound
//
//  Created by XINGYAN on 16/4/27.
//  Copyright © 2016年 onion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBCameraViewController.h"
#import "DBCameraContainerViewController.h"
#import "DBCameraLibraryViewController.h"
#import "DBCameraGridView.h"
#import <AssetsLibrary/AssetsLibrary.h>


NS_ASSUME_NONNULL_BEGIN


@interface StageViewController : DBCameraContainerViewController

@property (nonatomic, strong) NSMutableArray *assets;
@property (nonatomic, strong) ALAssetsLibrary *ALAssetsLibrary;

+(StageViewController *)getInstance;


-(void)fixADViewShow;

- (void)showInterstitialAD;


- (BOOL)shouldDisplayAds;



@end

NS_ASSUME_NONNULL_END
