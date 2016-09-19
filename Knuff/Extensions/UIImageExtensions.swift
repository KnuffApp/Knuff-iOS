//
//  UIImageExtensions.swift
//  Knuff
//
//  Created by Simon Blommegard on 10/04/15.
//  Copyright (c) 2015 Bowtie. All rights reserved.
//

import UIKit

extension UIImage {

  class func drawableImage(_ size: CGSize, draw: (CGSize) -> Void) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
    
    draw(size)
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    
    UIGraphicsEndImageContext()
    
    return image!
  }
}
