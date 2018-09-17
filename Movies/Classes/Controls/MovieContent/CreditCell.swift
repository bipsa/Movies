//
//  CreditCell.swift
//  Movies
//
//  Created by Sebastian Romero on 17/09/18.
//  Copyright © 2018 Maachi. All rights reserved.
//

import UIKit
import AlamofireImage

class CreditCell: UITableViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var creditNameLabel: UILabel!
    @IBOutlet weak var characterLabel: UILabel!
    

    var currentCredit:Credit!
    
    var credit:Credit {
        get {
            return currentCredit
        }
        set {
            currentCredit = newValue
            if let name = credit.name {
                creditNameLabel.text = name
            }
            if let character = credit.character {
                characterLabel.text = character
            }
            thumbnail.cornerRadius(radius: 15)
            if let thumbnailPath =  credit.thumbnail {
                thumbnail.af_setImage(withURL: thumbnailPath, placeholderImage: nil, filter: nil, progress: { (progress) in
                }, progressQueue: DispatchQueue.main, imageTransition: .crossDissolve(0.3), runImageTransitionIfCached: false, completion: { (response) in
                })
            }
            
        }
    }
    

}
