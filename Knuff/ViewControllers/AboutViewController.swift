//
//  AboutViewController.swift
//  Knuff
//
//  Created by Simon Blommegard on 06/04/15.
//  Copyright (c) 2015 Bowtie. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  var tableView: UITableView?
  let tableContent: [Dictionary<String, String>]
  
  convenience init() {
    self.init(nibName: nil, bundle: nil)
  }
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    tableContent = [
      [
        "title": "Knuff Composer in Mac App Store",
        "link": "http://madebybowtie.com",
      ],
      [
        "title": "Download Knuff Composer from Github",
        "link": "http://github.com/madebybowtie",
      ],
      [
        "title": "Visit the developer website",
        "link": "http://github.com/madebybowtie",
      ],
      [
        "title": "View source on Github",
        "link": "http://github.com/madebybowtie",
      ]
    ]
    
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView = UITableView(frame: view.bounds, style: .Grouped)
    tableView?.autoresizingMask = .FlexibleWidth | .FlexibleHeight
    tableView?.delegate = self
    tableView?.dataSource = self
    tableView?.registerClass(AboutCell.self, forCellReuseIdentifier: "lol")
    
    tableView?.tableFooterView
    
    tableView?.backgroundColor = UIColor(hex: 0x1F3141)
    tableView?.separatorColor = UIColor(hex: 0xF7F9FC, alpha: 0.2)
    
    let headerView = AboutTableHeaderView(frame: CGRectZero)
    headerView.sizeToFit()
    tableView?.tableHeaderView = headerView

    let footerView = AboutTableFooterView(frame: CGRectZero)
    footerView.sizeToFit()
    tableView?.tableFooterView = footerView
    
    view.addSubview(tableView!)
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    println(self.topLayoutGuide.length)
  }
  
  // MARK: - UITableViewDataSource
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableContent.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("lol", forIndexPath: indexPath) as! AboutCell
    
    cell.textLabel?.text = tableContent[indexPath.row]["title"]
    
    return cell
  }
  
  // MARK: - UITableViewDelegate
 
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let link = tableContent[indexPath.row]["link"]
    
    UIApplication.sharedApplication().openURL(NSURL(string: link!)!)
    
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
  
  func tableView(tableView: UITableView, accessoryTypeForRowWithIndexPath indexPath: NSIndexPath!) -> UITableViewCellAccessoryType {
    return .DisclosureIndicator
  }
  
}
