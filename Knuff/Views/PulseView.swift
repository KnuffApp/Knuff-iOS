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
      firstPulseCircleView = CircleView(frame: CGRect.zeroRect)
      firstPulseCircleView!.center = badgeView.center
      firstPulseCircleView!.contentMode = UIViewContentMode.Redraw
      insertSubview(firstPulseCircleView!, belowSubview: badgeView)
      
      secondPulseCircleView = CircleView(frame: CGRect.zeroRect)
      secondPulseCircleView!.center = badgeView.center
      secondPulseCircleView!.contentMode = UIViewContentMode.Redraw
      insertSubview(secondPulseCircleView!, belowSubview: badgeView)
      
      startAnimateSuccess()
    } else {
      animateFailure()
    }
  }
  
  
  var firstPulseCircleView, secondPulseCircleView: CircleView?

  func startAnimateSuccess() {
    // Reset
    firstPulseCircleView!.bounds = CGRect(x: 0, y: 0, width: 24, height: 24)
    firstPulseCircleView!.alpha = 1
    
    secondPulseCircleView!.bounds = CGRect(x: 0, y: 0, width: 24, height: 24)
    secondPulseCircleView!.alpha = 1
    
    animateSuccess(firstPulseCircleView!, delay: 0)
    animateSuccess(secondPulseCircleView!, delay: 0.4)
  }
  
  func animateSuccess(view: UIView, delay: CFTimeInterval) {
    // Bounds
    var animation = POPBasicAnimation(propertyNamed: kPOPViewBounds)
    animation.duration = 2
    animation.toValue = NSValue(CGRect: CGRectMake(0, 0, 100, 100))
    animation.beginTime = CACurrentMediaTime() + delay
    
    animation.timingFunction = CAMediaTimingFunction(controlPoints: 0.2, 0.49, 0.37, 0.9)
    
    animation.completionBlock = {(animation:POPAnimation!, completion:Bool) in
      if (view == self.secondPulseCircleView) {
        self.startAnimateSuccess()
      }
    }
    
    view.pop_addAnimation(animation, forKey: "bounds")
    
    // Alpha
    animation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
    animation.duration = 2
    animation.toValue = 0
    animation.beginTime = CACurrentMediaTime() + delay
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
    
    view.pop_addAnimation(animation, forKey: "alpha")
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
