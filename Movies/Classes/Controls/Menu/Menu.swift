//
//  Menu.swift
//  Movies
//
//  Created by Sebastian Romero on 15/09/18.
//  Copyright © 2018 Maachi. All rights reserved.
//

import UIKit


class Menu:UIView {
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var positionYMenu: NSLayoutConstraint!
    
    static let current : Menu = {
        let instance = Bundle.main.loadNibNamed("Menu", owner: self, options: nil)?[0] as! Menu
        return instance
    }()
    
    
    func show(){
        self.alpha = 0
        if (self.superview == nil) {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            if let top = UIApplication.shared.keyWindow?.safeAreaInsets.top {
                self.frame.origin.y = top * -1
                self.frame.size.width = UIScreen.main.bounds.width
                self.frame.size.height = UIScreen.main.bounds.height + top
            }
            appDelegate.window?.addSubview(self)
            self.animateMenu()
        }
    }
    
    func hide(){
        self.animateMenu(position: UIScreen.main.bounds.height)
    }
    
    
    func animateMenu(position:CGFloat = 0){
        positionYMenu.constant = position
        var alpha = 1
        if position != 0 {
            alpha = 0
        }
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveLinear, animations: {
            self.layoutIfNeeded()
            self.alpha = CGFloat(alpha)
            for button in self.buttons {
                button.alpha = CGFloat(alpha)
            }
        }) { (completed) in
            if position != 0 {
                self.frame.size.width = 300
                self.frame.size.height = 300
                if ((self.superview) != nil) {
                    self.removeFromSuperview()
                }
            }
        }
    }
    
    
    
    @IBAction func getPopularMovies(_ sender: Any) {
        let movies = Movie.find(attributes: [["isPopular", "= 1"]], order: nil, ascending:false, limit: 0, offset: 0) as! [Movie]
        NotificationCenter.default.post(name: Notification.Name("MoviesUpdated"), object: movies)
        self.hide()
    }
    
    @IBAction func getTopRatedMovies(_ sender: Any) {
        let movies = Movie.find(attributes: [["voteCount", "> 1000"]], order: "voteAverage", ascending:false, limit: 0, offset: 0) as! [Movie]
        NotificationCenter.default.post(name: Notification.Name("MoviesUpdated"), object: movies)
        self.hide()
    }
    
    @IBAction func getUpcomingMovies(_ sender: Any) {
        let movies = Movie.find(attributes: [["voteCount", "> 10"]], order: "releaseDate", ascending:false, limit: 0, offset: 0) as! [Movie]
        NotificationCenter.default.post(name: Notification.Name("MoviesUpdated"), object: movies)
        self.hide()
    }
    

}
