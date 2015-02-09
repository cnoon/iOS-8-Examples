//
//  CustomNavBarViewController.swift
//  Collapsing Nav
//
//  Created by Christian Noon on 2/8/15.
//  Copyright (c) 2015 Noondev. All rights reserved.
//

import UIKit
import Snap

class CustomNavBarViewController : UIViewController {
    
    var navigationBar: UIView!
    var titleImageView: UIImageView!
    var doneButton: UIButton!
    var tableView: UITableView!
    
    var titleImageSize: CGSize!
    
    let minNavigationBarHeight = 20.0
    let maxNavigationBarHeight = 64.0
    
    var preferredNavigationBarHeight = 64.0
    
    let CellIdentifier = "CellIdentifier"
    
    // MARK: View Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setUpNavigationBar()
        setUpTitleImageView()
        setUpDoneButton()
        setUpTableView()
    }

    // MARK: Constraint Methods
    
    override func updateViewConstraints() {
        let normalizedVisibility = CGFloat(self.preferredNavigationBarHeight - self.minNavigationBarHeight) / CGFloat(self.maxNavigationBarHeight - self.minNavigationBarHeight)
        
        self.navigationBar!.snp_updateConstraints { make in
            make.height.equalTo(self.preferredNavigationBarHeight)
            return
        }
        
        self.titleImageView.snp_updateConstraints { make in
            make.width.equalTo(self.titleImageSize.width * normalizedVisibility)
            make.height.equalTo(self.titleImageSize.height * normalizedVisibility)
        }
        
        self.titleImageView.alpha = normalizedVisibility
        self.doneButton.alpha = normalizedVisibility
        
        super.updateViewConstraints()
    }

    // MARK: Private - Set Up Methods
    
    private func setUpView() {
        self.view.backgroundColor = UIColor.lightGrayColor()
    }
    
    private func setUpNavigationBar() {
        let navigationBar = UIView()
        navigationBar.backgroundColor = UIColor(red:0.55, green:0.75, blue:0.12, alpha:1.0)
        
        self.view.addSubview(navigationBar)
        
        navigationBar.snp_makeConstraints { make in
            make.top.equalTo(self.view.snp_top)
            make.left.equalTo(self.view.snp_left)
            make.right.equalTo(self.view.snp_right)
            make.height.equalTo(self.preferredNavigationBarHeight)
        }
        
        self.navigationBar = navigationBar
    }
    
    private func setUpTitleImageView() {
        let label = UILabel()
        label.font = UIFont.boldSystemFontOfSize(18)
        label.textColor = UIColor.whiteColor()
        label.text = "Custom Nav Bar"
        
        label.sizeToFit()
        
        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, 0.0)
        label.drawViewHierarchyInRect(label.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let imageView = UIImageView()
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.image = image
        self.titleImageSize = image.size
        
        self.navigationBar?.addSubview(imageView)
        let superview = imageView.superview!
        
        imageView.snp_makeConstraints { make in
            make.centerX.equalTo(self.navigationBar!.snp_centerX)
            make.bottom.equalTo(self.navigationBar!.snp_bottom).with.offset(-12)
        }
        
        self.titleImageView = imageView
    }
    
    private func setUpDoneButton() {
        let attributes = [
            NSFontAttributeName: UIFont.boldSystemFontOfSize(17),
            NSForegroundColorAttributeName: UIColor.whiteColor()
        ]
        
        let attributedTitle = NSAttributedString(string: "Done", attributes: attributes)
        
        let button = UIButton.buttonWithType(UIButtonType.System) as UIButton
        button.setAttributedTitle(attributedTitle, forState: .Normal)
        button.addTarget(self, action: "doneButtonTapped", forControlEvents: .TouchUpInside)
        
        self.navigationBar?.addSubview(button)
        let superview = button.superview!
        
        button.snp_makeConstraints { make in
            make.bottom.equalTo(self.navigationBar!.snp_bottom).with.offset(-6)
            make.right.equalTo(self.navigationBar!.snp_right).with.offset(-20)
        }
        
        self.doneButton = button
    }
    
    private func setUpTableView() {
        let tableView = UITableView()
        
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        tableView.separatorColor = UIColor.darkGrayColor()
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.allowsSelection = false
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: self.CellIdentifier)
        
        self.view.addSubview(tableView)
        let superview = self.view
        
        tableView.snp_makeConstraints { make in
            make.left.equalTo(superview.snp_left)
            make.right.equalTo(superview.snp_right)
            make.bottom.equalTo(superview.snp_bottom)
            make.top.equalTo(self.navigationBar!.snp_bottom)
        }
        
        self.tableView = tableView
    }
    
    // MARK: Private - Button Callback Methods
    
    @objc private func doneButtonTapped() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

// MARK: - UITableViewDataSource

extension CustomNavBarViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(self.CellIdentifier, forIndexPath: indexPath) as UITableViewCell
        cell.contentView.backgroundColor = UIColor.whiteColor()
        cell.textLabel?.text = "Cell: \(indexPath.row + 1)"
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension CustomNavBarViewController : UITableViewDelegate {
    var cellHeight: CGFloat { return 60.0 }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.cellHeight
    }
}

// MARK: - UIScrollViewDelegate

extension CustomNavBarViewController : UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        struct Static {
            static var ignoreEvent = false
        }
        
        if Static.ignoreEvent {
            return
        }
        
        if navigationBarHeightNeedsAdjusted() {
            self.preferredNavigationBarHeight -= Double(scrollView.contentOffset.y)
            
            let maxHeight = self.maxNavigationBarHeight
            let minHeight = self.minNavigationBarHeight
            
            self.preferredNavigationBarHeight = max(minHeight, min(maxHeight, self.preferredNavigationBarHeight))
            
            self.view.setNeedsUpdateConstraints()
            self.view.updateConstraintsIfNeeded()
            
            Static.ignoreEvent = true
            scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x, y: 0.0)
            Static.ignoreEvent = false
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            animateContentOffsetIfNecessary(scrollView)
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        animateContentOffsetIfNecessary(scrollView)
    }
    
    private func animateContentOffsetIfNecessary(scrollView: UIScrollView) {
        if navigationBarHeightNeedsAdjusted() {
            self.preferredNavigationBarHeight = self.preferredNavigationBarHeight < 43 ? self.minNavigationBarHeight : self.maxNavigationBarHeight
            
            self.view.setNeedsUpdateConstraints()
            self.view.updateConstraintsIfNeeded()
            
            UIView.animateWithDuration(
                0.20,
                delay: 0.0,
                usingSpringWithDamping: 1.0,
                initialSpringVelocity: 1.0,
                options: UIViewAnimationOptions.CurveEaseIn,
                animations: {
                    self.view.layoutIfNeeded()
                },
                completion: nil
            )
        }
    }
    
    private func navigationBarHeightNeedsAdjusted() -> Bool {
        let height = Double(self.navigationBar!.frame.height)
        
        if height < self.maxNavigationBarHeight && height > self.minNavigationBarHeight {
            return true
        }
        
        switch self.tableView!.contentOffset.y {
        case 0...44:
            return height > self.minNavigationBarHeight
        case -44..<0:
            return height < self.maxNavigationBarHeight
        default:
            return false
        }
    }
}
