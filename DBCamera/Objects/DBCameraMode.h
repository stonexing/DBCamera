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

typedef NS_ENUM(NSUInteger, DBCameraAsptoMode) { //默认以最大分辨率处理照片
    DBCameraAsptoModeFull,
    DBCameraAsptoMode9x16,
    DBCameraAsptoMode3x4,
    DBCameraAsptoMode1x1,
    DBCameraAsptoModeCircle,
};

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
