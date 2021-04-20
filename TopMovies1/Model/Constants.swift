//
//  Constants.swift
//  TopMovies1
//
//  Created by Матвей Бойков on 20.04.2021.
//

import UIKit

struct Constants {
    
    struct CollectionViewConstants {
        static let minimumLineSpacingBetweenCells : CGFloat = 50
        static let sectionInsetFromTop : CGFloat = 10
        static let numberOfSectionsInColView : Int = 1
    }
   
    
    struct MovieCellConstants {
        static let reuseIdentifier : String = "MovieCell"
        static let mainWidthMultiplier : CGFloat = 0.95
        static let mainHeightMultiplier : CGFloat = 0.75
        
        static let movieNameFontSize : CGFloat = 25
        static let movieDateFontSize : CGFloat = 12
        static let movieDescriptionFontSize : CGFloat = 17
        static let movieRatingButtonFonrSize : CGFloat = 25
        
        static let nameDataOverviewViewColour : UIColor = UIColor(red: 52/255, green: 92/255, blue: 107/255, alpha: 1)
        static let decorationvBottomViewColour : UIColor = UIColor(red: 127/255, green: 127/255, blue: 127/255, alpha: 0.5)
        
        static let scheduleViewingButtonTitle : String = "Schedule viewing"
    
    }
    
    struct AlertView {
        static let eventAlertTitle : String = "Error adding event"
        static let eventAlertMessage : String = "We need access to your calendar first."
        static let eventAlertActionTitle : String = "Check settings"
        
        static let networkAlertTitle : String = "Error loadind data"
        static let networkAlertMessage : String = "Bad network connection"
        static let networkAlertActionTitle : String = "Enable network"
    }
    
    struct Notification {
        static let notificationTitle : String = "Do you feel like watching anything?"
        static let notificationBodyPart : String = "is waiting for you then!"
    }
    
    struct restAPI {
        static let apiKEY : String = "7e1ee67be7a1515bcddc4b58fec9be16"
        static let urlWithoutAPIKeyForFullData : String = "https://api.tmdb.org/3/movie/popular?language=en-US&page=1&year=2019&region=RU&api_key="
        static let urlForImages : String = "https://image.tmdb.org/t/p/w500"
    }
    
}
