//
//  ContentNavigationController.swift
//  Movies
//
//  Created by Sebastian Romero on 11/09/18.
//  Copyright © 2018 Maachi. All rights reserved.
//

import UIKit

class ContentNavigationController: UIViewController {
    
    let swipingNavigation: SwipingNavigation = {
        let swiping = SwipingNavigation()
        swiping.translatesAutoresizingMaskIntoConstraints = false
        return swiping
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.swipingNavigation)
        TheMovieDB.api.getPopularMovies { (error, response) in
            if let response = response {
                for movie in response.results {
                    Movie.add(movieItem: movie)
                }
            }
        }
    }

}
