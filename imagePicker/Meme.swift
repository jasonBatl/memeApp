//
//  Meme.swift
//  imagePicker
//
//  Created by Bronson, Jason on 4/17/15.
//  Copyright (c) 2015 Bronson, Jason. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    
        var top: String?
        var bottom: String?
        var pic: UIImage?
        var memedImage: UIImage?
    
    init(top: String, bottom: String, pic: UIImage, memedImage:UIImage){
        self.top = top
        self.bottom = bottom
        self.pic = pic
        self.memedImage = memedImage
    }
    
}
