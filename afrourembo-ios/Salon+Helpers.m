//
//  Salon+Helpers.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 10/23/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "Salon+Helpers.h"

@implementation Salon (Helpers)

+ (Salon *)salonFromJSON:(NSString *)salonJSONString {
    
    NSData *data = [salonJSONString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    Salon *retrievedSalon = [Salon new];
    
    [jsonDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        [retrievedSalon setValue:obj forKey:(NSString *)key];
    }];
    
    return retrievedSalon;
}

+ (Salon *)updateSalon:(Salon *)existingSalon from:(Salon *)newSalon {
    
    Salon *delta = [Salon new];
    
    delta.salonID = newSalon.salonID.length > 0 ? newSalon.salonID : existingSalon.salonID;
    delta.token = newSalon.token.length > 0 ? newSalon.token : existingSalon.token;
    
    delta.fName = newSalon.fName.length > 0 ? newSalon.fName : existingSalon.fName;
    delta.lName = newSalon.lName.length > 0 ? newSalon.lName : existingSalon.lName;
    delta.email = newSalon.email.length > 0 ? newSalon.email : existingSalon.email;
    delta.name  = newSalon.name.length > 0 ? newSalon.name : existingSalon.name;
    delta.address = newSalon.address.length > 0 ? newSalon.address : existingSalon.address;
    delta.phone = newSalon.phone.length > 0 ? newSalon.phone : existingSalon.phone;

    return delta;
}

- (NSString *)convertToJSON {
    
    NSDictionary *details = @{
                              @"salonID" : self.salonID.length > 0 ? self.salonID : @"",
                              @"token" : self.token.length > 0 ? self.token : @"",
                              @"fName" : self.fName.length > 0 ? self.fName : @"",
                              @"lName" : self.lName.length > 0 ? self.lName : @"",
                              @"email" : self.email.length > 0 ? self.email : @"",
                              @"name" : self.name.length > 0 ? self.name : @"",
                              @"address" : self.address.length > 0 ? self.address : @"",
                              @"phone" : self.phone.length > 0 ? self.phone : @""
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
