//
//  Address.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 6/23/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Address : NSObject

@property NSString *addressString;
@property CLLocationCoordinate2D addressCoords;

@end
