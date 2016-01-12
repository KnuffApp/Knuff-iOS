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
    titleLabel.sizeToFit()
    addSubview(titleLabel)
    
    descriptionLabel.text = "Knuff is mainly a debug tool for iOS and Mac developers to test push notifications without a need for a proper backend. This Knuff companion app makes it even easier to test pushes with no hazzle at all. Knuff is by heart open sourced."
    descriptionLabel.font = UIFont(name: "OpenSans-Light", size: 12)
    descriptionLabel.textColor = UIColor(hex: 0xF7F9FC)
    descriptionLabel.numberOfLines = 0
    descriptionLabel.bounds.size = descriptionLabel.sizeThatFits(CGSize(width: 300, height: CGFloat.max))
    descriptionLabel.textAlignment = .Center
    
    addSubview(descriptionLabel)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func sizeThatFits(size: CGSize) -> CGSize {
    return CGSize(
      width: max(logoImageView.bounds.width, titleLabel.bounds.width, descriptionLabel.bounds.width),
      height: 20 + logoImageView.bounds.height + 20 + titleLabel.bounds.height + 20 + descriptionLabel.bounds.height + 20
    )
  }
  
  override func layoutSubviews() {
    
    logoImageView.frame.origin = CGPoint(
      x: round((bounds.width/2) - (logoImageView.bounds.width/2)),
      y: 20
    )
    
    titleLabel.frame.origin = CGPoint(
      x: round((bounds.width/2) - (titleLabel.bounds.width/2)),
      y: logoImageView.frame.maxY + 20
    )
    
    descriptionLabel.frame.origin = CGPoint(
      x: round((bounds.width/2) - (descriptionLabel.bounds.width/2)),
      y: titleLabel.frame.maxY + 20
    )
  }
}
