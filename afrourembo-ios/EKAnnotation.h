//
//  EKAnnotation.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/10/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "Salon.h"
#import "Professional.h"

@interface EKAnnotation : MKPointAnnotation

/// Store Salon from dataSource, to make data retrieval easier on tap, etc.
@property (strong, nonatomic) Salon *salonObj;
@property (strong, nonatomic) Professional *profObj;

@end
