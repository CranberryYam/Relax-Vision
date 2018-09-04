//
//  File.swift
//  RelaxApp3
//
//  Created by Honglin Yi on 3/11/18.
//  Copyright © 2018 henryyi. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    
    /**
     make the object move up and down
    */
    public func hyAnimateUpnDown(duration:TimeInterval = 1,
                               delay:TimeInterval = 0.3,
                               jumpRate:CGFloat = 0.2) {
        let frame = self.frame
        let jumpDistance = frame.height * jumpRate
        
        self.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: frame.height)
        UIView.animate(withDuration: duration, delay:delay,
                       //                       usingSpringWithDamping: 0,
            //                       initialSpringVelocity: 0,
            options: [.repeat, .autoreverse],
            animations: {
                self.frame = CGRect(x: frame.minX, y: frame.minY-jumpDistance, width: frame.width, height: frame.height)
        }, completion:{ finished in
            //self.frame = frame
        })
    }
    
    /**
     when use in UIButton, change button type to Custome
     */
    public func hyAnimateClickScale(duration:TimeInterval = 0.4,
                                  delay:TimeInterval = 0,
                                  scaleRatio:CGFloat = 0.9,
                                  dampingRatio:CGFloat = 0.2,
                                  velocity:CGFloat = 4) {
        self.transform = CGAffineTransform.identity
                         .scaledBy(x: scaleRatio, y: scaleRatio)
        UIView.animate(withDuration: duration, delay:delay,
                       usingSpringWithDamping: dampingRatio,
                       initialSpringVelocity: velocity,
                       options: [.allowUserInteraction, .curveEaseIn, /*.autoreverse*/],
                       animations: {
                        self.transform = CGAffineTransform.identity
                        
        }, completion:{ finished in
            self.transform = CGAffineTransform.identity
        })
    }
    
    public func hyAnimateClickScale(duration:TimeInterval = 0.4,
                                    delay:TimeInterval = 0,
                                    scaleRatio:CGFloat = 0.9,
                                    dampingRatio:CGFloat = 0.2,
                                    velocity:CGFloat = 4,
                                    complete:@escaping ()->Void) {
        self.transform = CGAffineTransform.identity
            .scaledBy(x: scaleRatio, y: scaleRatio)
        UIView.animate(withDuration: duration, delay:delay,
                       usingSpringWithDamping: dampingRatio,
                       initialSpringVelocity: velocity,
                       options: [.allowUserInteraction, .curveEaseIn, /*.autoreverse*/],
                       animations: {
                        self.transform = CGAffineTransform.identity
                        
        }, completion:{ finished in
            self.transform = CGAffineTransform.identity
            complete()
        })
    }
    
    /**
      slowly shrink the UIImage in 4 seconds
    */
    public func hyAnimateShrink(duration:TimeInterval = 4.0,
                              delay:TimeInterval = 0,
                              scaleRatio:CGFloat = 1.3) {
        self.transform = CGAffineTransform.identity
                         .scaledBy(x: scaleRatio, y: scaleRatio)
        
        UIView.animate(withDuration: 4.0, delay:0,options: [.allowUserInteraction], animations: {
            self.layer.anchorPoint = CGPoint.init(x: 0.5, y: 0.5)
            self.transform = CGAffineTransform.identity
        },completion:{ finished in
            self.layer.anchorPoint = CGPoint.init(x: 0.5, y: 0.5)
            self.transform = CGAffineTransform.identity
        })
        
    }
}
