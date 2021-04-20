//
//  movieCell.swift
//  TopMovies1
//
//  Created by Матвей Бойков on 16.04.2021.
//

import UIKit
import EventKit
import EventKitUI


class MovieCell : UICollectionViewCell {
    
    private let store = EKEventStore()

    private let moviesLogic = MoviesLogic()
    
    internal var mainViewController : ViewController?
    
    internal var cellFilling : CellFilling? {
        didSet {
            
            if let safeMovieName = cellFilling?.movieName {
                movieMainNameLabel.text = safeMovieName
            }
                        
            if let newDateFormat = cellFilling?.releaseDate {
                movieMainDateLabel.text = moviesLogic.dateConverting(converting: newDateFormat)
            }
            
            if let safeDescription = cellFilling?.description {
                movieMainDescriptionTextView.text = safeDescription
            }
            
            if let rating = cellFilling?.movieRating {
                
                let ratingToShow : Double = rating * 10
                let ratingColour = moviesLogic.getRatingColour(for: ratingToShow)
                let stringRatingToShow = String(format: "%.0f", ratingToShow) + "%"
                movieMainRatingButton.setTitle(stringRatingToShow, for: .normal)
                movieMainRatingButton.shapeLayer.fillColor = ratingColour.cgColor
                
            }
            
            if let safeImage = cellFilling?.movieThumbnail {
                movieMainImageView.image = safeImage
            }
        }
    }
    
    private let movieMainImageView : UIImageView = {
        
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        return imageView
        
    }()
    
