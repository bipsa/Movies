//
//  MovieHero.swift
//  Movies
//
//  Created by Sebastian Romero on 12/09/18.
//  Copyright © 2018 Maachi. All rights reserved.
//

import UIKit


class MovieHero:UITableViewCell {
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDetail: UILabel!
    
    override func willMove(toSuperview newSuperview: UIView?) {
        self.backgroundColor = UIColor.clear
    }
    
}
