//
//  MovieDescription.swift
//  Movies
//
//  Created by Sebastian Romero on 13/09/18.
//  Copyright © 2018 Maachi. All rights reserved.
//

import UIKit


class MovieDescription:UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var movieDescription:String {
        get {
            return descriptionLabel.text ?? ""
        }
        set {
            descriptionLabel.text = newValue
        }
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        self.backgroundColor = UIColor.black
    }
    
}

