//
//  DBRootViewController.swift
//  DBCamera
//
//  Created by a on 2019/10/21.
//  Copyright © 2019 PSSD - Daniele Bogo. All rights reserved.
//

import UIKit


class DBRootViewController: UIViewController, DBCameraViewControllerSettings, DBCameraManagerDelegate, DBCameraControllerProtocol, DBCameraViewDelegate {
    var initialCameraPosition: AVCaptureDevice.Position = .back
    var tintColor: UIColor = .white
    var selectedTintColor: UIColor = .cyan
    var _deviceOrientation:UIDeviceOrientation = .portrait;
    
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

    
    lazy var cameraManager:DBCameraManager = {
        let _cameraManager = DBCameraManager()
        _cameraManager.delegate = self
        return _cameraManager;
    }()
    lazy var cameraGridView:DBCameraGridView = {
        let _cameraGridView = DBCameraGridView(frame: self.view.bounds)
        _cameraGridView.numberOfRows = 2;
        _cameraGridView.numberOfColumns = 2;
        _cameraGridView.alpha = 0;
        
        return _cameraGridView;
    }()
    
    lazy var cameraView:DBCameraView = {
        let _cameraView = DBCameraView.initWith(self.cameraManager.captureSession)
        
        _cameraView?.tintColor = self.tintColor;
        _cameraView?.selectedTintColor = self.selectedTintColor;
        _cameraView?.defaultInterface();
        _cameraView?.delegate = self;
        
        return _cameraView!;
    }()
}
