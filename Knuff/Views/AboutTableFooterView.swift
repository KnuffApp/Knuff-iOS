//
//  AboutTableFooterView.swift
//  Knuff
//
//  Created by Simon Blommegard on 07/04/15.
//  Copyright (c) 2015 Bowtie. All rights reserved.
//

import UIKit

class AboutTableFooterView: UIView {
  
  let logoImageView: UIImageView
  
  override init(frame: CGRect) {
    logoImageView = UIImageView(image: UIImage(named: "BowtieLogo"))
    
    super.init(frame: frame)
    
    addSubview(logoImageView)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func sizeThatFits(_ size: CGSize) -> CGSize {
    return CGSize(
      width: logoImageView.bounds.width,
      height: 20 + logoImageView.bounds.width + 20
    )
  }
  
  override func layoutSubviews() {
    logoImageView.frame.origin = CGPoint(
      x: round((bounds.width/2) - (logoImageView.bounds.width/2)),
      y: 20
    )
  }
}
