//
//  VisionC+ScrollDelegate.swift
//  Relax-Vision
//
//  Created by Honglin Yi on 9/2/18.
//  Copyright © 2018 henryyi. All rights reserved.
//

import UIKit

extension VisionController: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            moveScrollView()
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
           moveScrollView()
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollViewOffsetOnStartDrag = scrollView.contentOffset.x
    }
    
    private func moveScrollView() {
        guard scrollViewOffsetOnStartDrag != scrollView.contentOffset.x else {
            return
        }
        
        let indexOfPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        let isRight = scrollView.contentOffset.x > scrollViewOffsetOnStartDrag ? true : false
        
        ContentProvider.share.handleScroll(isRight: isRight, pageInScroll: indexOfPage, doMagic: doInfiniteMagic, doVideo: doVideoPlay)
        delegate?.visionControllerDidPaged()
    }
    
    private func doInfiniteMagic(isRight:Bool) {
        var imageViewNext = imageViewThree
        var imageViewPrevious = imageViewOne
        if !isRight {
            imageViewNext = imageViewOne
            imageViewPrevious = imageViewThree
        }
        let referenceSize = scrollView.bounds
        let imageTwo = imageViewTwo.image
        scrollView.contentOffset = CGPoint.init(x: referenceSize.width, y: 0)
        imageViewTwo.image = imageViewNext.image
        imageViewPrevious.image = imageTwo
        if isRight {
            imageViewNext.image = ContentProvider.share.getNextImage()
            return
        }
        imageViewNext.image = ContentProvider.share.getPreviousImage()
    }

}

