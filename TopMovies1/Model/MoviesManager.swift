//
//  MoviesManager.swift
//  TopMovies1
//
//  Created by Матвей Бойков on 16.04.2021.
//

import UIKit


protocol MoviesManagerDelegate {
    func didDownloadMoviesData(_ moviesData : MoviesData)
    func didDownloadMovieThumbnail(_ image: UIImage, _ imageIndex : Int)
    func didEndWithError(_ error : Error)
}

struct MoviesManager {
    
    internal var delegate : MoviesManagerDelegate?
    
    private let apiKey = Constants.restAPI.apiKEY
    private let urlStringhWithoutAPIkey = Constants.restAPI.urlWithoutAPIKeyForFullData
    
    private let urlStringForGettingOnlyMovieThumbnail = Constants.restAPI.urlForImages
    
    internal func fetchingMoviesData(with urlString : String? = nil , forGettingOnlyMovieThumbnail : Bool = false, imageIndex : Int = 0) {
        if forGettingOnlyMovieThumbnail == false {
            let urlForRequest = urlStringhWithoutAPIkey + apiKey
            performRequest(with: urlForRequest, imageOnly: forGettingOnlyMovieThumbnail)
        } else {
            guard let safeUrlString = urlString else { return }
            let urlForRequest = urlStringForGettingOnlyMovieThumbnail + safeUrlString
            performRequest(with: urlForRequest, imageOnly: forGettingOnlyMovieThumbnail, index : imageIndex)
        }
    }
    
    private func performRequest(with urlString : String, imageOnly : Bool, index : Int = 0) {
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didEndWithError(error!)
                }
                if let safeData = data {
                    if imageOnly {
                        guard let image = UIImage(data: safeData) else { return }
                        self.delegate?.didDownloadMovieThumbnail(image, index)
                    } else {
                        if let dowloadedData = parseJSON(with: safeData) {
                            self.delegate?.didDownloadMoviesData(dowloadedData)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    private func parseJSON(with data : Data) -> MoviesData? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MoviesData.self, from: data)
            return decodedData
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

}
