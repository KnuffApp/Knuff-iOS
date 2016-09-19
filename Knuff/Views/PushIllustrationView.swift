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
  
  let device: DeviceView
  let mac, bubble, arrow1, arrow2, arrow3 : UIImageView
  
  override init(frame: CGRect) {

    mac = UIImageView(image: UIImage(named: "Mac"))
    device = DeviceView()
    bubble = UIImageView(image: UIImage(named: "Bubble"))
    arrow1 = UIImageView(image: UIImage(named: "Arrow1"))
    arrow2 = UIImageView(image: UIImage(named: "Arrow2"))
    arrow3 = UIImageView(image: UIImage(named: "Arrow3"))

    super.init(frame: frame)
    
    let phone = (UIDevice.current.userInterfaceIdiom == .phone)
    
    device.frame.origin = CGPoint(
      x: 175,
      y: phone ? 14 : 2
    )
    bubble.frame.origin = CGPoint(
      x: phone ? 209 : 229,
      y: phone ? 0 : -12
    )
    arrow1.frame.origin = CGPoint(x: 150, y: 34)
    arrow2.frame.origin = CGPoint(x: 156, y: 31)
    arrow3.frame.origin = CGPoint(x: 163, y: 28)
    
    addSubview(mac)
    addSubview(device)
    addSubview(bubble)
    addSubview(arrow1)
    addSubview(arrow2)
    addSubview(arrow3)
  }
  
  required init?(coder aDecoder: NSCoder) {
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
      device.screenshotView.pop_removeAllAnimations()
    }
  }

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    return CGSize(
      width: self.device.frame.maxX,
      height: self.mac.frame.maxY
    )
  }
  
  func startAnimations(_ delay:CFTimeInterval) {
    animate(arrow1, delay: delay)
    animate(arrow2, delay: delay + 0.1)
    animate(arrow3, delay: delay + 0.2)
    animate(bubble, delay: delay + 0.6)
    animateScreenshot(delay + 0.6)
  }
  
  func animate(_ view: UIView, delay:CFTimeInterval) {
    let visibleTime: CFTimeInterval = 2;
    let hiddenTime: CFTimeInterval = 1;
    
    view.alpha = 0
    view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
    view.pop_removeAllAnimations()
    
    // Appear
    var alphaAni = POPSpringAnimation(propertyNamed: kPOPViewAlpha)
    alphaAni?.toValue = 1
    alphaAni?.beginTime = delay + CACurrentMediaTime()
    
    var scaleAni = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
    scaleAni?.toValue = NSValue(cgPoint: CGPoint(x: 1, y: 1))
    scaleAni?.beginTime = delay + CACurrentMediaTime()
    scaleAni?.springBounciness = 15;
    
    
    alphaAni?.completionBlock = { (animation:POPAnimation?, completion:Bool) in
      
      // Dissapear
      alphaAni = POPSpringAnimation(propertyNamed: kPOPViewAlpha)
      alphaAni?.toValue = 0
      alphaAni?.beginTime = CACurrentMediaTime() + visibleTime
    
      scaleAni = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
      scaleAni?.toValue = NSValue(cgPoint: CGPoint(x: 0.8, y: 0.8))
      scaleAni?.beginTime = CACurrentMediaTime() + visibleTime
      scaleAni?.springBounciness = 15;

      view.pop_add(alphaAni, forKey: "alpha")
      view.pop_add(scaleAni, forKey: "scale")
      
      // Restart, kind of ugly, but they get out of sync if we dont restart them at the same time
      if (view == self.bubble) {
        alphaAni?.completionBlock = { (animation:POPAnimation?, completion:Bool) in
          self.startAnimations(hiddenTime)
        }
      }
    }
    
    view.pop_add(alphaAni, forKey: "alpha")
    view.pop_add(scaleAni, forKey: "scale")
  }
  
  func animateScreenshot(_ delay: CFTimeInterval) {
    let visibleTime: CFTimeInterval = 2;
    
    device.screenshotView.alpha = 0
    device.screenshotView.pop_removeAllAnimations()
    
    var alphaAni = POPSpringAnimation(propertyNamed: kPOPViewAlpha)
    alphaAni?.toValue = 1
    alphaAni?.beginTime = delay + CACurrentMediaTime()
    
    alphaAni?.completionBlock = { (animation:POPAnimation?, completion:Bool) in
      alphaAni = POPSpringAnimation(propertyNamed: kPOPViewAlpha)
      alphaAni?.toValue = 0
      alphaAni?.beginTime = CACurrentMediaTime() + visibleTime

      self.device.screenshotView.pop_add(alphaAni, forKey: nil)
    }
    
    device.screenshotView.pop_add(alphaAni, forKey: nil)
  }
}
