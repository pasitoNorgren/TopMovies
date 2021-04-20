//
//  MoviesData.swift
//  TopMovies1
//
//  Created by Матвей Бойков on 16.04.2021.
//



import Foundation


struct MoviesData : Decodable {
    let results : [Movies]
}

struct Movies : Decodable {
    
    let original_title : String
    let overview : String
    let poster_path : String
    let release_date : String
    let vote_average : Double
}
