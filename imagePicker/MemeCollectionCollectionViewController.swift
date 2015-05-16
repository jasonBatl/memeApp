//
//  MemeCollectionCollectionViewController.swift
//  imagePicker
//
//  Created by Bronson, Jason on 4/25/15.
//  Copyright (c) 2015 Bronson, Jason. All rights reserved.
//

import UIKit
import Foundation

let reuseIdentifier = "Cell"

class MemeCollectionCollectionViewController: UICollectionViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var appCollectionView: UICollectionView!
    
    @IBAction func addButton(sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("ViewController") as! UIViewController
        self.presentViewController(vc, animated:true, completion:nil)
    }
    
    
    var memes: [Meme]!
        
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
        self.collectionView?.reloadData()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
        
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionMemeCell", forIndexPath: indexPath) as! memeCollectionViewCell
        let meme = self.memes[indexPath.item]
        
        cell.memeImageView.image = meme.memedImage
        cell.memeImageView.sizeToFit()
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("memeDetailViewController") as! memeDetailViewController
        detailController.meme = self.memes[indexPath.item]

        self.navigationController!.pushViewController(detailController, animated: true)
    }

    
}
