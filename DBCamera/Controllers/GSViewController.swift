//
//  GSViewController.swift
//  DBCamera
//
//  Created by a on 2019/9/29.
//  Copyright © 2019 PSSD - Daniele Bogo. All rights reserved.
//

import UIKit

class GSViewController: DBCameraViewController, DBCameraManagerDelegate {

    required init?(coder: NSCoder) {
        super.init(coder: coder);
        self.selectedTintColor = .red
        self.tintColor = .white
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.selectedTintColor = .red
        self.tintColor = .white
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Do any additional setup after loading the view.
        
    }
    
    func captureImageDidFinish(_ image: UIImage!, withMetadata metadata: [AnyHashable : Any]!) {
        print("拍照成功")
    }
    

    func dismissCamera(_ cameraViewController: Any!) {
        
    }

    func camera(_ cameraViewController: Any!, didFinishWith image: UIImage!, withMetadata metadata: [AnyHashable : Any]!) {
        
    }
    
    private var isUpdateViewConstaints = false;
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(!isUpdateViewConstaints){
            self.updateViewConstraints()
            isUpdateViewConstaints = true
        }
    }
    

}
