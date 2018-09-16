//
//  MovieCompanies.swift
//  Movies
//
//  Created by Sebastian Romero on 15/09/18.
//  Copyright © 2018 Maachi. All rights reserved.
//

import UIKit


class MovieCompanies:UITableViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var descriptionLabel: UILabel!
    var currentCompanies:[Company] = []
    var companies:[Company] {
        get {
            return currentCompanies
        }
        set {
            currentCompanies = newValue
            collectionView.delegate = self
            collectionView.dataSource = self
            self.collectionView.register(UINib(nibName: "CompanyCell", bundle: nil), forCellWithReuseIdentifier: "CompanyCell")
            collectionView.reloadData()
        }
    }
    
    var movieDescription:String {
        get {
            return descriptionLabel.text ?? ""
        }
        set {
            descriptionLabel.text = newValue
        }
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
    }
    
}


extension MovieCompanies {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.companies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CompanyCell", for: indexPath) as! CompanyCell
        cell.company = self.companies[indexPath.row]
        cell.backgroundColor = .clear
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 80)
    }
    
}


