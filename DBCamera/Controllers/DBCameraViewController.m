//
//  DBCameraViewController.m
//  DBCamera
//
//  Created by iBo on 31/01/14.
//  Copyright (c) 2014 PSSD - Daniele Bogo. All rights reserved.
//

#import "DBCameraViewController.h"
#import "DBCameraManager.h"
#import "DBCameraView.h"
#import "DBCameraGridView.h"
#import "DBCameraDelegate.h"

#import "DBMotionManager.h"
#import "DBCameraConfiguration.h"

#import "UIImage+Crop.h"
#import "DBCameraMacros.h"

#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

#import <Masonry.h>

#ifndef DBCameraLocalizedStrings
#define DBCameraLocalizedStrings(key) \
[[NSBundle bundleWithPath:[[NSBundle bundleForClass:[self class]] pathForResource:@"DBCamera" ofType:@"bundle"]] localizedStringForKey:(key) value:@"" table:@"DBCamera"]
#endif

@interface DBCameraViewController () <DBCameraManagerDelegate, DBCameraViewDelegate> {
}

@property (nonatomic, strong) id customCamera;
@end

@implementation DBCameraViewController
@synthesize cameraGridView = _cameraGridView;
@synthesize forceQuadCrop = _forceQuadCrop;
@synthesize tintColor = _tintColor;
@synthesize selectedTintColor = _selectedTintColor;
@synthesize cameraSegueConfigureBlock = _cameraSegueConfigureBlock;
@synthesize cameraManager = _cameraManager;

@synthesize  _processingPhoto = __processingPhoto;
@synthesize  _deviceOrientation = __deviceOrientation;
@synthesize  wasStatusBarHidden = _wasStatusBarHidden;
@synthesize  wasWantsFullScreenLayout = _wasWantsFullScreenLayout;

@synthesize  isSetConstraints;

#pragma mark - Life cycle

+ (instancetype) initWithDelegate:(id<DBCameraViewControllerDelegate>)delegate
{
    return [[self alloc] initWithDelegate:delegate cameraView:nil];
}

+ (instancetype) init
{
    return [[self alloc] initWithDelegate:nil cameraView:nil];
}

- (instancetype) initWithDelegate:(id<DBCameraViewControllerDelegate>)delegate cameraView:(id)camera
{
    self = [super init];

    if ( self ) {
        __processingPhoto = NO;
        __deviceOrientation = UIDeviceOrientationPortrait;
        if ( delegate )
            _delegate = delegate;

        if ( camera )
            [self setCustomCamera:camera];

        [self setUseCameraSegue:YES];

        [self setTintColor:[UIColor whiteColor]];
        [self setSelectedTintColor:[UIColor cyanColor]];
    }

    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.view setBackgroundColor:[UIColor blackColor]];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:)
                                                 name:UIApplicationDidEnterBackgroundNotification object:nil];

    NSError *error;
    if ( [self.cameraManager setupSessionWithPreset:AVCaptureSessionPresetPhoto error:&error] ) {
        if ( self.customCamera ) {
            if ( [self.customCamera respondsToSelector:@selector(previewLayer)] ) {
                [(AVCaptureVideoPreviewLayer *)[self.customCamera valueForKey:@"previewLayer"] setSession:self.cameraManager.captureSession];

                if ( [self.customCamera respondsToSelector:@selector(delegate)] )
                    [self.customCamera setValue:self forKey:@"delegate"];
            }

            [self.view addSubview:self.customCamera];
        } else{
            [self.view addSubview:self.cameraView];
  
        }
    }

    id camera =_customCamera ?: _cameraView;
    [camera insertSubview:self.cameraGridView atIndex:1];
    
    if ( [camera respondsToSelector:@selector(cameraChangeButton)] ) {
        [(DBCameraView *)camera cameraChangeButton].enabled = [self.cameraManager hasMultipleCameras];
        [self.cameraManager hasMultipleCameras];
    }
    
    if ( self.cameraConfiguration.configureCameraController ) {
        self.cameraConfiguration.configureCameraController(self);
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.cameraManager performSelector:@selector(startRunning) withObject:nil afterDelay:0.0];
    
    __weak typeof(self) weakSelf = self;
    [[DBMotionManager sharedManager] setMotionRotationHandler:^(UIDeviceOrientation orientation){
        [weakSelf rotationChanged:orientation];
    }];
    [[DBMotionManager sharedManager] startMotionHandler];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ( self.customCamera == nil ) {
        [self checkForLibraryImage];
    } else {
        DBCameraView *cameraView = (DBCameraView *)self.customCamera;
        
    }
    
    if (!isSetConstraints){
        isSetConstraints = YES;
        [self updateViewConstraints];
    }
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.cameraManager performSelector:@selector(stopRunning) withObject:nil afterDelay:0.0];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    _cameraManager = nil;
}

