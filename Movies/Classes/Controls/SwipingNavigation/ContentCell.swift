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
    var companies:[Company]? = nil
    var credits:[Credit]? = nil
}


class ContentCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
    
    var content:[ContentCellModel] = []
    var imageTopConstraint:NSLayoutConstraint!
    var currentMovie:Movie!
    var lastScrollPosition:CGFloat = 0
    
    var movie:Movie {
        get {
            return currentMovie
        }
        set {
            currentMovie = newValue
            content = [ContentCellModel(isHero: true, companies:nil, credits:nil), ContentCellModel(isHero: false, companies:nil, credits:nil)]
            if let companies = self.currentMovie.companies {
                self.content.append(ContentCellModel(isHero: false, companies:companies.array as? [Company], credits:nil))
            }
            if self.currentMovie.creditsLoaded {
                self.content.append(ContentCellModel(isHero: false, companies:nil, credits:self.currentMovie.credits?.array as? [Credit]))
            }
            self.tableView.reloadData()
            if !currentMovie.detailLoaded {
                TheMovieDB.api.getMovieDetail(movieId: currentMovie.id) { (error, movieDetail) in
                    if let detail = movieDetail {
                        self.currentMovie.addDetail(detail: detail)
                        if self.content.count == 2 {
                            if let companies = self.currentMovie.companies {
                                self.content.append(ContentCellModel(isHero: false, companies:companies.array as? [Company], credits:nil))
                            }
                        }
                        self.tableView.reloadData()
                    }
                }
            }
            if !currentMovie.creditsLoaded {
                TheMovieDB.api.getMovieCredits(movieId: currentMovie.id) { (error, movieCredits) in
                    if let credits = movieCredits {
                        for cast in credits.cast {
                            let movieCredit = Credit.add(creditItem: cast)
                            self.currentMovie.addToCredits(movieCredit)
                            
                        }
                        self.currentMovie.creditsLoaded = true
                        self.content.append(ContentCellModel(isHero: false, companies:nil, credits:self.currentMovie.credits?.array as? [Credit]))
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }

    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    let footerView: UIView = {
        let uview = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 200, width: UIScreen.main.bounds.width, height: 200))
        uview.backgroundColor = UIColor.black
        uview.alpha = 0
        return uview
    }()
    
    
    let movieImage:UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    override func willMove(toSuperview newSuperview: UIView?) {
        self.clipsToBounds = true
        tableView.backgroundColor = UIColor.clear
        //tableView.register(MovieHero.self, forCellReuseIdentifier: "MovieHero")
        tableView.register(UINib(nibName: "MovieHero", bundle: nil), forCellReuseIdentifier: "MovieHero")
        tableView.register(UINib(nibName: "MovieDescription", bundle: nil), forCellReuseIdentifier: "MovieDescription")
        tableView.register(UINib(nibName: "MovieCompanies", bundle: nil), forCellReuseIdentifier: "MovieCompanies")
        tableView.register(UINib(nibName: "LoadingContentCell", bundle: nil), forCellReuseIdentifier: "LoadingContentCell")
        tableView.register(UINib(nibName: "CreditsCell", bundle: nil), forCellReuseIdentifier: "CreditsCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        self.addSubview(movieImage)
        self.addSubview(footerView)
        self.addSubview(tableView)
        let verticalImageConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(-0)-[view]-(0)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": movieImage])
        imageTopConstraint = verticalImageConstraints.last
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": tableView]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(-0)-[view]-(0)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": tableView]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": movieImage]))
        self.addConstraints(verticalImageConstraints)
    }
    
    
    
    func initViewContent(){
        if let cachedImage = UIImage(cache: self.movie.posterPath!) {
            movieImage.image = cachedImage
        } else {
            if let finalURL:URL = URL(string: "https://image.tmdb.org/t/p/original\(self.movie.posterPath!)") {
                movieImage.af_setImage(withURL: finalURL, placeholderImage: nil, filter: nil, progress: { (progress) in
                }, progressQueue: DispatchQueue.main, imageTransition: .crossDissolve(0.3), runImageTransitionIfCached: false, completion: { (response) in
                    if let loadedImage = response.result.value {
                        loadedImage.cache(key:self.movie.posterPath!)
                    }
                })
            }
        }
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
        let current = content[indexPath.row]
        if let credits = current.credits {
            let creditsCell = tableView.dequeueReusableCell(withIdentifier: "CreditsCell", for: indexPath as IndexPath) as! CreditsCell
            creditsCell.credits = credits
            creditsCell.backgroundColor = .clear
            cell = creditsCell
        } else if let companies = current.companies {
            let companiesCell = tableView.dequeueReusableCell(withIdentifier: "MovieCompanies", for: indexPath as IndexPath) as! MovieCompanies
            companiesCell.companies = companies
            companiesCell.backgroundColor = .clear
            cell = companiesCell
        } else if current.isHero {
            let heroCell = tableView.dequeueReusableCell(withIdentifier: "MovieHero", for: indexPath as IndexPath) as! MovieHero
            heroCell.movieTitle.text = movie.originalTitle ?? ""
            heroCell.movieDetail.text = "\(movie.qualification()) | \(movie.runtime) | \(movie.site ?? "No site") "
            cell = heroCell
        } else {
            let descriptionCell = tableView.dequeueReusableCell(withIdentifier: "MovieDescription", for: indexPath as IndexPath) as! MovieDescription
            descriptionCell.movieDescription = self.movie.overview ?? ""
            cell = descriptionCell
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let current = content[indexPath.row]
        if let credits = current.credits {
            var height = CGFloat(ceil(Double(5)) * 58)
            if credits.count < 5  {
                height = CGFloat(ceil(Double(credits.count)) * 58)
            }
            return height
        } else if let companies = current.companies {
            let height = CGFloat(ceil(Double(companies.count)/Double(3)) * 100)
            return height
        } else if current.isHero {
            return UIScreen.main.bounds.height - 75
        } else {
            if let overview = self.movie.overview {
                var height = overview.height(font: UIFont(name: "Roboto-Regular", size: 17)!, width: UIScreen.main.bounds.width - 40)
                if height < 100 {
                    height = 200
                }
                return height
            } else {
                return 200
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.lastScrollPosition = scrollView.contentOffset.y
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y < 0){
            imageTopConstraint.constant = scrollView.contentOffset.y
        } else {
            imageTopConstraint.constant = 0
            footerView.alpha = scrollView.contentOffset.y/50
            footerView.frame.origin.y = UIScreen.main.bounds.height - scrollView.contentOffset.y
            footerView.frame.size.height = scrollView.contentOffset.y + 75
        }
        if lastScrollPosition - scrollView.contentOffset.y > 40 {
            SearchField.current.show()
        } else if lastScrollPosition - scrollView.contentOffset.y < 0  {
            SearchField.current.hide()
        } else {
            SearchField.current.deselect()
        }
    }
    
}

