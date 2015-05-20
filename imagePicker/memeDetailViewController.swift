//
//  memeDetailViewController.swift
//  imagePicker
//
//  Created by Bronson, Jason on 5/8/15.
//  Copyright (c) 2015 Bronson, Jason. All rights reserved.
//

import UIKit

class memeDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var meme: Meme!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        imageView!.image = meme.memedImage
        tabBarController?.tabBar.hidden = true
        navigationController?.hidesBarsOnTap = true
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        tabBarController?.tabBar.hidden = false
    }


}
