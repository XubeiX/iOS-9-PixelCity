//
//  DroppablePin.swift
//  PixelCity
//
//  Created by Artur Ratajczak on 23/02/2019.
//  Copyright © 2019 Artur Ratajczak. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class DroppablePin: NSObject, MKAnnotation {
    dynamic var coordinate: CLLocationCoordinate2D
    var identifier: String
    
    init(coordinate: CLLocationCoordinate2D, identifier: String){
        self.coordinate = coordinate
        self.identifier = identifier
        super.init()
    }
    
    
}
