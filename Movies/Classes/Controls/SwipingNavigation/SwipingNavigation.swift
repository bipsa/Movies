//
//  SwipingNavigation.swift
//  Movies
//
//  Created by Sebastian Romero on 11/09/18.
//  Copyright © 2018 Maachi. All rights reserved.
//

import UIKit

class SwipingNavigation:UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        self.setUpNavigation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didMoveToSuperview() {
        if let superview = self.superview {
            superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": self]))
            superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(-10)-[view]-(0)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": self]))
        }
    }
    
    
    func setUpNavigation(){
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = .white
        self.register(ContentCell.self, forCellWithReuseIdentifier: "contentCell")
        self.isPagingEnabled = true
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
}


extension SwipingNavigation {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "contentCell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: self.frame.height)
    }
}
