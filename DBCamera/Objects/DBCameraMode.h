//
//  DBCameraMode.h
//  DBCamera
//
//  Created by a on 2019/10/8.
//  Copyright © 2019 PSSD - Daniele Bogo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DBCameraMode){
    DBCameraModeCamera,
    DBCameraModeVideo,
    DBCameraModeLivePhoto,
    DBCameraModeScanQRCode,
};

typedef NS_OPTIONS(NSUInteger, DBCameraAsptoSupportedMode) {
    DBCameraAsptoSupportedModeFull = 1 << 0,
    DBCameraAsptoSupportedMode9x16 = 1 << 1,
    DBCameraAsptoSupportedMode3x4 = 1 << 2,
    DBCameraAsptoSupportedMode1x1 = 1 << 3,
    DBCameraAsptoSupportedModeCircle = 1 << 4,
};
//默认以3x4处理照片跟系统相机保持一致
typedef NS_ENUM(NSUInteger, DBCameraAsptoMode) {
    DBCameraAsptoModeFull,
    DBCameraAsptoMode9x16,
    DBCameraAsptoMode3x4,
    DBCameraAsptoMode1x1,
    DBCameraAsptoModeCircle,
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

NS_ASSUME_NONNULL_END
