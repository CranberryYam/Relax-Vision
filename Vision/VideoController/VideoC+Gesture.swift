//
//  VisionC+Gesture.swift
//  Relax-Vision
//
//  Created by Honglin Yi on 9/2/18.
//  Copyright © 2018 henryyi. All rights reserved.
//

import UIKit

extension VideoController:UIGestureRecognizerDelegate {
    
    func addGesture(view: UIView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapGesture.delegate = self
        tapGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGesture)
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTapGesture.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTapGesture)
        
        tapGesture.require(toFail: doubleTapGesture)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        view.addGestureRecognizer(longPressGesture)
    }
    @objc func handleTap(gestureRecognize: UITapGestureRecognizer) {
        visionController.pauseVideoPlay() { pause in
            guard pause else {
                playerButton.hyAnimateClickScale() {
                    self.playerButton.isHidden = true
                }
                return
            }
            playerButton.isHidden = false
            playerButton.hyAnimateClickScale()
        }
        
    }
    @objc func handleDoubleTap(gestureRecognize: UITapGestureRecognizer) {
        print("double tap")
    }
    @objc func handleLongPress(gestureRecognize: UILongPressGestureRecognizer) {
        guard gestureRecognize.state == .began else {
            return
        }
        print("long press")
    }
}
