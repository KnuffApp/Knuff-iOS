//
//  FailureView.swift
//  Knuff
//
//  Created by Simon Blommegard on 02/04/15.
//  Copyright (c) 2015 Bowtie. All rights reserved.
//

import UIKit
import Snap

class FailureView: UIView {
  
  let titleLabel: UILabel
  let pulseView: DevicePulseView
  let infoTitleLabel: UILabel
  let infoLabel: UILabel
  
  override init(frame: CGRect) {
    titleLabel = UILabel()
    pulseView = DevicePulseView(state: PulseViewState.Failure)
    infoTitleLabel = UILabel()
    infoLabel = UILabel()
    
    super.init(frame: frame)
    
    titleLabel.text = "Couldn't get a device token."
    titleLabel.font = UIFont(name: "OpenSans-Bold", size: 18)
    titleLabel.textColor = UIColor(hex: 0xF7F9FC, alpha: 1)
    addSubview(titleLabel)
    
    addSubview(pulseView)
    
    infoTitleLabel.text = "Allow Knuff to send notifications to you."
    infoTitleLabel.font = UIFont(name: "OpenSans", size: 12)
    infoTitleLabel.textColor = UIColor(hex: 0xF7F9FC, alpha: 1)
    addSubview(infoTitleLabel)
    
    infoLabel.text = "To recieve push notifications from your computer you need to allow Knuff to recieve them. Allow notifications:\n\nSettings → Notifications → Knuff"
    infoLabel.font = UIFont(name: "OpenSans-Light", size: 12)
    infoLabel.textColor = UIColor(white: 1, alpha: 1)
    infoLabel.textAlignment = NSTextAlignment.Center
    infoLabel.numberOfLines = 0
    infoLabel.preferredMaxLayoutWidth = 300
    addSubview(infoLabel)
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func updateConstraints() {
    super.updateConstraints()
    
    titleLabel.snp_remakeConstraints({ make in
      make.top.centerX.equalTo(self)
      make.right.lessThanOrEqualTo(self)
    })
    
    pulseView.snp_remakeConstraints({ make in
      make.top.equalTo(self.titleLabel.snp_bottom).offset(20)
      make.centerX.equalTo(self)
      make.right.lessThanOrEqualTo(self)
    })
    
    infoTitleLabel.snp_remakeConstraints({ make in
      make.top.equalTo(self.pulseView.snp_bottom).offset(20)
      make.centerX.equalTo(self)
      make.right.lessThanOrEqualTo(self)
    })
    
    infoLabel.snp_remakeConstraints({ make in
      make.top.equalTo(self.infoTitleLabel.snp_bottom).offset(20)
      make.bottom.centerX.equalTo(self)
      make.right.lessThanOrEqualTo(self)
    })
  }
}
