//
//  ContentCell.swift
//  Movies
//
//  Created by Sebastian Romero on 11/09/18.
//  Copyright © 2018 Maachi. All rights reserved.
//

import UIKit
import AlamofireImage


struct ContentCellModel {
    let isHero:Bool
}


class ContentCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
    
    var content:[ContentCellModel] = [ContentCellModel(isHero: true)]
    var imageTopConstraint:NSLayoutConstraint!

    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    let movieImage:UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        if let cachedImage = UIImage(cache: "890.png") {
            image.image = cachedImage
        } else {
            if let finalURL:URL = URL(string: "https://image.tmdb.org/t/p/original/sFC1ElvoKGdHJIWRpNB3xWJ9lJA.jpg") {
                image.af_setImage(withURL: finalURL, placeholderImage: nil, filter: nil, progress: { (progress) in
                    
                }, progressQueue: DispatchQueue.main, imageTransition: .crossDissolve(0.3), runImageTransitionIfCached: false, completion: { (response) in
                    if let loadedImage = response.result.value {
                        loadedImage.cache(key:"890.png")
                    }
                })
            }
        }
        return image
    }()
    
    
    override func willMove(toSuperview newSuperview: UIView?) {
        self.initViewContent()
    }
    
    
    
    func initViewContent(){
        self.clipsToBounds = true
        tableView.backgroundColor = UIColor.clear
        //tableView.register(MovieHero.self, forCellReuseIdentifier: "MovieHero")
        tableView.register(UINib(nibName: "MovieHero", bundle: nil), forCellReuseIdentifier: "MovieHero")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        self.addSubview(movieImage)
        self.addSubview(tableView)
        let verticalImageConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(-0)-[view]-(0)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": movieImage])
        imageTopConstraint = verticalImageConstraints.last
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": tableView]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(-0)-[view]-(0)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": tableView]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": movieImage]))
        self.addConstraints(verticalImageConstraints)
    }
    
}



extension ContentCell {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell
        cell = tableView.dequeueReusableCell(withIdentifier: "MovieHero", for: indexPath as IndexPath) as! MovieHero
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let current = content[indexPath.row]
        if current.isHero {
            return UIScreen.main.bounds.height
        } else {
            return 100
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y < 0){
            imageTopConstraint.constant = scrollView.contentOffset.y
        } else {
            imageTopConstraint.constant = 0
        }
    }
    
}

