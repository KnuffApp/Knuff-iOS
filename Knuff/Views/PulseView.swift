//
//  PulseView.swift
//  Knuff
//
//  Created by Simon Blommegard on 01/04/15.
//  Copyright (c) 2015 Bowtie. All rights reserved.
//

import UIKit
import pop

enum PulseViewState {
  case Success
  case Failure
}

class PulseView: UIView {
  
  let state: PulseViewState
  
  let badgeView: UIImageView
  let badgeDetailsView: UIImageView
  
  init(state: PulseViewState) {
    self.state = state
    
    badgeView = UIImageView(image: UIImage(named: "BlueBadge"))
    badgeDetailsView = UIImageView(image: UIImage(named: (state == PulseViewState.Success) ? "Check" : "Cross"))
    
    super.init(frame: CGRectZero)
    
    addSubview(badgeView)
    addSubview(badgeDetailsView)
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func sizeThatFits(size: CGSize) -> CGSize {
    if (state == PulseViewState.Success) {
      return CGSizeMake(100, 100)
    } else {
      // FailurePulseOuter
      return  CGSizeMake(64, 64)
    }
  }
  
  override func layoutSubviews() {
    badgeView.center = CGPointMake(
      self.bounds.midX,
      self.bounds.midY
    )
    
    badgeDetailsView.center = badgeView.center
  }
  
  func startAnimations() {
    if (state == PulseViewState.Success) {
      animateSuccess(0)
      animateSuccess(0.4)
    } else {
      animateFailure()
    }
  }
  
  func animateSuccess(delay: CFTimeInterval) {
    
    let pulseView = CircleView(frame: CGRectMake(0, 0, 24, 24))
    pulseView.center = badgeView.center
    pulseView.contentMode = UIViewContentMode.Redraw
    
    insertSubview(pulseView, belowSubview: badgeView)
    
    // Bounds
    var animation = POPBasicAnimation(propertyNamed: kPOPViewBounds)
    animation.duration = 2
    animation.toValue = NSValue(CGRect: CGRectMake(0, 0, 100, 100))
    animation.beginTime = CACurrentMediaTime() + delay
    
    animation.timingFunction = CAMediaTimingFunction(controlPoints: 0.2, 0.49, 0.37, 0.9)
    
    animation.completionBlock = {(animation:POPAnimation!, completion:Bool) in
      pulseView.removeFromSuperview()
      
      self.animateSuccess(0)
    }
    
    pulseView.pop_addAnimation(animation, forKey: "bounds")
    
    // Alpha
    animation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
    animation.duration = 2
    animation.toValue = 0
    animation.beginTime = CACurrentMediaTime() + delay
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
    
    pulseView.pop_addAnimation(animation, forKey: "alpha")
  }
  
  
  var failureCircleInnerView, failureCircleOuterView: UIImageView?
  func animateFailure() {
    // Reset
    failureCircleInnerView?.removeFromSuperview()
    failureCircleOuterView?.removeFromSuperview()
    
    failureCircleInnerView = UIImageView(image: UIImage(named: "FailurePulseInner"))
    failureCircleOuterView = UIImageView(image: UIImage(named: "FailurePulseOuter"))
    
    failureCircleInnerView?.center = badgeView.center
    failureCircleOuterView?.center = badgeView.center
    
    addSubview(failureCircleInnerView!)
    addSubview(failureCircleOuterView!)
    
    var animation = POPBasicAnimation(propertyNamed: kPOPLayerRotation)
    animation.duration = 1.5
    animation.toValue = -(M_PI * 2)
    animation.repeatForever = true
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    
    failureCircleInnerView?.layer.pop_addAnimation(animation, forKey: nil)
    
    animation = POPBasicAnimation(propertyNamed: kPOPLayerRotation)
    animation.duration = 1.2
    animation.toValue = M_PI * 2
    animation.repeatForever = true
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    
    failureCircleOuterView?.layer.pop_addAnimation(animation, forKey: nil)
  }
}