- (NSUInteger)supportedInterfaceOrientations {
    //return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
    return UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (void) checkForLibraryImage
{
    if ( !self.cameraView.photoLibraryButton.isHidden && [self.parentViewController.class isSubclassOfClass:NSClassFromString(@"DBCameraContainerViewController")] ) {
        if ( [ALAssetsLibrary authorizationStatus] !=  ALAuthorizationStatusDenied ) {
//            __weak DBCameraView *weakCamera = self.cameraView;
//            [[DBLibraryManager sharedInstance] loadLastItemWithBlock:^(BOOL success, UIImage *image) {
//                [weakCamera.photoLibraryButton setBackgroundImage:image forState:UIControlStateNormal];
//            }];
        }
    } else
        [self.cameraView.photoLibraryButton setHidden:YES];
}

- (BOOL) prefersStatusBarHidden
{
    return YES;
}

- (void) dismissCamera
{
    if ( _delegate && [_delegate respondsToSelector:@selector(dismissCamera:)] )
        [_delegate dismissCamera:self];
}

- (DBCameraView *) cameraView
{
    if ( !_cameraView ) {
        _cameraView = [DBCameraView initWithCaptureSession:self.cameraManager.captureSession];
        [_cameraView setTintColor:self.tintColor];
        [_cameraView setSelectedTintColor:self.selectedTintColor];
        [_cameraView defaultInterface];
        [_cameraView setDelegate:self];
    }

    return _cameraView;
}

- (DBCameraManager *) cameraManager
{
    if ( !_cameraManager ) {
        _cameraManager = [[DBCameraManager alloc] init];
        [_cameraManager setDelegate:self];
    }

    return _cameraManager;
}

- (DBCameraGridView *) cameraGridView
{
    if ( !_cameraGridView ) {
        DBCameraView *camera =_customCamera ?: _cameraView;
        _cameraGridView = [[DBCameraGridView alloc] initWithFrame:camera.previewLayer.frame];
        [_cameraGridView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [_cameraGridView setNumberOfColumns:2];
        [_cameraGridView setNumberOfRows:2];
        [_cameraGridView setAlpha:0];
    }

    return _cameraGridView;
}

- (void) setCameraGridView:(DBCameraGridView *)cameraGridView
{
    _cameraGridView = cameraGridView;
    __block DBCameraGridView *blockGridView = cameraGridView;
    __weak DBCameraView *camera =_customCamera ?: _cameraView;
    [camera.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ( [obj isKindOfClass:[DBCameraGridView class]] ) {
            [obj removeFromSuperview];
            [camera insertSubview:blockGridView atIndex:1];
            blockGridView = nil;
            *stop = YES;
        }
    }];
}

- (void) rotationChanged:(UIDeviceOrientation) orientation
{
    if ( orientation != UIDeviceOrientationUnknown ||
         orientation != UIDeviceOrientationFaceUp ||
         orientation != UIDeviceOrientationFaceDown ) {
        [self rotateViewsFrom:__deviceOrientation to:orientation];
        __deviceOrientation = orientation;
    }
}

- (void)rotateViewsFrom:(UIDeviceOrientation)old to:(UIDeviceOrientation)new{
    CGAffineTransform trans = CGAffineTransformIdentity;
    if(new == UIDeviceOrientationLandscapeLeft){
        trans = CGAffineTransformMakeRotation( M_PI_2 );
    }else if(new == UIDeviceOrientationLandscapeRight){
        trans = CGAffineTransformMakeRotation( -M_PI_2 );
    }else if(new == UIDeviceOrientationPortraitUpsideDown){
        trans = CGAffineTransformMakeRotation(  M_PI );
    }
    [UIView animateWithDuration:0.2 animations:^{
        [self.cameraView updateForOriention:trans];
    }];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    DBCameraView *camera = _customCamera ?: _cameraView;
    camera.frame = CGRectMake(0, 0, size.width, size.height);
    camera.previewLayer.frame = CGRectMake(0, 0, size.width, size.height);
}

+ (AVCaptureVideoOrientation)interfaceOrientationToVideoOrientation:(UIInterfaceOrientation)orientation {
    AVCaptureVideoOrientation videoOrientation = AVCaptureVideoOrientationPortrait;
    switch (orientation) {
        case UIInterfaceOrientationPortraitUpsideDown:
            videoOrientation = AVCaptureVideoOrientationPortraitUpsideDown;
            break;
        case UIInterfaceOrientationLandscapeLeft:
            videoOrientation = AVCaptureVideoOrientationLandscapeLeft;
            break;
        case UIInterfaceOrientationLandscapeRight:
            videoOrientation = AVCaptureVideoOrientationLandscapeRight;
            break;
        default:
            break;
    }
    return videoOrientation;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    AVCaptureVideoOrientation videoOrientation = [[self class] interfaceOrientationToVideoOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    DBCameraView *camera = _customCamera ?: _cameraView;
    if (camera.previewLayer.connection.supportsVideoOrientation
        && camera.previewLayer.connection.videoOrientation != videoOrientation) {
        camera.previewLayer.connection.videoOrientation = videoOrientation;
    }
}

#pragma mark - CameraManagerDelagate

- (void) closeCamera
{
    [self dismissCamera];
}

- (void) switchCamera
{
    if ( [self.cameraManager hasMultipleCameras] )
        [self.cameraManager cameraToggle];
}

- (void) cameraView:(UIView *)camera showGridView:(BOOL)show {
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.cameraGridView.alpha = (show ? 1.0 : 0.0);
    } completion:NULL];
}

