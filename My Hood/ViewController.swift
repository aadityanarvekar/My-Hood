//
//  ViewController.swift
//  My Hood
//
//  Created by AADITYA NARVEKAR on 7/8/16.
//  Copyright © 2016 Aaditya Narvekar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.allowsSelection = false
        
        //Register for postsLoaded notification
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.loadNewData(_:)), name: "postsLoaded", object: nil)
        
        // Load Posts
        DataService.dataInstance.loadPosts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let post = DataService.dataInstance.loadedPosts[indexPath.row]
        if let cell = tableView.dequeueReusableCellWithIdentifier("postCell") as? PostTableViewCell {
            cell.configureCell(post)
            return cell
        } else {
            let cell = PostTableViewCell()
            cell.configureCell(post)
            return cell
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.dataInstance.loadedPosts.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90.0
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    func loadNewData(notification: NSNotification) {
        if case "postsLoaded" = notification.name {
            print("Load new data")
            self.tableView.reloadData()
        }
    }
}

