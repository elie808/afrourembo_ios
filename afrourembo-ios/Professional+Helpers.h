//
//  Professional+Helpers.h
//  afrourembo-ios
//
//  Created by Elie El Khoury on 9/7/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "Professional.h"

@interface Professional (Helpers)

/// professionalID, fName, lName, phoneNumber, email, token
+ (Professional *)professionalFromJSON:(NSString *)professionalJSONString;

/// professionalID, fName, lName, phoneNumber, email, token
+ (Professional *)updateProfessional:(Professional *)existingProfessional from:(Professional *)newProfessional;

- (NSString *)convertToJSON;

@end
