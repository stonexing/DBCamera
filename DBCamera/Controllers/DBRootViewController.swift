//
//  DBRootViewController.swift
//  DBCamera
//
//  Created by a on 2019/10/21.
//  Copyright © 2019 PSSD - Daniele Bogo. All rights reserved.
//

import UIKit


class DBRootViewController: DBCameraViewController, DBCameraViewControllerDelegate, DBCameraContainerDelegate {
    func back(fromController: Any!) {
        
    }
    
    func `switch`(fromController: Any!, toController controller: Any!) {
        
    }
    
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        try? self.cameraManager.setupSession(withPreset: AVCaptureSession.Preset.photo.rawValue)
        
        self.view.addSubview(self.cameraView)
        self.cameraView.mas_makeConstraints{ make in
            make?.top.equalTo()(self.view.mas_top)
            make?.bottom.equalTo()(self.view.mas_bottom)
            make?.leading.equalTo()(self.view.mas_leading)
            make?.trailing.equalTo()(self.view.mas_trailing)
        }
        self.cameraView.cameraChangeButton.isEnabled = self.cameraManager.hasMultipleCameras();
        
    }

    
   
   
}
