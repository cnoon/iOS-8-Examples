//
//  AppleNavBarViewController.swift
//  Collapsing Nav
//
//  Created by Christian Noon on 2/8/15.
//  Copyright (c) 2015 Noondev. All rights reserved.
//

import UIKit

class AppleNavBarViewController: UIViewController {
    
    lazy var tableView = UITableView()
    
    let CellIdentifier = "UITableViewCell"
    
    // MARK: View Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpInstanceProperties()
        setUpView()
        setUpTableView()
        setUpNavigationBar()
    }
    
    // MARK: Private - Set Up Methods
    
    private func setUpInstanceProperties() {
        self.title = "Default Apple Collapsing"
        self.navigationController?.hidesBarsOnSwipe = true
    }
    
    private func setUpView() {
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    private func setUpTableView() {
        self.tableView.backgroundColor = UIColor.whiteColor()
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        self.tableView.separatorColor = UIColor.whiteColor()
        self.tableView.allowsSelection = false
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: self.CellIdentifier)
        
        self.view.addSubview(self.tableView)
        
        self.tableView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        self.tableView.frame = self.view.bounds
    }
    
    private func setUpNavigationBar() {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "doneBarButtonItemTapped")
        barButtonItem.style = .Done
        barButtonItem.tintColor = UIColor.whiteColor()
        
        self.navigationItem.rightBarButtonItem = barButtonItem
    }
    
    // MARK: Private - UIBarButtonItem Callback Methods
    
    @objc private func doneBarButtonItemTapped() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

// MARK: - UITableViewDataSource

extension AppleNavBarViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(self.CellIdentifier, forIndexPath: indexPath) as UITableViewCell
        cell.contentView.backgroundColor = randomColor()
        
        return cell
    }
    
    private func randomColor() -> UIColor {
        let red = CGFloat(arc4random() % 256) / 255.0
        let green = CGFloat(arc4random() % 256) / 255.0
        let blue = CGFloat(arc4random() % 256) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

// MARK: - UITableViewDelegate

extension AppleNavBarViewController : UITableViewDelegate {
    var cellHeight: CGFloat { return 120.0 }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.cellHeight
    }
}
