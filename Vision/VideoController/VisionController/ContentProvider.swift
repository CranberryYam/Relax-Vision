//
//  ContentProvider.swift
//  Relax-Vision
//
//  Created by Honglin Yi on 9/3/18.
//  Copyright © 2018 henryyi. All rights reserved.
//

class ContentProvider {
    static let share = ContentProvider()
    
    var index = 0
    var page = 0   //location in scrollview
    private var images:[UIImage]
    private var videos:[URL]
    
    init() {
        self.images = [#imageLiteral(resourceName: "Image1"), #imageLiteral(resourceName: "Image2"), #imageLiteral(resourceName: "Image3"), #imageLiteral(resourceName: "Image1"), #imageLiteral(resourceName: "Image2")]
        
        let array = ["https://s3.us-east-2.amazonaws.com/test2test.kabaq.io/IMG_2187.MOV", "https://s3.us-east-2.amazonaws.com/test2test.kabaq.io/IMG_2325.MOV", "https://s3.us-east-2.amazonaws.com/test2test.kabaq.io/IMG_3385.MOV", "https://s3.us-east-2.amazonaws.com/test2test.kabaq.io/IMG_4652.MOV", "https://s3.us-east-2.amazonaws.com/test2test.kabaq.io/IMG_2187.MOV", "https://s3.us-east-2.amazonaws.com/test2test.kabaq.io/IMG_2325.MOV"]
        self.videos = array.compactMap { URL(string: $0) }
    }
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
    public func getCurrentVideoUrl() -> URL {
        return videos[index]
    }
    public func getNextImage() -> UIImage? {
        guard index+1 < images.count else {
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
    public func getCount() -> Int {
        return images.count
    }
    
    public func handleScroll(isRight:Bool, pageInScroll:Int, doMagic: (Bool)->Void, doVideo: (Int,Int)->Void) {
        page = abs(pageInScroll)
        
        isRight ? increaseIndex() : decreaseIndex()
        if page != 1 && index < images.count-1 && index > 0 {
            doMagic(isRight)
            page = 1
        }
        doVideo(index, page)
    }
}

