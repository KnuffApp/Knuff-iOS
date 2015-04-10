//
//  AboutTableHeaderView.swift
//  Knuff
//
//  Created by Simon Blommegard on 07/04/15.
//  Copyright (c) 2015 Bowtie. All rights reserved.
//

import UIKit

class AboutTableHeaderView: UIView {
  
  let logoImageView: UIImageView
  let titleLabel, descriptionLabel: UILabel
  
  override init(frame: CGRect) {
    logoImageView = UIImageView(image: UIImage(named: "Logo"))
    titleLabel = UILabel()
    descriptionLabel = UILabel()
    
    super.init(frame: frame)
    
    addSubview(logoImageView)
    
    titleLabel.text = "About Knuff"
    titleLabel.font = UIFont(name: "OpenSans-Bold", size: 18)
    titleLabel.textColor = UIColor(hex: 0xF7F9FC)
    addSubview(titleLabel)
    
    descriptionLabel.text = "Knuff is mainly a debug tool for iOS and Mac developers to test push notifications without a need for a proper backend. This Knuff companion app makes it even easier to test pushes with no hazzle at all. Knuff is by heart open sourced."
    descriptionLabel.font = UIFont(name: "OpenSans-Light", size: 12)
    descriptionLabel.textColor = UIColor(hex: 0xF7F9FC)
    descriptionLabel.numberOfLines = 0
    descriptionLabel.preferredMaxLayoutWidth = 300
    descriptionLabel.textAlignment = .Center
    
    addSubview(descriptionLabel)
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func updateConstraints() {
    super.updateConstraints()
    
    logoImageView.snp_remakeConstraints({ make in
      make.top.equalTo(self).offset(20)
      make.centerX.equalTo(self)
      make.right.lessThanOrEqualTo(self)
    })
    
    titleLabel.snp_remakeConstraints({ make in
      make.top.equalTo(self.logoImageView.snp_bottom).offset(20)
      make.centerX.equalTo(self)
      make.right.lessThanOrEqualTo(self)
    })
    
    descriptionLabel.snp_remakeConstraints({ make in
      make.top.equalTo(self.titleLabel.snp_bottom).offset(20)
      make.centerX.equalTo(self)
      make.right.lessThanOrEqualTo(self)
      make.bottom.equalTo(self).offset(-20)
    })
  }
}
