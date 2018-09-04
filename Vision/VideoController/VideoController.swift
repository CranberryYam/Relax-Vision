//
//  VideoController.swift
//  Relax-Vision
//
//  Created by Honglin Yi on 9/3/18.
//  Copyright © 2018 henryyi. All rights reserved.
//

import UIKit

class VideoController: UIViewController, VisionDelegate {
    
    lazy var visionController:VisionController = {
        let controller = VisionController()
        controller.delegate = self
        return controller
    }()
    
    lazy var playerButton:UIImageView = {
        let button = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        button.image = UIImage(named: "VideoButton")
        button.isHidden = true
        self.view.addSubview(button)
        button.center = self.view.center
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.addChildViewController(visionController)
        visionController.view.frame = self.view.bounds
        self.view.addSubview(visionController.view)
        
        addGesture(view: self.view)
    }
    
    func visionControllerDidPaged() {
        playerButton.isHidden = true
    }

}
