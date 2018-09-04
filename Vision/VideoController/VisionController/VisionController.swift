//
//  VisionController.swift
//  Relax-Vision
//
//  Created by Honglin Yi on 8/25/18.
//  Copyright © 2018 henryyi. All rights reserved.
//

import UIKit

protocol VisionDelegate {
    func visionControllerDidPaged()
}

class VisionController: UIViewController {
    var delegate:VisionDelegate?
    lazy var layoutManager:VisionLayoutManager = {
        let manager = VisionLayoutManager()
        manager.downloader = VisionMockDownloader()
        return manager
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(self.scrollView)
        doVideoPlay(index: 0, pageInScroll: 0)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.scrollView.contentInset = .zero//UIEdgeInsetsMake(0, 0, 0, self.view.bounds.width * -1)
        self.scrollView.contentInsetAdjustmentBehavior = .never
    }

    
    //MARK: for Scroll Extension
    var startDragOffset: CGFloat = -100
    var previousOffset: CGFloat = 0
    var scrollRight:Bool = true
    
    lazy var scrollView:UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .white
        let bounds = self.view.bounds
        view.frame = bounds
        view.contentSize = CGSize(width: bounds.width*3, height: bounds.height)
        view.isPagingEnabled = true
        view.delegate = self
        view.addSubview(imageViewOne)
        view.addSubview(imageViewTwo)
        view.addSubview(imageViewThree)
        return view
    }()
    
    lazy var imageViewOne:UIImageView = getImageView(x:0, y:0, imageName: "Image1")
    
    lazy var imageViewTwo:UIImageView = getImageView(x:self.view.bounds.width, y:0, imageName: "Image2")
    
    lazy var imageViewThree:UIImageView = getImageView(x:self.view.bounds.width*2, y:0, imageName: "Image3")
    
    private func getImageView(x:CGFloat, y:CGFloat, imageName:String) -> UIImageView {
        let view = UIImageView()
        let bounds = self.view.bounds
        view.frame = CGRect(x:x, y:y, width: bounds.width, height: bounds.height)
        view.image = UIImage(named: imageName)
        return view
    }
    
    lazy var images:[UIImageView] = {
        var images = [UIImageView]()
        images.append(imageViewOne)
        images.append(imageViewTwo)
        images.append(imageViewThree)
        return images
    }()

    
    //MARK: Player
    func doVideoPlay(index:Int, pageInScroll:Int) {
        let url = layoutManager.getCurrentVideoUrl()
        let imageView = images[pageInScroll]
        _ = images.map { $0.jp_stopPlay() }
        imageView.jp_playVideo(with: url)
    }
    public func pauseVideoPlay(complete:(Bool)->Void) {
        let page = layoutManager.page
        let image = images[page]
        image.jp_playerStatus == .pause ? image.jp_resume() : image.jp_pause()
        complete(image.jp_playerStatus == .pause)
    }
    
}

