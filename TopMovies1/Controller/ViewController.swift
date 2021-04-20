//
//  ViewController.swift
//  TopMovies1
//
//  Created by Матвей Бойков on 16.04.2021.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    private var moviesManagerObject = MoviesManager()
    private var moviesDataVC : [Movies]?
    private var imagesArray = [(UIImage, Int)]()
    private let notificationSettting = NotificationSettings()
    
    private let moviesCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset.top = Constants.CollectionViewConstants.sectionInsetFromTop
        layout.minimumLineSpacing = Constants.CollectionViewConstants.minimumLineSpacingBetweenCells
        
        let colViewFrame : CGRect = CGRect(x: 0, y: 0, width: 10, height: 10)
        let colView = UICollectionView(frame: colViewFrame, collectionViewLayout: layout)
        
        colView.backgroundColor = .white
        colView.translatesAutoresizingMaskIntoConstraints = false
        
        return colView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        moviesManagerObject.fetchingMoviesData()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        notificationSettting.registerLocal()
        moviesManagerObject.delegate = self
        moviesCollectionView.dataSource = self
        moviesCollectionView.delegate = self
        moviesCollectionView.register(MovieCell.self, forCellWithReuseIdentifier: Constants.MovieCellConstants.reuseIdentifier)
        setupCollectionView()
        
    }

    private func setupCollectionView() {
        view.addSubview(moviesCollectionView)
        
        NSLayoutConstraint.activate([
            
            moviesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            moviesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            moviesCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            moviesCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            
        ])
    }
    
    internal func eventCreatingProblemAlert() {
        let alert = UIAlertController(title: Constants.AlertView.eventAlertTitle, message: Constants.AlertView.eventAlertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: Constants.AlertView.eventAlertActionTitle, style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func gettingDataProblemAlert() {
        let alert = UIAlertController(title: Constants.AlertView.networkAlertTitle, message: Constants.AlertView.networkAlertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: Constants.AlertView.networkAlertActionTitle, style: .default) { action in
            self.moviesManagerObject.fetchingMoviesData()
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

//MARK: - MoviesManagerDelegate

extension ViewController : MoviesManagerDelegate {
    
    internal func didDownloadMoviesData(_ moviesData: MoviesData) {
        let resultsArrayLenght = moviesData.results.count
        moviesDataVC = moviesData.results
        for i in 0..<resultsArrayLenght {
            moviesManagerObject.fetchingMoviesData(with: moviesData.results[i].poster_path,
                                                   forGettingOnlyMovieThumbnail: true,
                                                   imageIndex : i)
        }
    }
    
    internal func didDownloadMovieThumbnail(_ image: UIImage, _ imageIndex : Int) {
        DispatchQueue.main.async {
            self.imagesArray.append((image, imageIndex))
            self.moviesCollectionView.reloadData()
            self.imagesArray.sort(by: {$0.1 < $1.1} )
        }
    }
    
    internal func didEndWithError(_ error : Error) {
        DispatchQueue.main.async {
            self.gettingDataProblemAlert()
            self.moviesCollectionView.reloadData()
        }
       
    }
    
}
//MARK: - UICollectionViewDataSource

extension ViewController : UICollectionViewDataSource {
    
    internal func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Constants.CollectionViewConstants.numberOfSectionsInColView
    }
    
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.MovieCellConstants.reuseIdentifier, for: indexPath) as! MovieCell
        if let safeMoviesDataVC = moviesDataVC {
            let vc = safeMoviesDataVC[indexPath.item]
            cell.mainViewController = self
            cell.cellFilling = CellFilling(movieName: vc.original_title, description: vc.overview, releaseDate: vc.release_date, movieRating: vc.vote_average, movieThumbnail: imagesArray[indexPath.item].0)
        }
        return cell
    }
}
//MARK: - UICollectionViewDelegateFlowLayout

extension ViewController : UICollectionViewDelegateFlowLayout {
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat(view.frame.width * Constants.MovieCellConstants.mainWidthMultiplier), height: CGFloat(view.frame.height * Constants.MovieCellConstants.mainHeightMultiplier))
    }
}

