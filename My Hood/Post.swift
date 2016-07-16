//
//  Post.swift
//  My Hood
//
//  Created by AADITYA NARVEKAR on 7/8/16.
//  Copyright © 2016 Aaditya Narvekar. All rights reserved.
//

import Foundation

class Post: NSObject, NSCoding {
    
    let POST_TITLE = "postTitle"
    let POST_DESCRIPTION = "postDescription"
    let POST_IMAGE = "postImage"
    
    
    private var _imagePath: String
    var imagePath: String {
        get {
            return _imagePath
        }
        set {
            if newValue.characters.count > 0 {
                _imagePath = newValue
            }
        }
    }
    
    private var _title: String
    var title: String {
        get {
            return _title
        }
        set {
            if newValue.characters.count > 0 {
                _title = newValue
            }
        }
    }
    
    private var _description: String
    var postDescription: String {
        get {
            return _description
        }
        set {
            if newValue.characters.count > 0 {
                _description = newValue
            }
        }
    }
    
    init(title: String, desc: String, imgPath: String) {
        _title = title
        _description = desc
        _imagePath = imgPath
    }
    
    convenience init(title: String, description: String) {
        self.init(title: title, desc: description, imgPath: "")
    }
    
    required init(coder aDecoder: NSCoder) {
        self._title = (aDecoder.decodeObjectForKey(POST_TITLE) as? String)!
        self._description = (aDecoder.decodeObjectForKey(POST_DESCRIPTION) as? String)!
        self._imagePath = (aDecoder.decodeObjectForKey(POST_IMAGE) as? String)!
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(_title, forKey: POST_TITLE)
        aCoder.encodeObject(_description, forKey: POST_DESCRIPTION)
        aCoder.encodeObject(_imagePath, forKey: POST_IMAGE)
    }
    
    
}
