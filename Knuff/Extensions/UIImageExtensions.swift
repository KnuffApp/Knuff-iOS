//
//  UIImageExtensions.swift
//  Knuff
//
//  Created by Simon Blommegard on 10/04/15.
//  Copyright (c) 2015 Bowtie. All rights reserved.
//

import UIKit

extension UIImage {

  class func drawableImage(size: CGSize, draw: CGSize -> Void) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.mainScreen().scale)
    
    draw(size)
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    
    UIGraphicsEndImageContext()
    
    return image
  }
}