//
//  Venue.swift
//  IronBike
//
//  Created by ISSD on 29/03/2019.
//  Copyright © 2019 Fontys. All rights reserved.
//

import MapKit
import AddressBook

//class Venues :NSObject{
//    let venues : [Venue]
//
//    init (venues :[Venue]){
//        self.venues = venues
//    }
//}


class Venue: NSObject, MKAnnotation
{
   
    
    let title: String?
    let price: String?
    let coordinate: CLLocationCoordinate2D
    var image: UIImage?
    
    init(title: String, price: String?, coordinate: CLLocationCoordinate2D, image: UIImage)
    {
        self.title = title
        self.price = price
        self.coordinate = coordinate
        self.image = image
        
        super.init()
    }
    
    var subtitle: String? {
        return price
}
    func mapItem() -> MKMapItem
    {
        let addressDictionary = [String(kABPersonAddressStreetKey) : subtitle]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary as [String : Any])
        let mapItem = MKMapItem(placemark: placemark)
        
        mapItem.name = "\(String(describing: title)) \(String(describing: subtitle))"
        
        return mapItem
    }
}




