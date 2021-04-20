//
//  MoviesLogic.swift
//  TopMovies1
//
//  Created by Матвей Бойков on 18.04.2021.
//

import UIKit

struct MoviesLogic {
    
    internal func dateConverting(converting stringDate : String) -> String {

        let splitDateArray = stringDate.split(separator: "-").map{String($0)}.filter{ $0 != "" }
        var outputDate : String = ""
        var month : String = ""
        if !splitDateArray.isEmpty {
            
            switch splitDateArray[1] {
            case "01" :
                month = "1"
                outputDate = "January " + month + "," + splitDateArray[0]
            case "02" :
                month = "2"
                outputDate = "February " + month + "," + splitDateArray[0]
            case "03" :
                month = "3"
                outputDate = "March " + month + "," + splitDateArray[0]
            case "04" :
                month = "4"
                outputDate = "April " + month + "," + splitDateArray[0]
            case "05" :
                month = "5"
                outputDate = "May " + month + "," + splitDateArray[0]
            case "06" :
                month = "6"
                outputDate = "June " + month + "," + splitDateArray[0]
            case "07" :
                month = "7"
                outputDate = "July " + month + "," + splitDateArray[0]
            case "08" :
                month = "8"
                outputDate = "August " + month + "," + splitDateArray[0]
            case "09" :
                month = "9"
                outputDate = "September " + month + "," + splitDateArray[0]
            case "10" :
                month = "10"
                outputDate = "October " + month + "," + splitDateArray[0]
            case "11" :
                month = "11"
                outputDate = "November " + month + "," + splitDateArray[0]
            case "12" :
                month = "12"
                outputDate = "December " + month + "," + splitDateArray[0]
            default :
                outputDate = "New month name"
            }
        }
        return outputDate
    }
    
    internal func getRatingColour(for rating : Double) -> UIColor {
        switch rating {
        case 0..<40.0 :
            return UIColor.systemRed
        case 40.0..<70.0 :
            return UIColor.systemYellow
        case 70.0...100.0 :
            return UIColor.systemGreen
        default :
            return UIColor.black
        }
    }
}
