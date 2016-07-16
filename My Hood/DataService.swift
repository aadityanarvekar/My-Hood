//
//  DataService.swift
//  My Hood
//
//  Created by AADITYA NARVEKAR on 7/13/16.
//  Copyright © 2016 Aaditya Narvekar. All rights reserved.
//

import Foundation
import UIKit

class DataService {
    static let dataInstance = DataService()
    
    let KEY_POSTS = "posts"
    
    private var _loadedPosts = [Post]()
    var loadedPosts: [Post] {
        return _loadedPosts
    }
    
    func savePosts() {
        let postsData = NSKeyedArchiver.archivedDataWithRootObject(_loadedPosts)
        NSUserDefaults.standardUserDefaults().setObject(postsData, forKey: KEY_POSTS)
    }
    
    func loadPosts()  {
        if let pstData = NSUserDefaults.standardUserDefaults().dataForKey(KEY_POSTS) {
            if let pstArray = NSKeyedUnarchiver.unarchiveObjectWithData(pstData) as? [Post] {
                _loadedPosts = pstArray
            }
        }
        
        // Post notification when new posts are loaded
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "postsLoaded", object: nil))
    }
    
    func saveImageAndCreatePath(img: UIImage) -> String {
        let imgData = UIImagePNGRepresentation(img)
        let imgPath = "image-\(NSDate.timeIntervalSinceReferenceDate()).png"
        let fullPath = documentsPathForFileName(imgPath)
        imgData?.writeToFile(fullPath, atomically: true)
        return fullPath
    }
    
    
    func imageFromPath(path: String) -> UIImage {
        if let img = UIImage(named: path) {
            return img
        }
        
        return UIImage(named: "barrel-water-bridge.png")!
    }
    
    func addPost(pst: Post) {
        _loadedPosts.append(pst)
        savePosts()
        loadPosts()
    }
    
    func documentsPathForFileName(name: String) -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let fullPath = paths[0] as NSString
        return fullPath.stringByAppendingPathComponent(name)
    }
    
}