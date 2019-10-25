//
//  DBCameraMode.h
//  DBCamera
//
//  Created by a on 2019/10/8.
//  Copyright © 2019 PSSD - Daniele Bogo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBCameraMode.h"

@implementation  DBCameraModeSetting{
    NSInteger oldSetting;
}

static DBCameraModeSetting *instance = nil;
+ (DBCameraModeSetting*)instance{
    if(instance == nil){
        instance = [[DBCameraModeSetting alloc] init];
    }
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _userDefaults = [NSUserDefaults standardUserDefaults];
        [self initSettingWithLoacalConfig];
    }
    return self;
}


-(void)initSettingWithLoacalConfig{
    oldSetting = [_userDefaults integerForKey:@"DBCameraModeSetting"];
    //4种模式 占两位
    _mode = (DBCameraMode)(0b11 | oldSetting) ;
    _position = (DBCameraDevicePosition)(0b01 | (oldSetting << 2));
    _asptoMode = (DBCameraAsptoMode)(0b111 | (oldSetting << 3));
    _photoSavingType = (DBCameraPhotoSavingType)(0b01 | (oldSetting << 6));
    _videoSavingType = (DBCameraVideoSavingType)(0b01 | (oldSetting << 7));
    _videoFPSSolution = (DBCameraVideoFPSSolution)(0b11 | (oldSetting << 8));
    _videoFrameSolution = (DBCameraVideoFrameSolution)(0b11 | (oldSetting << 10));
    _timerMode = (DBCameraTimerMode)(0b11 | (oldSetting << 12));
    _autoSaving = (DBCameraAutoSaving)(0b01 | (oldSetting << 13));
    _shutterMode = (DBCameraShutterMode)(0b01 | (oldSetting << 14));
    _locationMode = (DBCameraLocationMode)(0b01 | (oldSetting << 15));
    _beautyMode = (DBCameraBeautyMode)(0b01 | (oldSetting << 16));
}

- (void)setMode:(DBCameraMode)mode{
    if(mode == _mode){ return; }
    _mode = mode;
    oldSetting = (oldSetting & (~(0b11))) | ((long)mode);
    [self updateChanges];
}

- (void)setPosition:(DBCameraDevicePosition)position{
    if(position == _position){ return; }
    _position = position;
    oldSetting = (oldSetting & (~(0b1 << 2))) | ((long)position << 2);
    [self updateChanges];
}

- (void)setAsptoMode:(DBCameraAsptoMode)asptoMode{
    if(asptoMode == _asptoMode){ return; }
    _asptoMode = asptoMode;
    oldSetting = (oldSetting & (~(0b111 << 3))) | ((long)asptoMode << 3);
    [self updateChanges];
}

- (void)setPhotoSavingType:(DBCameraPhotoSavingType)photoSavingType{
    if(photoSavingType == _photoSavingType){ return; }
    _photoSavingType = photoSavingType;
    oldSetting = (oldSetting & (~(0b1 << 6))) | ((long)photoSavingType << 6);
    [self updateChanges];
}

- (void)setVideoSavingType:(DBCameraVideoSavingType)videoSavingType{
    if(videoSavingType == _videoSavingType){ return; }
    _videoSavingType = videoSavingType;
    oldSetting = (oldSetting & (~(0b1 << 7))) | ((long)videoSavingType << 7);
    [self updateChanges];
}

- (void)setVideoFPSSolution:(DBCameraVideoFPSSolution)videoFPSSolution{
    if(videoFPSSolution == _videoFPSSolution){ return; }
    _videoFPSSolution = videoFPSSolution;
    oldSetting = (oldSetting & (~(0b11 << 8))) | ((long)videoFPSSolution << 8);
    [self updateChanges];
}

- (void)setVideoFrameSolution:(DBCameraVideoFrameSolution)videoFrameSolution{
    if(videoFrameSolution == _videoFrameSolution){ return; }
    _videoFrameSolution = videoFrameSolution;
    oldSetting = (oldSetting & (~(0b11 << 10))) | ((long)videoFrameSolution << 10);
    [self updateChanges];
}

- (void)setTimerMode:(DBCameraTimerMode)timerMode{
    if(timerMode == _timerMode){ return; }
    _timerMode = timerMode;
    oldSetting = (oldSetting & (~(0b11 << 12))) | ((long)timerMode << 12);
    [self updateChanges];
}

- (void)setAutoSaving:(DBCameraAutoSaving)autoSaving{
    if(autoSaving == _autoSaving){ return; }
    _autoSaving = autoSaving;
    oldSetting = (oldSetting & (~(0b1 << 13))) | ((long)autoSaving << 13);
    [self updateChanges];
}

- (void)setShutterMode:(DBCameraShutterMode)shutterMode{
    if(shutterMode == _shutterMode){ return; }
    _shutterMode = shutterMode;
    oldSetting = (oldSetting & (~(0b1 << 14))) | ((long)shutterMode << 14);
    [self updateChanges];
}

- (void)setLocationMode:(DBCameraLocationMode)locationMode{
    if(locationMode == _locationMode){ return; }
    _locationMode = locationMode;
    oldSetting = (oldSetting & (~(0b1 << 15))) | ((long)locationMode << 15);
    [self updateChanges];
}

- (void)setBeautyMode:(DBCameraBeautyMode)beautyMode{
    if(beautyMode == _beautyMode){ return; }
    _beautyMode = beautyMode;
    oldSetting = (oldSetting & (~(0b1 << 16))) | ((long)beautyMode << 16);
    [self updateChanges];
}


- (void)updateChanges{
    [_userDefaults setInteger:oldSetting forKey:@"DBCameraModeSetting"];
}
@end
