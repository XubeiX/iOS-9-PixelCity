//
//  Constants.swift
//  PixelCity
//
//  Created by Artur Ratajczak on 24/02/2019.
//  Copyright © 2019 Artur Ratajczak. All rights reserved.
//

import Foundation

let API_KEY = "80268ff84bbe067761ba9ab11dcc58cd" //flickr api key

func flickrUrl(forApiKey key: String, withAnnotation annotation: DroppablePin, andNumberOfPhotos number: Int) -> String {
    return "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(key)&lat=\(annotation.coordinate.latitude)&lon=\(annotation.coordinate.longitude)&radius=1&radius_units=km&per_page=\(number)&sort=date-posted-desc&format=json&nojsoncallback=1"
}
