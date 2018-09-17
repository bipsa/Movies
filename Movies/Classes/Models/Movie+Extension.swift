//
//  Movie+Extension.swift
//  Movies
//
//  Created by Sebastian Romero on 11/09/18.
//  Copyright © 2018 Maachi. All rights reserved.
//

import UIKit

extension Movie {
    
    
    class func add(movieItem:MovieItem) -> Movie {
        var movie:Movie! = Movie.get(attribute: "id", value: "=\(movieItem.id)")
        if movie == nil {
            movie = Movie.create()
        }
        movie.id = movieItem.id
        movie.voteCount = movieItem.vote_count
        movie.video = movieItem.video
        movie.voteAverage = movieItem.vote_average
        movie.title = movieItem.title
        movie.popularity = movieItem.popularity
        movie.posterPath = movieItem.poster_path
        movie.originalLanguage = movieItem.original_language
        movie.originalTitle = movieItem.original_title
        movie.backdropPath = movieItem.backdrop_path
        movie.adult = movieItem.adult
        movie.overview = movieItem.overview
        if let date = movieItem.release_date.date {
            movie.releaseDate = date
        }
        _ = movie.save()
        return movie
    }
    
    
    func addDetail(detail:MovieDetail) {
        self.site = detail.homepage
        self.budget = detail.budget
        self.runtime = detail.runtime
        for companyResponse in detail.production_companies {
            let company = Company.add(companyItem: companyResponse)
            self.addToCompanies(company)
        }
        for genreResponse in detail.genres {
            let genre = Genre.add(genreItem: genreResponse)
            self.addToGenres(genre)
        }
        self.detailLoaded = true
        _ = self.save()
    }
    
    
    func qualification() -> String {
        if self.adult {
            return "R"
        } else {
            return "PG"
        }
    }
    
}
