//
//  UIColorExtensions.swift
//  Knuff
//
//  Created by Simon Blommegard on 26/03/15.
//  Copyright (c) 2015 Bowtie. All rights reserved.
//

import UIKit
import pop

class PushIllustrationView: UIView {
  
  let mac, device, bubble, arrow1, arrow2, arrow3 : UIImageView
  
  override init(frame: CGRect) {
    mac = UIImageView(image: UIImage(named: "Mac"))
    device = UIImageView(image: UIImage(named: "Phone"))
    bubble = UIImageView(image: UIImage(named: "Bubble"))
    arrow1 = UIImageView(image: UIImage(named: "Arrow1"))
    arrow2 = UIImageView(image: UIImage(named: "Arrow2"))
    arrow3 = UIImageView(image: UIImage(named: "Arrow3"))

    super.init(frame: frame)
    
    device.frame = CGRectMake(175, 14, device.frame.width, device.frame.height)
    bubble.frame = CGRectMake(209, 0, bubble.frame.width, bubble.frame.height)
    arrow1.frame = CGRectMake(150, 34, arrow1.frame.width, arrow1.frame.height)
    arrow2.frame = CGRectMake(156, 31, arrow2.frame.width, arrow2.frame.height)
    arrow3.frame = CGRectMake(163, 28, arrow3.frame.width, arrow3.frame.height)
    
    addSubview(mac)
    addSubview(device)
    addSubview(bubble)
    addSubview(arrow1)
    addSubview(arrow2)
    addSubview(arrow3)
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    
    if (superview != nil) {
      startAnimations(0)
    } else {
      arrow1.pop_removeAllAnimations()
      arrow2.pop_removeAllAnimations()
      arrow3.pop_removeAllAnimations()
      bubble.pop_removeAllAnimations()
    }
  }

  override func sizeThatFits(size: CGSize) -> CGSize {
    return CGSizeMake(
      233, // dont use self.bubble.frame.maxX, we have scaled the bubble and therefore messed with its frame
      self.mac.frame.maxY
    )
  }
  
  override func intrinsicContentSize() -> CGSize {
    return sizeThatFits(bounds.size);
  }
  
  override func layoutSubviews() {}
  
  func startAnimations(delay:CFTimeInterval) {
    animate(arrow1, delay: delay)
    animate(arrow2, delay: delay + 0.1)
    animate(arrow3, delay: delay + 0.2)
    animate(bubble, delay: delay + 0.6)
  }
  
  func animate(view: UIView, delay:CFTimeInterval) {
    let visibleTime: CFTimeInterval = 2;
    let hiddenTime: CFTimeInterval = 1;
    
    view.alpha = 0
    view.transform = CGAffineTransformMakeScale(0.8, 0.8)
    view.pop_removeAllAnimations()
    
    // Appear
    var alphaAni = POPSpringAnimation(propertyNamed: kPOPViewAlpha)
    alphaAni.toValue = 1
    alphaAni.beginTime = delay + CACurrentMediaTime()
    
    var scaleAni = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
    scaleAni.toValue = NSValue(CGPoint: CGPointMake(1, 1))
    scaleAni.beginTime = delay + CACurrentMediaTime()
    scaleAni.springBounciness = 15;
    
    
    alphaAni.completionBlock = { (animation:POPAnimation!, completion:Bool!) -> Void in
      
      // Dissapear
      alphaAni = POPSpringAnimation(propertyNamed: kPOPViewAlpha)
      alphaAni.toValue = 0
      alphaAni.beginTime = CACurrentMediaTime() + visibleTime
    
      scaleAni = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
      scaleAni.toValue = NSValue(CGPoint: CGPointMake(0.8, 0.8))
      scaleAni.beginTime = CACurrentMediaTime() + visibleTime
      scaleAni.springBounciness = 15;

      view.pop_addAnimation(alphaAni, forKey: "alpha")
      view.pop_addAnimation(scaleAni, forKey: "scale")
      
      // Restart, kind of ugly, but they get out of sync if we dont restart them at the same time
      if (view == self.bubble) {
        alphaAni.completionBlock = { (animation:POPAnimation!, completion:Bool!) -> Void in
          self.startAnimations(hiddenTime)
        }
      }
    }
    
    view.pop_addAnimation(alphaAni, forKey: "alpha")
    view.pop_addAnimation(scaleAni, forKey: "scale")
  }
  
}
