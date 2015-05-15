//
//  SentMemesTableViewController.swift
//  imagePicker
//
//  Created by Bronson, Jason on 4/25/15.
//  Copyright (c) 2015 Bronson, Jason. All rights reserved.
//
import Foundation
import UIKit

class SentMemesTableViewController: UITableViewController, UITableViewDataSource {

    @IBAction func addButton(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("ViewController") as! UIViewController
        self.presentViewController(vc, animated:true, completion:nil)
    }
    
    var memes: [Meme]!
    var appDelegate: AppDelegate!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = appDelegate.memes
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = appDelegate.memes
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }


   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return memes.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeTableViewCell", forIndexPath: indexPath) as! UITableViewCell
        let memeCell = self.memes[indexPath.row]

        // Configure the cell...
        cell.imageView?.image = memeCell.memedImage
        cell.textLabel?.text = memeCell.top
        cell.detailTextLabel?.text = memeCell.bottom

        return cell
    }
   
    override func tableView(tableView:UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("memeDetailViewController") as! memeDetailViewController
        detailController.meme = self.memes[indexPath.row]
        
        
        self.navigationController!.pushViewController(detailController, animated: true)
        
       
        
        self.navigationController?.setToolbarHidden(true, animated: true)
    }

}
