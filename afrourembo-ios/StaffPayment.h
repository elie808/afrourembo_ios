//
//  StaffPayment.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 5/27/18.
//  Copyright © 2018 Elie El Khoury. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Professional.h"

@interface StaffPayment : NSObject

@property NSInteger price;
@property NSString *currency;

@property Professional *professional;

@end
