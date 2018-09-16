//
//  SearchField.swift
//  Movies
//
//  Created by Diana Catalina Rojas on 14/09/18.
//  Copyright © 2018 Maachi. All rights reserved.
//

import UIKit


class SearchField:UIView {
    
    @IBOutlet weak var fieldWrapper: UIView!
    @IBOutlet weak var searchField: UITextField!
    var isAnimating:Bool = false
    
    static let current : SearchField = {
        let instance = Bundle.main.loadNibNamed("SearchField", owner: self, options: nil)?[0] as! SearchField
        instance.fieldWrapper.cornerRadius(radius: 20)
        return instance
    }()
    
    
    func show(){
        if (!isAnimating){
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            if (self.superview == nil) {
                appDelegate.window?.addSubview(self)
                self.frame.size.width = UIScreen.main.bounds.width - 60
                self.frame.origin.y = -60
                self.frame.origin.x = 20
            }
            self.frame.size.height = 47
            isAnimating = true
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveLinear, animations: {
                self.frame.origin.y = 60
            }) { (completed) in
                self.isAnimating = false
            }
        }
    }
    
    
    func hide(){
        if (!isAnimating){
            isAnimating = true
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveLinear, animations: {
                self.frame.origin.y = -95
                self.frame.size.height = 95
            }) { (completed) in
                self.searchField.resignFirstResponder()
                self.isAnimating = false
            }
        } else {
            self.searchField.resignFirstResponder()
        }
    }
    
    func deselect(){
        self.searchField.resignFirstResponder()
    }
}
