//
//  CameraViewConstrants.swift
//  DBCamera
//
//  Created by a on 2019/9/29.
//  Copyright © 2019 PSSD - Daniele Bogo. All rights reserved.
//

import UIKit


extension GSViewController {

    override func updateViewConstraints() {
        super.updateViewConstraints()
        
    
        self.cameraViewController.view.mas_makeConstraints{ make in
            make?.top.equalTo()(self.view.mas_top)
            make?.bottom.equalTo()(self.view.mas_bottom)
            make?.leading.equalTo()(self.view.mas_leading)
            make?.trailing.equalTo()(self.view.mas_trailing)
        }
        self.cameraViewController.updateViewConstraints()
        if let cameraView: DBCameraView = self.cameraViewController.cameraView
        {
            cameraView.updateViewConstraints(self)
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
    
        return .portrait
    }
    
}

extension DBCameraView {
    open func updateViewConstraints(_ vc:UIViewController) {

        self.mas_makeConstraints { make in
            make?.edges.mas_equalTo()(vc.view)
        }
//        self.preViewContainer.backgroundColor = .red
        self.preViewContainer.mas_makeConstraints{ make in
            if #available(iOS 11.0, *) {
                make?.top.equalTo()(vc.view.mas_safeAreaLayoutGuideTop)
                make?.bottom.equalTo()(vc.view.mas_safeAreaLayoutGuideBottom)
                make?.left.equalTo()(vc.view.mas_safeAreaLayoutGuideLeft)
                make?.right.equalTo()(vc.view.mas_safeAreaLayoutGuideRight)
            } else {
                make?.edges.equalTo()(vc.view)
            }
        }
        //仅支持竖屏
        if(UIDevice.current.userInterfaceIdiom == .phone){
            phoneConstants(vc.view)
        }else if(UIDevice.current.userInterfaceIdiom == .pad){
            padConstants(vc.view)
        }
    }
    func phoneConstants(_ v:UIView){
        self.topContainerBar.mas_makeConstraints{ make in
            make?.top.equalTo()(v.mas_top)
            if #available(iOS 11.0, *) {
                make?.bottom.equalTo()(v.mas_safeAreaLayoutGuideTop)?.offset()(44)
                make?.left.equalTo()(v.mas_safeAreaLayoutGuideLeft)
                make?.right.equalTo()(v.mas_safeAreaLayoutGuideRight)
            } else {
                make?.bottom.equalTo()(v.mas_top)?.offset()(44)
                make?.left.equalTo()(v.mas_left)
                make?.right.equalTo()(v.mas_right)
            }
        }
        self.cameraChangeButton.mas_makeConstraints{ make in
            make?.bottom.equalTo()(topContainerBar.mas_bottom)?.offset()
            make?.right.equalTo()(topContainerBar.mas_right)?.offset()(-20)
            make?.height.and()?.width().equalTo()(44)
        }
        
        self.gridButton.mas_makeConstraints{ make in
            make?.bottom.equalTo()(topContainerBar.mas_bottom)?.offset()
            make?.centerX.equalTo()(topContainerBar.mas_centerX)
            make?.height.and()?.width().equalTo()(44)
        }
        
        self.flashButton.mas_makeConstraints{ make in  make?.bottom.equalTo()(topContainerBar.mas_bottom)
                   make?.left.equalTo()(topContainerBar.mas_left)?.offset()(20)
                   make?.height.and()?.width().equalTo()(44)
        }
        
        self.bottomContainerBar.mas_makeConstraints{ make in
            make?.bottom.equalTo()(v.mas_bottom)
            if #available(iOS 11.0, *) {
                make?.top.equalTo()(v.mas_safeAreaLayoutGuideBottom)?.offset()(-65 - 50)
            } else {
                make?.top.equalTo()(v.mas_bottom)?.offset()(-65 - 50)
            }
            
            make?.left.equalTo()(v.mas_left)
            make?.right.equalTo()(v.mas_right)
        }
        
        self.triggerButton.mas_makeConstraints{ make in
            make?.centerY.equalTo()(self.bottomContainerBar.mas_centerY)
            make?.centerX.equalTo()(v)
            make?.height.equalTo()(66)
            make?.width.equalTo()(66)
        }
        
        self.photoLibraryButton.mas_makeConstraints{ make in
            make?.centerY.equalTo()(self.triggerButton.mas_centerY)
            if #available(iOS 11.0, *) {
                make?.left.equalTo()(v.mas_safeAreaLayoutGuideLeft)?.offset()(20)
            } else {
                make?.left.equalTo()(v.mas_left)?.offset()(20)
            }
            make?.height.and()?.width().equalTo()(44)
        }
        
        self.closeButton.mas_makeConstraints{ make in
            make?.centerY.equalTo()(self.triggerButton.mas_centerY)
            if #available(iOS 11.0, *) {
                make?.right.equalTo()(v.mas_safeAreaLayoutGuideRight)?.offset()(-20)
            } else {
                make?.right.equalTo()(v.mas_right)?.offset()(-20)
            }
            make?.height.equalTo()(44)
            make?.width.equalTo()(44)
        }
        
    }
    
    func padConstants(_ v:UIView){
        
    }
}
