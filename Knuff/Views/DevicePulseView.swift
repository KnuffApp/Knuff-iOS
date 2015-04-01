//
//  DevicePulseView.swift
//  Knuff
//
//  Created by Simon Blommegard on 31/03/15.
//  Copyright (c) 2015 Bowtie. All rights reserved.
//

import UIKit
import pop

class DevicePulseView: UIView {
  
  let deviceImageView: UIImageView
  let badgeImageView: UIImageView
  
  override init(frame: CGRect) {
    let phone = (UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone)
    deviceImageView = UIImageView(image: UIImage(named: phone ? "Phone" : "Pad"))
    
    badgeImageView = UIImageView(image: UIImage(named: "PulseCenter"))
    
    super.init(frame: frame)
    
    addSubview(deviceImageView)
    addSubview(badgeImageView)
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func sizeThatFits(size: CGSize) -> CGSize {
    return CGSizeMake(
      deviceImageView.bounds.width + ((50 - 18) * 2),// The (pulse - badge inset)
      deviceImageView.bounds.height + 50 // The pulse
    )
  }
  
  override func intrinsicContentSize() -> CGSize {
    return sizeThatFits(bounds.size);
  }
  
  override func layoutSubviews() {
    deviceImageView.center = CGPointMake(
      self.bounds.midX,
      self.bounds.height - deviceImageView.bounds.midY
    )

    badgeImageView.center = CGPointMake(
      deviceImageView.frame.maxX  - 18,
      deviceImageView.frame.minY
    )
  }
  
  func startAnimations() {
    animate(0)
    animate(0.4)
  }
  
  func animate(delay: CFTimeInterval) {
    
    let pulseView = CircleView(frame: CGRectMake(0, 0, 24, 24))
    pulseView.center = badgeImageView.center
    pulseView.contentMode = UIViewContentMode.Redraw
    
    insertSubview(pulseView, belowSubview: badgeImageView)
    
    // Bounds
    var animation = POPBasicAnimation(propertyNamed: kPOPViewBounds)
    animation.duration = 2
    animation.toValue = NSValue(CGRect: CGRectMake(0, 0, 100, 100))
    animation.beginTime = CACurrentMediaTime() + delay
    
    animation.timingFunction = CAMediaTimingFunction(controlPoints: 0.2, 0.49, 0.37, 0.9)
    
    animation.completionBlock = {(animation:POPAnimation!, completion:Bool) in
      pulseView.removeFromSuperview()
      
      self.animate(0)
    }
    
    pulseView.pop_addAnimation(animation, forKey: "bounds")
    
    
    animation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
    animation.duration = 2
    animation.toValue = 0
    animation.beginTime = CACurrentMediaTime() + delay
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
    
    pulseView.pop_addAnimation(animation, forKey: "alpha2")
  }
  
}