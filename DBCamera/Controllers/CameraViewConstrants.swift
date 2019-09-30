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
            make?.top.equalTo()(vc.view.mas_safeAreaLayoutGuideTop)
            make?.bottom.equalTo()(vc.view.mas_safeAreaLayoutGuideBottom)
            make?.left.equalTo()(vc.view.mas_safeAreaLayoutGuideLeft)
            make?.right.equalTo()(vc.view.mas_safeAreaLayoutGuideRight)
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
            make?.bottom.equalTo()(v.mas_safeAreaLayoutGuideTop)?.offset()(65)
            make?.left.equalTo()(v.mas_safeAreaLayoutGuideLeft)
            make?.right.equalTo()(v.mas_safeAreaLayoutGuideRight)
        }
        self.cameraButton.mas_makeConstraints{ make in
            make?.bottom.equalTo()(topContainerBar.mas_bottom)?.offset()(-10)
            make?.left.equalTo()(topContainerBar.mas_left)?.offset()(20)
            make?.height.and()?.width().equalTo()(44)
        }
        
        self.gridButton.mas_makeConstraints{ make in
            make?.bottom.equalTo()(topContainerBar.mas_bottom)?.offset()(-10)
            make?.centerX.equalTo()(topContainerBar.mas_centerX)
            make?.height.and()?.width().equalTo()(44)
        }
        
        self.flashButton.mas_makeConstraints{ make in
            make?.bottom.equalTo()(topContainerBar.mas_bottom)?.offset()(-10)
            make?.right.equalTo()(topContainerBar.mas_right)?.offset()(-20)
            make?.height.and()?.width().equalTo()(44)
        }
        
        self.bottomContainerBar.mas_makeConstraints{ make in
            make?.bottom.equalTo()(v.mas_bottom)
            make?.top.equalTo()(v.mas_safeAreaLayoutGuideBottom)?.offset()(-65 - 50)
            
            make?.left.equalTo()(v.mas_left)
            make?.right.equalTo()(v.mas_right)
        }
        
        self.photoLibraryButton.mas_makeConstraints{ make in
            make?.bottom.equalTo()(v.mas_safeAreaLayoutGuideBottom)?.offset()(-11)
            make?.left.equalTo()(v.mas_safeAreaLayoutGuideLeft)?.offset()(20)
            make?.height.and()?.width().equalTo()(44)
        }
        self.triggerButton.mas_makeConstraints{ make in
            make?.bottom.equalTo()(v.mas_safeAreaLayoutGuideBottom)?.offset()(-1)
            make?.centerX.equalTo()(v)
            make?.height.equalTo()(66)
            make?.width.equalTo()(66)
        }
        
        self.closeButton.mas_makeConstraints{ make in
            make?.bottom.equalTo()(v.mas_safeAreaLayoutGuideBottom)?.offset()(-11)
            make?.right.equalTo()(v.mas_safeAreaLayoutGuideRight)?.offset()(-20)
            make?.height.equalTo()(44)
            make?.width.equalTo()(44)
        }
        
        self.preViewContainer.mas_makeConstraints{ make in
            make?.bottom.equalTo()(v.mas_safeAreaLayoutGuideBottom)
            make?.left.equalTo()(v.mas_safeAreaLayoutGuideLeft)
            make?.right.equalTo()(v.mas_safeAreaLayoutGuideRight)
            make?.top.equalTo()(v.mas_safeAreaLayoutGuideBottom)
        }
    }
    
    func padConstants(_ v:UIView){
        self.topContainerBar.mas_makeConstraints{ make in
            make?.top.equalTo()(v.mas_top)
            make?.bottom.equalTo()(v.mas_safeAreaLayoutGuideTop)?.offset()(65)
            make?.left.equalTo()(v.mas_safeAreaLayoutGuideLeft)
            make?.right.equalTo()(v.mas_safeAreaLayoutGuideRight)
        }
        self.cameraButton.mas_makeConstraints{ make in
            make?.bottom.equalTo()(topContainerBar.mas_bottom)?.offset()(-10)
            make?.left.equalTo()(topContainerBar.mas_left)?.offset()(20)
            make?.height.and()?.width().equalTo()(44)
        }
        
        self.gridButton.mas_makeConstraints{ make in
            make?.bottom.equalTo()(topContainerBar.mas_bottom)?.offset()(-10)
            make?.centerX.equalTo()(topContainerBar.mas_centerX)
            make?.height.and()?.width().equalTo()(44)
        }
        
        self.flashButton.mas_makeConstraints{ make in
            make?.bottom.equalTo()(topContainerBar.mas_bottom)?.offset()(-10)
            make?.right.equalTo()(topContainerBar.mas_right)?.offset()(-20)
            make?.height.and()?.width().equalTo()(44)
        }
        
        self.bottomContainerBar.mas_makeConstraints{ make in
            make?.bottom.equalTo()(v.mas_bottom)
            make?.top.equalTo()(v.mas_safeAreaLayoutGuideBottom)?.offset()(-65)
            
            make?.left.equalTo()(v.mas_left)
            make?.right.equalTo()(v.mas_right)
        }
        
        self.photoLibraryButton.mas_makeConstraints{ make in
            make?.bottom.equalTo()(v.mas_safeAreaLayoutGuideBottom)?.offset()(-11)
            make?.left.equalTo()(v.mas_safeAreaLayoutGuideLeft)?.offset()(20)
            make?.height.and()?.width().equalTo()(44)
        }
        self.triggerButton.mas_makeConstraints{ make in
            make?.bottom.equalTo()(v.mas_safeAreaLayoutGuideBottom)?.offset()(-1)
            make?.centerX.equalTo()(v)
            make?.height.equalTo()(66)
            make?.width.equalTo()(66)
        }
        
        self.closeButton.mas_makeConstraints{ make in
            make?.bottom.equalTo()(v.mas_safeAreaLayoutGuideBottom)?.offset()(-11)
            make?.right.equalTo()(v.mas_safeAreaLayoutGuideRight)?.offset()(-20)
            make?.height.equalTo()(44)
            make?.width.equalTo()(44)
        }
        
        self.preViewContainer.mas_makeConstraints{ make in
            make?.bottom.equalTo()(v.mas_safeAreaLayoutGuideBottom)
            make?.left.equalTo()(v.mas_safeAreaLayoutGuideLeft)
            make?.right.equalTo()(v.mas_safeAreaLayoutGuideRight)
            make?.top.equalTo()(v.mas_safeAreaLayoutGuideBottom)
        }
    }
}
