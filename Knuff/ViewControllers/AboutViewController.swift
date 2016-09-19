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
  var overlayView: GradientView?
  let tableContent: [Dictionary<String, String>]
  
  convenience init() {
    self.init(nibName: nil, bundle: nil)
  }
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    tableContent = [
      [
        "title": "Visit the developer website",
        "link": "http://madebybowtie.com",
      ],
      [
        "title": "View source on Github",
        "link": "http://github.com/knuffapp",
      ]
    ]
    
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView = UITableView(frame: .zero, style: .grouped)
    tableView?.delegate = self
    tableView?.dataSource = self
    tableView?.register(AboutCell.self, forCellReuseIdentifier: "lol")
    
    tableView?.separatorColor = UIColor(hex: 0xF7F9FC, alpha: 0.2)
    tableView?.backgroundColor = UIColor.clear
    
    tableView?.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    
    let headerView = AboutTableHeaderView(frame: CGRect.zero)
    headerView.sizeToFit()
    tableView?.tableHeaderView = headerView

    let footerView = AboutTableFooterView(frame: CGRect.zero)
    footerView.sizeToFit()
    tableView?.tableFooterView = footerView
    
    view.addSubview(tableView!)
    
    overlayView = GradientView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 30))
    overlayView?.autoresizingMask = .flexibleWidth
    view.addSubview(overlayView!)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    if (traitCollection.horizontalSizeClass == .compact) {
      tableView?.frame = view.bounds
    } else {
      tableView?.frame = CGRect(
        x: round((view.bounds.width/2) - (375/2)),
        y: 0,
        width: 375,
        height: view.bounds.height
      )
    }
  }
  
  // MARK: - UITableViewDataSource
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableContent.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "lol", for: indexPath) as! AboutCell
    
    cell.textLabel?.text = tableContent[(indexPath as NSIndexPath).row]["title"]
    
    return cell
  }
  
  // MARK: - UITableViewDelegate
 
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let link = tableContent[(indexPath as NSIndexPath).row]["link"]
    
    UIApplication.shared.openURL(URL(string: link!)!)
    
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
