//
//  Button.swift
//  Knuff
//
//  Created by Simon Blommegård on 2017-11-14.
//  Copyright © 2017 Bowtie. All rights reserved.
//

import UIKit

class Button: UIButton {
  
  // There should be a valid traitCollection here
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    
    let image: UIImage
    
    if (traitCollection.horizontalSizeClass == .compact) {
      image = UIImage.drawableImage(CGSize(width: 1, height: 59),
                                    draw: { size in
                                      UIColor(hex: 0x6DB0F8, alpha: 0.4).set()
                                      UIRectFill(CGRect(x: 0, y: 0, width: 1, height: 1/UIScreen.main.nativeScale))
      })
    } else {
      image = UIImage.drawableImage(CGSize(width: 248, height: 50),
                                    draw: { size in
                                      let rect = CGRect(
                                        x: 0.5,
                                        y: 0.5,
                                        width: size.width - 1.0,
                                        height: size.height - 1.0
                                      )
                                      UIColor(hex: 0x6DB0F8).set()
                                      UIBezierPath(roundedRect: rect, cornerRadius: 6).stroke()
      })
    }
    
    setBackgroundImage(image, for: .normal)
  }
}