    private let movieMainRatingButton : CircleButton = {
        
        let button = CircleButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.numberOfLines = 1
        button.titleLabel?.minimumScaleFactor = 0.5
        
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.MovieCellConstants.movieRatingButtonFonrSize)
        return button
    }()
    
    private let scheduleViewingButton : UIButton = {
        
        let button = UIButton()
        button.backgroundColor = .systemYellow
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.numberOfLines = 1
        button.titleLabel?.minimumScaleFactor = 0.5
        
        button.setTitle(Constants.MovieCellConstants.scheduleViewingButtonTitle, for: .normal)
        button.setTitleColor(.darkText, for: .normal)
        return button
    }()
    
    private let movieMainNameLabel : UILabel = {
        
        let label = UILabel()
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: Constants.MovieCellConstants.movieNameFontSize)
        label.textColor = .white
        return label
    }()
    
    private let movieMainDateLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        
        label.textAlignment = .left
        label.textColor = .lightText
        label.font = UIFont.systemFont(ofSize: Constants.MovieCellConstants.movieDateFontSize)
        return label
    }()
    
    private let movieMainDescriptionTextView : UITextView = {
        
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        textView.isEditable = false
        textView.isUserInteractionEnabled = true
        textView.showsVerticalScrollIndicator = false
       
        textView.textAlignment = .left
        textView.textColor = .lightText
        textView.font = UIFont.systemFont(ofSize: Constants.MovieCellConstants.movieDescriptionFontSize)
        textView.textAlignment = .left
        textView.textContainerInset.left = 0
        return textView
    }()
    
    private let nameDataOverviewView : UIView = {
        
        let view = UIView()
        view.backgroundColor = Constants.MovieCellConstants.nameDataOverviewViewColour
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        return view
        
    }()
    
    private let decorationvBottomView : UIView = {
        
        let view = UIView()
        view.backgroundColor = Constants.MovieCellConstants.decorationvBottomViewColour
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        return view
        
    }()
    
    private let viewForScheduleViewingButton : UIView = {
        
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        return view
        
    }()
    
    private let viewForRatingButton : UIImageView = {
        
        let view = UIImageView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        return view
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = CGFloat(1)
        
        layer.cornerRadius = frame.size.width / 12
        movieMainImageView.layer.cornerRadius = frame.size.width / 12
        viewForRatingButton.layer.cornerRadius = frame.size.width / 12
        nameDataOverviewView.layer.cornerRadius = frame.size.width / 12
        viewForScheduleViewingButton.layer.cornerRadius = frame.size.width / 12
        
        decorationvBottomView.layer.cornerRadius = frame.size.width / 15
        scheduleViewingButton.layer.cornerRadius = frame.size.width / 20
        
        clipsToBounds = true
        setupImageView()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImageView() {
    
        let rateButtonVerticalStack = UIStackView(arrangedSubviews: [viewForRatingButton, viewForScheduleViewingButton])
        rateButtonVerticalStack.axis = .vertical
        rateButtonVerticalStack.distribution = .fillEqually
        viewForScheduleViewingButton.addSubview(scheduleViewingButton)
        scheduleViewingButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        viewForRatingButton.addSubview(movieMainRatingButton)
        
        let imageRateButtonHorizontalStack = UIStackView(arrangedSubviews: [movieMainImageView, rateButtonVerticalStack])
        imageRateButtonHorizontalStack.axis = .horizontal
        imageRateButtonHorizontalStack.distribution = .fillEqually
        imageRateButtonHorizontalStack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageRateButtonHorizontalStack)
        addSubview(nameDataOverviewView)
        nameDataOverviewView.addSubview(movieMainNameLabel)
        nameDataOverviewView.addSubview(movieMainDateLabel)
        nameDataOverviewView.addSubview(movieMainDescriptionTextView)
        nameDataOverviewView.addSubview(decorationvBottomView)
        
        let multiplier : CGFloat = ( frame.width * 1.5 / 2 ) / frame.height
        
        NSLayoutConstraint.activate([
            
            imageRateButtonHorizontalStack.topAnchor.constraint(equalTo: topAnchor),
            imageRateButtonHorizontalStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageRateButtonHorizontalStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageRateButtonHorizontalStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: multiplier),
            imageRateButtonHorizontalStack.widthAnchor.constraint(equalTo: widthAnchor),
            
            nameDataOverviewView.topAnchor.constraint(equalTo: imageRateButtonHorizontalStack.bottomAnchor),
            nameDataOverviewView.bottomAnchor.constraint(equalTo: bottomAnchor),
            nameDataOverviewView.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameDataOverviewView.trailingAnchor.constraint(equalTo: trailingAnchor),

            movieMainNameLabel.topAnchor.constraint(equalTo: nameDataOverviewView.topAnchor,constant: 20),
            movieMainNameLabel.widthAnchor.constraint(equalTo: nameDataOverviewView.widthAnchor, multiplier: 0.9),
            movieMainNameLabel.centerXAnchor.constraint(equalTo: nameDataOverviewView.centerXAnchor),
            
            movieMainDateLabel.topAnchor.constraint(equalTo: movieMainNameLabel.bottomAnchor, constant: 5),
            movieMainDateLabel.widthAnchor.constraint(equalTo: nameDataOverviewView.widthAnchor, multiplier: 0.9),
            movieMainDateLabel.centerXAnchor.constraint(equalTo: nameDataOverviewView.centerXAnchor),

            movieMainDescriptionTextView.topAnchor.constraint(equalTo: movieMainDateLabel.bottomAnchor, constant: 5),
            movieMainDescriptionTextView.bottomAnchor.constraint(equalTo: nameDataOverviewView.bottomAnchor, constant: -10),
            movieMainDescriptionTextView.widthAnchor.constraint(equalTo: movieMainNameLabel.widthAnchor, multiplier: 1.03),
            movieMainDescriptionTextView.centerXAnchor.constraint(equalTo: nameDataOverviewView.centerXAnchor),
            
            decorationvBottomView.bottomAnchor.constraint(equalTo: nameDataOverviewView.bottomAnchor),
            decorationvBottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
            decorationvBottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
            decorationvBottomView.heightAnchor.constraint(equalToConstant: 17),
               
            scheduleViewingButton.heightAnchor.constraint(equalTo: viewForScheduleViewingButton.heightAnchor, multiplier: 0.4),
            scheduleViewingButton.widthAnchor.constraint(equalTo: viewForScheduleViewingButton.widthAnchor, multiplier: 0.8),
            scheduleViewingButton.centerXAnchor.constraint(equalTo: viewForScheduleViewingButton.centerXAnchor),
            scheduleViewingButton.centerYAnchor.constraint(equalTo: viewForScheduleViewingButton.centerYAnchor),
            
            movieMainRatingButton.heightAnchor.constraint(equalTo: viewForRatingButton.heightAnchor, multiplier: 0.8),
            movieMainRatingButton.widthAnchor.constraint(equalTo: viewForRatingButton.heightAnchor, multiplier: 0.8),
            movieMainRatingButton.centerXAnchor.constraint(equalTo: viewForRatingButton.centerXAnchor),
            movieMainRatingButton.centerYAnchor.constraint(equalTo: viewForRatingButton.centerYAnchor),
           
        ])
    }
}
//MARK: - EKEventEditViewDelegate

extension MovieCell : EKEventEditViewDelegate {
    
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        controller.dismiss(animated: true) {
            guard let safeDate = controller.event?.startDate, let safeName = self.movieMainNameLabel.text else { return }
            let notSet = NotificationSettings()
            notSet.scheduleLocal(date: safeDate, filmName: safeName)
        }
    }
    
    private func eventSetup() {
            let mainEvent = EKEvent(eventStore: self.store)
            mainEvent.title = movieMainNameLabel.text
            mainEvent.startDate = Date()
            mainEvent.endDate = Date()
            let eventVC = EKEventEditViewController()
            eventVC.editViewDelegate = self
            eventVC.eventStore = self.store
            eventVC.event = mainEvent
            self.mainViewController?.present(eventVC, animated: true, completion: nil)
    }
    
    @objc private func buttonPressed() {
        switch EKEventStore.authorizationStatus(for: .event) {
        case .notDetermined:
            store.requestAccess(to: .event) { (success, error) in
                if success {
                    DispatchQueue.main.async {
                        self.eventSetup()
                    }
                } else {
                    guard let vc = self.mainViewController else { return }
                    vc.eventCreatingProblemAlert()
                }
            }
        case .denied :
            guard let vc = mainViewController else { return }
            vc.eventCreatingProblemAlert()
        case .authorized:
            self.eventSetup()
        default:
            break
        }
    }
    
    
}


