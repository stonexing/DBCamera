//
//  DBCameraMode.h
//  DBCamera
//
//  Created by a on 2019/10/8.
//  Copyright © 2019 PSSD - Daniele Bogo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DBCameraMode){
    DBCameraModeCamera,
    DBCameraModeVideo,
    DBCameraModeLivePhoto,
    DBCameraModeScanQRCode,
};
typedef NS_ENUM(NSUInteger, DBCameraDevicePosition){
    DBCameraDevicePositionBack        = 0,
    DBCameraDevicePositionFront       = 1,
};

typedef NS_OPTIONS(NSUInteger, DBCameraAsptoSupportedMode) {
    DBCameraAsptoSupportedModeFull = 1 << 0,
    DBCameraAsptoSupportedMode9x16 = 1 << 1,
    DBCameraAsptoSupportedMode3x4 = 1 << 2,
    DBCameraAsptoSupportedMode1x1 = 1 << 3,
    DBCameraAsptoSupportedModeCircle = 1 << 4,
};
//默认以3x4处理照片跟系统相机保持一致
typedef NS_ENUM(NSInteger, DBCameraAsptoMode) {
    DBCameraAsptoMode3x4 = 0,
    DBCameraAsptoMode1x1 = 1,
    DBCameraAsptoModeCircle = 2,
    DBCameraAsptoModeFull = 3,
    DBCameraAsptoMode9x16 = 4,
};

//若支持HECI 则优先
typedef NS_ENUM(NSUInteger, DBCameraPhotoSavingType) {
    DBCameraPhotoSavingTypeJPEG,
    DBCameraPhotoSavingTypeHEIC,
};

typedef NS_ENUM(NSUInteger, DBCameraVideoSavingType) {
    DBCameraImageSavingTypeH264,
    DBCameraImageSavingTypeHEVC,
    DBCameraImageSavingTypeH265,
};


typedef NS_ENUM(NSUInteger, DBCameraVideoFPSSolution) { //默认以最大分辨率保存视频
    DBCameraVideoFPSSolution60,
    DBCameraVideoFPSSolution30,
    DBCameraVideoFPSSolution24,
};


typedef NS_ENUM(NSUInteger, DBCameraVideoFrameSolution) { //默认以最大分辨率保存视频
    DBCameraVideoFrameSolutionUHD,
    DBCameraVideoFrameSolutionHD,
    DBCameraVideoFrameSolutionMax,
};

typedef NS_ENUM(NSUInteger, DBCameraTimerMode) { //默认以最大分辨率保存视频
    DBCameraTimerModeOff = 0,
    DBCameraTimerMode3,
    DBCameraTimerMode7,
};

typedef NS_ENUM(NSUInteger, DBCameraAutoSaving) { //默认以最大分辨率保存视频
    DBCameraAutoSavingON = 0,
    DBCameraAutoSavingOFF = 1,
};


typedef NS_ENUM(NSUInteger, DBCameraShutterMode) { //默认以最大分辨率保存视频
    DBCameraShutterModeSilent = 0,
    DBCameraShutterModeNormal = 1,
};

typedef NS_ENUM(NSUInteger, DBCameraLocationMode) { //默认以最大分辨率保存视频
    DBCameraLocationModeOff = 0,
    DBCameraLocationModeOn = 1,
};
typedef NS_ENUM(NSUInteger, DBCameraBeautyMode) { //默认以最大分辨率保存视频
    DBCameraBeautyModeOff = 0,
    DBCameraBeautyModeOn = 1,
};


@interface  DBCameraModeSetting:NSObject
+ (DBCameraModeSetting*)instance;

@property (nonatomic, retain)NSUserDefaults *userDefaults;
@property (nonatomic, assign)DBCameraMode mode;
@property (nonatomic, assign)DBCameraDevicePosition position;
@property (nonatomic, assign)DBCameraAsptoMode asptoMode;
@property (nonatomic, assign)DBCameraPhotoSavingType photoSavingType;
@property (nonatomic, assign)DBCameraVideoSavingType videoSavingType;
@property (nonatomic, assign)DBCameraVideoFPSSolution videoFPSSolution;
@property (nonatomic, assign)DBCameraVideoFrameSolution videoFrameSolution;
@property (nonatomic, assign)DBCameraTimerMode timerMode;
@property (nonatomic, assign)DBCameraAutoSaving autoSaving;
@property (nonatomic, assign)DBCameraShutterMode shutterMode;
@property (nonatomic, assign)DBCameraLocationMode locationMode;
@property (nonatomic, assign)DBCameraBeautyMode beautyMode;

@end


NS_ASSUME_NONNULL_END
