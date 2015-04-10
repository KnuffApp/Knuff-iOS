//
//  InfoCloseButton.swift
//  Knuff
//
//  Created by Simon Blommegard on 30/03/15.
//  Copyright (c) 2015 Bowtie. All rights reserved.
//

import UIKit
import pop

enum InfoCloseButtonState {
  case Info
  case Close
}

class InfoCloseButton: UIButton {
  var buttonState: InfoCloseButtonState = InfoCloseButtonState.Info {
    didSet {
    
      if (buttonState == InfoCloseButtonState.Close) {
       
        let infoI1 = UIImageView(image: UIImage(named: "InfoI"))
        let infoI2 = UIImageView(image: UIImage(named: "InfoI"))
        
        infoI1.frame = imageView!.frame
        infoI2.frame = imageView!.frame
        
        addSubview(infoI1)
        addSubview(infoI2)
        
        setImage(nil, forState: UIControlState.Normal)
        
        let infoI1RotateAni = POPSpringAnimation(propertyNamed: kPOPLayerRotation)
        infoI1RotateAni.toValue = M_PI/4
        infoI1RotateAni.completionBlock = {(animation:POPAnimation!, completion:Bool) in

          let infoI1AlphaAni = POPSpringAnimation(propertyNamed: kPOPViewAlpha)
          infoI1AlphaAni.toValue = 0
          infoI1RotateAni.completionBlock = {(animation:POPAnimation!, completion:Bool) in
            infoI1.removeFromSuperview()
            infoI2.removeFromSuperview()
          }

          let infoI2AlphaAni = POPSpringAnimation(propertyNamed: kPOPViewAlpha)
          infoI2AlphaAni.toValue = 0

          infoI1.pop_addAnimation(infoI1AlphaAni, forKey: "alpha")
          infoI2.pop_addAnimation(infoI2AlphaAni, forKey: "alpha")
          
          self.setImage(UIImage(named: "CloseCross"), forState: UIControlState.Normal)
//          self.imageView?.alpha = 0
//
//          let imageViewAlphaAni = POPSpringAnimation(propertyNamed: kPOPViewAlpha)
//          imageViewAlphaAni.toValue = 1
//
//          self.imageView?.pop_addAnimation(imageViewAlphaAni, forKey: "alpha")
        }

        let infoI2RotateAni = POPSpringAnimation(propertyNamed: kPOPLayerRotation)
        infoI2RotateAni.toValue = -M_PI/4
        
        
        infoI1.layer.pop_addAnimation(infoI1RotateAni, forKey: "rotate")
        infoI2.layer.pop_addAnimation(infoI2RotateAni, forKey: "rotate")
      } else {
        self.setImage(UIImage(named: "InfoI"), forState: UIControlState.Normal)
      }
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    let image = UIImage.drawableImage(CGSize(width: 24, height: 24), draw: { size in
      let c = UIGraphicsGetCurrentContext()
      let rect = CGRect(
        x: 0.5,
        y: 0.5,
        width: size.width - 1.0,
        height: size.height - 1.0
      )
      
      UIColor(hex: 0x6DB0F8).set()
      UIBezierPath(ovalInRect: rect).stroke()
    })
    
    setBackgroundImage(image, forState: .Normal)
    setImage(UIImage(named: "InfoI"), forState: .Normal)
    
    addTarget(self, action: "toggle:", forControlEvents: UIControlEvents.TouchUpInside)
  }

  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
    return CGRectContainsPoint(UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(-20, -20, -20, -20)), point)
  }
  
  
  func toggle(sender: InfoCloseButton) -> Void {
    if (buttonState == InfoCloseButtonState.Info) {
      buttonState = InfoCloseButtonState.Close
    } else {
      buttonState = InfoCloseButtonState.Info
    }
  }
}
