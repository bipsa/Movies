//
//  SwipingNavigation.swift
//  Movies
//
//  Created by Sebastian Romero on 11/09/18.
//  Copyright © 2018 Maachi. All rights reserved.
//

import UIKit

class SwipingNavigation:UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var movies:[Movie] = []
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        self.setUpNavigation()
        self.getMovies()
        NotificationCenter.default.addObserver(self, selector: #selector(moviesUpdated), name: Notification.Name("MoviesUpdated"), object: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "MoviesUpdated"), object: nil)
    }
    
    
    override func didMoveToSuperview() {
        if let superview = self.superview {
            superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": self]))
            superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(-10)-[view]-(0)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": self]))
        }
    }
    
    
    @objc func moviesUpdated(_ notification: Notification){
        if let movies = notification.object as? [Movie]{
            if movies.count > 0 && self.movies.count > 0 {
                self.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: false)
            }
            self.movies = movies
            self.reloadData()
        } else {
            self.getMovies()
        }
    }
    
    
    func setUpNavigation(){
        self.backgroundColor = .black
        self.delegate = self
        self.dataSource = self
        self.register(ContentCell.self, forCellWithReuseIdentifier: "contentCell")
        self.isPagingEnabled = true
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func getMovies(){
        self.movies = Movie.find(attributes: [["isPopular", "= 1"]], order: nil, ascending:false, limit: 0, offset: 0) as! [Movie]
        self.reloadData()
    }
    
    
}


extension SwipingNavigation {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "contentCell", for: indexPath) as! ContentCell
        cell.movie = self.movies[indexPath.row]
        cell.initViewContent()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: self.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        SearchField.current.hide()
    }
}
