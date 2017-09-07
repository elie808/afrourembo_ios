//
//  Professional+Helpers.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 9/7/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "Professional+Helpers.h"

@implementation Professional (Helpers)

+ (Professional *)professionalFromJSON:(NSString *)professionalJSONString {
    
    NSData *data = [professionalJSONString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    Professional *retrievedProfessional = [Professional new];
    
    [jsonDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        [retrievedProfessional setValue:obj forKey:(NSString *)key];
    }];
    
    return retrievedProfessional;
}

+ (Professional *)updateProfessional:(Professional *)existingProfessional from:(Professional *)newProfessional {
    
    Professional *delta = [Professional new];
    
    delta.professionalID = newProfessional.professionalID.length > 0 ? newProfessional.professionalID : existingProfessional.professionalID;

    delta.fName = newProfessional.fName.length > 0 ? newProfessional.fName : existingProfessional.fName;
    delta.lName = newProfessional.lName.length > 0 ? newProfessional.lName : existingProfessional.lName;
    delta.email = newProfessional.email.length > 0 ? newProfessional.email : existingProfessional.email;
    delta.phoneNumber = newProfessional.phoneNumber.length > 0 ? newProfessional.phoneNumber : existingProfessional.phoneNumber;
    
    delta.profilePicture = newProfessional.profilePicture.length > 0 ? newProfessional.profilePicture : existingProfessional.profilePicture;
    
    delta.token = newProfessional.token.length > 0 ? newProfessional.token : existingProfessional.token;

    return delta;
}

#pragma mark - Helpers

- (NSString *)convertToJSON {
    
    NSDictionary *details = @{
                              @"professionalID" : self.professionalID.length > 0 ? self.professionalID : @"",
                              @"profilePicture" : self.profilePicture.length > 0 ? self.profilePicture : @"",
                              @"fName" : self.fName.length > 0 ? self.fName : @"",
                              @"lName" : self.lName.length > 0 ? self.lName : @"",
                              @"phoneNumber" : self.phoneNumber.length > 0 ? self.phoneNumber : @"",
                              @"email" : self.email.length > 0 ? self.email : @"",
                              @"token" : self.token.length > 0 ? self.token : @""
                              };
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:details
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if (!jsonData) {
        
        NSLog(@"Got an error converting to JSONString: %@", error);
        return nil;
        
    } else {
        
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonString;
    }
}

@end
