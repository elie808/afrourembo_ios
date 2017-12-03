//
//  JoinSalonRequest.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 12/3/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Professional.h"

@interface JoinSalonRequest : NSObject

@property NSString *joinID;
@property Professional *professional;

@end
