//
//  GSViewController.swift
//  DBCamera
//
//  Created by a on 2019/9/29.
//  Copyright © 2019 PSSD - Daniele Bogo. All rights reserved.
//

import UIKit

class GSViewController: DBCameraContainerViewController, DBCameraViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        // Do any additional setup after loading the view.
        
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
