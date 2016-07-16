//
//  PostTableViewCell.swift
//  My Hood
//
//  Created by AADITYA NARVEKAR on 7/9/16.
//  Copyright © 2016 Aaditya Narvekar. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Rounded corners to view
        postImage.layer.cornerRadius = 20
        postImage.layer.masksToBounds = true
    }
    
    func configureCell(post: Post) {
        postTitle.text = post.title
        postDescription.text = post.postDescription
        postImage.image = DataService.dataInstance.imageFromPath(post.imagePath)
    }

}
