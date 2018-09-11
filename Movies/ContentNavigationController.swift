//
//  ContentNavigationController.swift
//  Movies
//
//  Created by Sebastian Romero on 11/09/18.
//  Copyright © 2018 Maachi. All rights reserved.
//

import UIKit

class ContentNavigationController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = UIColor.white
        TheMovieDB.api.getPopularMovies { (error, response) in
            print(response ?? "")
        }
    }

}
