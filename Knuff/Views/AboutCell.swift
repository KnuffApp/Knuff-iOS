//
//  AboutCell.swift
//  Knuff
//
//  Created by Simon Blommegard on 06/04/15.
//  Copyright (c) 2015 Bowtie. All rights reserved.
//

import UIKit

class AboutCell: UITableViewCell {
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    backgroundColor = UIColor(hex: 0x1F3141, alpha: 1)
    
    textLabel?.textColor = UIColor(hex: 0xF7F9FC, alpha: 1)
    textLabel?.font = UIFont(name: "OpenSans", size: 12)
    
    let selectedView = UIView()
    selectedView.backgroundColor = UIColor(white: 1, alpha: 0.1)
    
    selectedBackgroundView = selectedView
  }

  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
}
