//
//  DBCameraContainerViewController.m
//  DBCamera
//
//  Created by iBo on 06/03/14.
//  Copyright (c) 2014 PSSD - Daniele Bogo. All rights reserved.
//

#import "DBCameraContainerViewController.h"
#import "DBCameraViewController.h"
#import "DBCameraMacros.h"
#import "DBCameraView.h"

#import <Masonry.h>

@interface DBCameraContainerViewController () <DBCameraContainerDelegate> {
    CameraSettingsBlock _settingsBlock;
    BOOL _wasStatusBarHidden;
    BOOL _wasWantsFullScreenLayout;
}
@property (nonatomic, strong) DBCameraViewController *defaultCameraViewController;
@end

@implementation DBCameraContainerViewController
@synthesize tintColor = _tintColor;
@synthesize selectedTintColor = _selectedTintColor;

- (instancetype) initWithDelegate:(id<DBCameraViewControllerDelegate>)delegate
{
    return [self initWithDelegate:delegate cameraSettingsBlock:nil];
}

- (instancetype) initWithDelegate:(id<DBCameraViewControllerDelegate>)delegate cameraSettingsBlock:(CameraSettingsBlock)block
{
    return [self initWithDelegate:delegate cameraConfiguration:nil cameraSettingsBlock:block];
}

- (instancetype) initWithDelegate:(id<DBCameraViewControllerDelegate>)delegate
              cameraConfiguration:(DBCameraConfiguration *)cameraConfiguration
{
    return [self initWithDelegate:delegate cameraConfiguration:cameraConfiguration cameraSettingsBlock:nil];
}

- (instancetype) initWithDelegate:(id<DBCameraViewControllerDelegate>)delegate
              cameraConfiguration:(DBCameraConfiguration *)cameraConfiguration
              cameraSettingsBlock:(CameraSettingsBlock)block
{
    
    self = [super init];
    if ( self ) {
        _delegate = delegate;
        _settingsBlock = block;
        _cameraConfiguration = cameraConfiguration;
    }
    
    return self;
    
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:RGBColor(0x000000, 1)];
    
    [self addChildViewController:self.defaultCameraViewController];
    [self.view addSubview:self.defaultCameraViewController.view];
    if ( _settingsBlock )
        _settingsBlock(self.cameraViewController.cameraView, self);
    
    
}


- (BOOL) prefersStatusBarHidden
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{

    return UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

#pragma mark - DBCameraContainerDelegate

- (void) backFromController:(id)fromController
{
    [self switchFromController:fromController
                  toController:self.defaultCameraViewController];
}

- (void) switchFromController:(id)fromController toController:(id)controller
{
    [[(UIViewController *)controller view] setAlpha:1];
    [[(UIViewController *)controller view] setTransform:CGAffineTransformMakeScale(1, 1)];
    [self addChildViewController:controller];
    
    __block id blockViewController = fromController;
    
    [self transitionFromViewController:blockViewController
                      toViewController:controller
                              duration:.2
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^(void){ }
                            completion:^(BOOL finished) {
                                [blockViewController removeFromParentViewController];
                                blockViewController = nil;
                            }];
}

#pragma mark - Properties

- (DBCameraViewController *) defaultCameraViewController
{
    if ( !_defaultCameraViewController ) {
        _defaultCameraViewController = [DBCameraViewController initWithDelegate:_delegate];
        if ( self.tintColor )
            [_defaultCameraViewController setTintColor:self.tintColor];
        if ( self.selectedTintColor )
            [_defaultCameraViewController setSelectedTintColor:self.selectedTintColor];
        _defaultCameraViewController.cameraConfiguration = self.cameraConfiguration;
    }
    
    if ( !self.cameraViewController )
        [self setCameraViewController:_defaultCameraViewController];
    
    return self.cameraViewController;
}

- (void) setCameraViewController:(DBCameraViewController *)cameraViewController
{
    _cameraViewController = cameraViewController;
    [_cameraViewController setIsContained:YES];
    [_cameraViewController setContainerDelegate:self];
    _defaultCameraViewController = nil;
}

- (DBCameraView *)getCameraView{
    return self.cameraViewController.cameraView;
}

- (void)updateViewConstraints{
    [super updateViewConstraints];
}


@end
