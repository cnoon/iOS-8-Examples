//
//  RootViewController.swift
//  Collapsing Nav
//
//  Created by Christian Noon on 2/8/15.
//  Copyright (c) 2015 Noondev. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    let buttonVerticalSpacing: CGFloat = 40.0
    var verticalOffsetPosition: CGFloat = 100.0
    
    // MARK: View Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpInstanceProperties()
        setUpButtons()
    }
    
    // MARK: Private - Set Up Methods
    
    private func setUpInstanceProperties() {
        self.title = "Collapsing Bars"
        self.view.backgroundColor = UIColor(red: 42.0 / 255.0, green: 190.0 / 255.0, blue: 157.0 / 255.0, alpha: 1.0)
    }

    private func setUpButtons() {
        let buttonGroup: [(String, Selector)] = [
            ("Default Apple Nav Bars", "appleNavBarsButtonTapped"),
            ("Custom Nav Bars", "customNavBarsButtonTapped")
        ]
        
        buttonGroup.map { self.setUpButton(title: $0, action: $1) }
    }
    
    func setUpButton(#title: String, action: Selector) {
        let button = UIButton.buttonWithType(UIButtonType.System) as UIButton
        button.setTitle(title, forState: UIControlState.Normal)
        button.addTarget(self, action: action, forControlEvents: .TouchUpInside)
        
        self.view.addSubview(button)
        
        button.sizeToFit()
        button.center = CGPoint(x: self.view.center.x, y: self.verticalOffsetPosition)
        self.verticalOffsetPosition += self.buttonVerticalSpacing
    }

    // MARK: Private - UIButton Callback Methods
    
    @objc private func appleNavBarsButtonTapped() {
        let navigationController = UINavigationController(rootViewController: AppleNavBarViewController())
        
        navigationController.navigationBar.barTintColor = UIColor(red: 0.1451, green: 0.4588, blue: 1.0, alpha: 1.0)
        navigationController.navigationBar.translucent = false
        navigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        presentViewController(navigationController, animated: true, completion: nil)
    }
    
    @objc private func customNavBarsButtonTapped() {
        presentViewController(CustomNavBarViewController(), animated: true, completion: nil)
    }
}
