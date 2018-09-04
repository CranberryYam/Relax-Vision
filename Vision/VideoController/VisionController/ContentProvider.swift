//
//  VisionLayoutManager.swift
//  Relax-Vision
//
//  Created by Honglin Yi on 9/3/18.
//  Copyright © 2018 henryyi. All rights reserved.
//

class VisionLayoutManager {
    var downloader:VisionDownloader?
    var isLoading = false
    
    var index = 0
    var page = 0   //location in scrollview
    private var images:[UIImage]
    private var videos:[URL]
    private var models:[VisionModel]
    
    init() {
        self.images = [#imageLiteral(resourceName: "Image1"), #imageLiteral(resourceName: "Image2"), #imageLiteral(resourceName: "Image3"), #imageLiteral(resourceName: "Image1"), #imageLiteral(resourceName: "Image2")]
        
        let array = ["https://s3.us-east-2.amazonaws.com/test2test.kabaq.io/IMG_2187.MOV", "https://s3.us-east-2.amazonaws.com/test2test.kabaq.io/IMG_2325.MOV", "https://s3.us-east-2.amazonaws.com/test2test.kabaq.io/IMG_3385.MOV", "https://s3.us-east-2.amazonaws.com/test2test.kabaq.io/IMG_4652.MOV", "https://s3.us-east-2.amazonaws.com/test2test.kabaq.io/IMG_2187.MOV"]
        
        self.videos = array.compactMap { URL(string: $0) }
        models = [VisionModel]()
    }
    
    //MARK: Index
    public func increaseIndex() {
        index = index + 1
        if index >= images.count {
            index = images.count
        }
    }
    public func decreaseIndex() {
        index = index - 1
        if index < 0 {
            index = 0
        }
    }
    public func getCount() -> Int {
        return images.count
    }
    
    //MARK: Retrieve Video n Image
    public func getCurrentVideoUrl() -> URL {
        return videos[index]
    }
    public func getNextImage() -> UIImage? {
        guard index+1 < getCount() else {
            return nil
        }
        return images[index+1]
    }
    public func getPreviousImage() -> UIImage? {
        guard index-1 >= 0 else {
            return nil
        }
        return images[index-1]
    }
    
    //MARK: Handle Scroll
    public func handleScroll(isRight:Bool, pageInScroll:Int, doMagic: (Bool)->Void, doVideo: (Int,Int)->Void, scrollView:UIScrollView) {
        page = abs(pageInScroll)
        
        isRight ? increaseIndex() : decreaseIndex()
        if page != 1 && index < images.count && index > 0 {
            doMagic(isRight)
            page = 1
        }
        if index == images.count-1 {
            scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, UIScreen.main.bounds.width * -1)
        }
        doVideo(index, page)
    }
    public func handleScrollToEnd(scrollView:UIScrollView) {
        guard index == 0 || index == getCount()-1 else {return}
        let transition = scrollView.panGestureRecognizer.translation(in: scrollView.superview).x
        
        
//        if index == 0 && transition > 0 {
//            guard !isLoading else {return}
//            isLoading = true
//            downloader?.loadNew { models in
//                isLoading = false
//            }
//            return
//        }
//
//        if index == getCount()-1 && transition < 0 {
//            guard !isLoading else {return}
//            isLoading = true
//            downloader?.loadNew { models in
//                isLoading = false
//                if models.count > 0 {
//                    scrollView.contentInset = .zero
//                }
//            }
//        }
        
    }
    
    
}

protocol VisionDownloader {
    func loadMore(complete:([VisionModel])->Void)
    func loadNew(complete:([VisionModel])->Void)
}
struct VisionModel {
    let image:String
    let videoUrl:URL
}

class VisionMockDownloader: VisionDownloader {
    func loadMore(complete: ([VisionModel]) -> Void) {
        
    }
    
    func loadNew(complete: ([VisionModel]) -> Void) {
        
    }
    
    
}

