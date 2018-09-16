//
//  CompanyCell.swift
//  Movies
//
//  Created by Sebastian Romero on 15/09/18.
//  Copyright © 2018 Maachi. All rights reserved.
//

import UIKit
import AlamofireImage


class CompanyCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    var currentCompany:Company!
    
    var company:Company {
        get {
            return currentCompany
        }
        set {
            currentCompany = newValue
            nameLabel.text = newValue.name ?? ""
            self.loadImage()
        }
    }
    
    
    func loadImage(){
        if let logoPath = currentCompany.logo {
            if let cachedImage = UIImage(cache: logoPath) {
                image.image = cachedImage
            } else {
                if let finalURL:URL = URL(string: "https://image.tmdb.org/t/p/original\(logoPath)") {
                    image.af_setImage(withURL: finalURL, placeholderImage: nil, filter: nil, progress: { (progress) in
                    }, progressQueue: DispatchQueue.main, imageTransition: .crossDissolve(0.3), runImageTransitionIfCached: false, completion: { (response) in
                        if let loadedImage = response.result.value {
                            loadedImage.cache(key:logoPath)
                        }
                    })
                }
            }
        }
    }
    
    
}