- (void) triggerFlashForMode:(AVCaptureFlashMode)flashMode
{
    if ( [self.cameraManager hasFlash] )
        [self.cameraManager setFlashMode:flashMode];
}

- (void) captureImageDidFinish:(UIImage *)image withMetadata:(NSDictionary *)metadata
{
    __processingPhoto = NO;

    NSMutableDictionary *finalMetadata = [NSMutableDictionary dictionaryWithDictionary:metadata];
    finalMetadata[@"DBCameraSource"] = @"Camera";

    if ( !self.useCameraSegue ) {
        if ( [_delegate respondsToSelector:@selector(camera:didFinishWithImage:withMetadata:)] )
            [_delegate camera:self didFinishWithImage:image withMetadata:finalMetadata];
    }
}

- (void) captureImageFailedWithError:(NSError *)error
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
    });
}

- (void) captureSessionDidStartRunning
{
    id camera = self.customCamera ?: _cameraView;
    CGRect bounds = [(UIView *)camera bounds];
    CGPoint screenCenter = (CGPoint){ CGRectGetMidX(bounds), CGRectGetMidY(bounds) };
    if ([camera respondsToSelector:@selector(drawFocusBoxAtPointOfInterest:andRemove:)] )
        [camera drawFocusBoxAtPointOfInterest:screenCenter andRemove:NO];
    if ( [camera respondsToSelector:@selector(drawExposeBoxAtPointOfInterest:andRemove:)] )
        [camera drawExposeBoxAtPointOfInterest:screenCenter andRemove:NO];
}

- (void) openLibrary
{
    if ( [ALAssetsLibrary authorizationStatus] !=  ALAuthorizationStatusDenied ) {
        
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[[UIAlertView alloc] initWithTitle:DBCameraLocalizedStrings(@"general.error.title") message:DBCameraLocalizedStrings(@"pickerimage.nopolicy") delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
        });
    }
}

#pragma mark - CameraViewDelegate

- (void) cameraViewStartRecording
{
    if ( __processingPhoto )
        return;

    __processingPhoto = YES;

    if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_7_0) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];

        if (status == AVAuthorizationStatusDenied || status == AVAuthorizationStatusRestricted) {
            [[[UIAlertView alloc] initWithTitle:DBCameraLocalizedStrings(@"general.error.title")
                                        message:DBCameraLocalizedStrings(@"cameraimage.nopolicy")
                                       delegate:nil
                              cancelButtonTitle:@"Ok"
                              otherButtonTitles:nil, nil] show];

            return;
        }
        else if (status == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:nil];

            return;
        }
    }

    [self.cameraManager captureImageForDeviceOrientation:__deviceOrientation];
}

- (void) cameraView:(UIView *)camera focusAtPoint:(CGPoint)point
{
    if ( self.cameraManager.videoInput.device.isFocusPointOfInterestSupported ) {
        [self.cameraManager focusAtPoint:[self.cameraManager convertToPointOfInterestFrom:[[(DBCameraView *)camera previewLayer] frame]
                                                                              coordinates:point
                                                                                    layer:[(DBCameraView *)camera previewLayer]]];
    }
}

- (BOOL) cameraViewHasFocus
{
    return self.cameraManager.hasFocus;
}

- (void) cameraView:(UIView *)camera exposeAtPoint:(CGPoint)point
{
    if ( self.cameraManager.videoInput.device.isExposurePointOfInterestSupported ) {
        [self.cameraManager exposureAtPoint:[self.cameraManager convertToPointOfInterestFrom:[[(DBCameraView *)camera previewLayer] frame]
                                                                                 coordinates:point
                                                                                       layer:[(DBCameraView *)camera previewLayer]]];
    }
}

- (CGFloat) cameraMaxScale
{
    return [self.cameraManager cameraMaxScale];
}

- (void) cameraCaptureScale:(CGFloat)scaleNum
{
    [self.cameraManager setCameraMaxScale:scaleNum];
}

#pragma mark - UIApplicationDidEnterBackgroundNotification

- (void) applicationDidEnterBackground:(NSNotification *)notification
{
    id modalViewController = self.presentingViewController;
    if ( modalViewController )
        [self dismissCamera];
}

#pragma mark - DBCameraControllerProtocol

- (void) setInitialCameraPosition:(AVCaptureDevicePosition)initialCameraPosition {
    
    if ( initialCameraPosition == self.cameraManager.cameraPosition || initialCameraPosition == AVCaptureDevicePositionUnspecified) {
        return;
    }
    
    [self switchCamera];
    
}

- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(id<UIContentContainer>)container{
    NSLog(@"尺寸变化");
}

@end
