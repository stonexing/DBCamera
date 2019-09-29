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
       
        self.cameraViewController.updateViewConstraints()
        if let cameraView: DBCameraView = self.cameraViewController.cameraView
        {
            cameraView.updateViewConstraints(self)
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .all
    }
    
    
}

extension DBCameraView {
    open func updateViewConstraints(_ vc:UIViewController) {
        self.mas_makeConstraints { make in
            make?.edges.mas_equalTo()(vc.view)
        }
        
        self.topContainerBar.mas_makeConstraints{ make in
            make?.top.equalTo()(vc.view.mas_top)
            make?.left.equalTo()(vc.view.mas_left)
            make?.right.equalTo()(vc.view.mas_right)
            make?.bottom.equalTo()(vc.view.mas_safeAreaLayoutGuideTop)?.offset()(65)
        }
        
        self.cameraButton.mas_makeConstraints{ make in
            make?.top.equalTo()(vc.view.mas_safeAreaLayoutGuideTop)?.offset()(11)
            make?.left.equalTo()(vc.view.mas_safeAreaLayoutGuideLeft)?.offset()(20)
            make?.height.and()?.width().equalTo()(44)
        }
        
        self.gridButton.mas_makeConstraints{ make in
            make?.top.equalTo()(vc.view.mas_safeAreaLayoutGuideTop)?.offset()(11)
            make?.centerX.equalTo()(vc.view)
            make?.height.and()?.width().equalTo()(44)
        }
        
        self.flashButton.mas_makeConstraints{ make in
            make?.top.equalTo()(vc.view.mas_safeAreaLayoutGuideTop)?.offset()(11)
            make?.right.equalTo()(vc.view.mas_safeAreaLayoutGuideRight)?.offset()(-20)
            make?.height.and()?.width().equalTo()(44)
        }
        
        self.bottomContainerBar.mas_makeConstraints{ make in
            make?.bottom.equalTo()(vc.view.mas_bottom)
            make?.left.equalTo()(vc.view.mas_left)
            make?.right.equalTo()(vc.view.mas_right)
            make?.top.equalTo()(vc.view.mas_safeAreaLayoutGuideBottom)?.offset()(-65)
        }
        
        self.photoLibraryButton.mas_makeConstraints{ make in
            make?.bottom.equalTo()(vc.view.mas_safeAreaLayoutGuideBottom)?.offset()(-11)
            make?.left.equalTo()(vc.view.mas_safeAreaLayoutGuideLeft)?.offset()(20)
            make?.height.and()?.width().equalTo()(44)
        }
        self.triggerButton.mas_makeConstraints{ make in
            make?.bottom.equalTo()(vc.view.mas_safeAreaLayoutGuideBottom)?.offset()(-1)
            make?.centerX.equalTo()(vc.view)
            make?.height.equalTo()(66)
            make?.width.equalTo()(66)
        }
        
        self.closeButton.mas_makeConstraints{ make in
            make?.bottom.equalTo()(vc.view.mas_safeAreaLayoutGuideBottom)?.offset()(-11)
            make?.right.equalTo()(vc.view.mas_safeAreaLayoutGuideRight)?.offset()(-20)
            make?.height.equalTo()(44)
            make?.width.equalTo()(44)
        }
        
        self.preview.mas_makeConstraints{ make in
            make?.bottom.equalTo()(vc.view.mas_safeAreaLayoutGuideBottom)
            make?.left.equalTo()(vc.view.mas_safeAreaLayoutGuideLeft)
            make?.right.equalTo()(vc.view.mas_safeAreaLayoutGuideRight)
            make?.top.equalTo()(vc.view.mas_safeAreaLayoutGuideBottom)
        }
        
        
    }
}
