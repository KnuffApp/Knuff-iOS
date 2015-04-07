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
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func updateConstraints() {
    super.updateConstraints()
    
    logoImageView.snp_remakeConstraints({ make in
      make.top.equalTo(self).offset(20)
      make.centerX.equalTo(self)
      make.right.lessThanOrEqualTo(self)
      make.bottom.equalTo(self).offset(-20)
    })
  }
}