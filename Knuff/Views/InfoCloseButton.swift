//
//  InfoCloseButton.swift
//  Knuff
//
//  Created by Simon Blommegard on 30/03/15.
//  Copyright (c) 2015 Bowtie. All rights reserved.
//

import UIKit

enum InfoCloseButtonState {
  case info
  case close
}

class InfoCloseButton: UIButton {
  var buttonState: InfoCloseButtonState = .info {
    didSet {
    
      if (buttonState == .close) {
        setImage(UIImage(named: "CloseCross"), for: .normal)

//        let infoI1 = UIImageView(image: UIImage(named: "InfoI"))
//        let infoI2 = UIImageView(image: UIImage(named: "InfoI"))
//        
//        infoI1.frame = imageView!.frame
//        infoI2.frame = imageView!.frame
//        
//        addSubview(infoI1)
//        addSubview(infoI2)
//        
//        setImage(nil, forState: UIControlState.Normal)
//        
//        let infoI1RotateAni = POPSpringAnimation(propertyNamed: kPOPLayerRotation)
//        infoI1RotateAni.toValue = M_PI/4
//        infoI1RotateAni.completionBlock = {(animation:POPAnimation!, completion:Bool) in
//
//          let infoI1AlphaAni = POPSpringAnimation(propertyNamed: kPOPViewAlpha)
//          infoI1AlphaAni.toValue = 0
//          infoI1RotateAni.completionBlock = {(animation:POPAnimation!, completion:Bool) in
//            infoI1.removeFromSuperview()
//            infoI2.removeFromSuperview()
//          }
//
//          let infoI2AlphaAni = POPSpringAnimation(propertyNamed: kPOPViewAlpha)
//          infoI2AlphaAni.toValue = 0
//
//          infoI1.pop_addAnimation(infoI1AlphaAni, forKey: "alpha")
//          infoI2.pop_addAnimation(infoI2AlphaAni, forKey: "alpha")
//          
//          self.setImage(UIImage(named: "CloseCross"), forState: UIControlState.Normal)
////          self.imageView?.alpha = 0
////
////          let imageViewAlphaAni = POPSpringAnimation(propertyNamed: kPOPViewAlpha)
////          imageViewAlphaAni.toValue = 1
////
////          self.imageView?.pop_addAnimation(imageViewAlphaAni, forKey: "alpha")
//        }
//
//        let infoI2RotateAni = POPSpringAnimation(propertyNamed: kPOPLayerRotation)
//        infoI2RotateAni.toValue = -M_PI/4
//        
//        
//        infoI1.layer.pop_addAnimation(infoI1RotateAni, forKey: "rotate")
//        infoI2.layer.pop_addAnimation(infoI2RotateAni, forKey: "rotate")
      } else {
        setImage(UIImage(named: "InfoI"), for: .normal)
      }
      
      imageView?.layer.add(CATransition(), forKey: nil)
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    let image = UIImage.drawableImage(CGSize(width: 24, height: 24), draw: { size in
      let rect = CGRect(
        x: 0.5,
        y: 0.5,
        width: size.width - 1.0,
        height: size.height - 1.0
      )
      
      UIColor(hex: 0x6DB0F8).set()
      UIBezierPath(ovalIn: rect).stroke()
    })
    
    setBackgroundImage(image, for: .normal)
    setImage(UIImage(named: "InfoI"), for: .normal)
    
    addTarget(self, action: #selector(InfoCloseButton.toggle(_:)), for: UIControlEvents.touchUpInside)
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(-20, -20, -20, -20)).contains(point)
  }
  
  
  func toggle(_ sender: InfoCloseButton) -> Void {
    if (buttonState == .info) {
      buttonState = .close
    } else {
      buttonState = .info
    }
  }
}
