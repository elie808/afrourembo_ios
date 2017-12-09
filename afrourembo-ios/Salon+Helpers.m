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
        
        // since portfolio array (of Pictures objects) is saved as a dictionary,
        // we manually convert it to an NSArray of NSObjects. bullshit of course :[
        if ( [(NSString *)key isEqualToString:@"portfolio"] ) {
            
            NSMutableArray *picsArray = [NSMutableArray new];
            for (NSDictionary *portfolioDict in [jsonDictionary valueForKey:@"portfolio"]) {
                Pictures *pic = [Pictures new];
                pic.pictureID = [portfolioDict valueForKey:@"pictureID"];
                pic.picture   = [portfolioDict valueForKey:@"picture"];
                [picsArray addObject:pic];
            }
            
            retrievedSalon.portfolio = [NSArray arrayWithArray:picsArray];
            
        } else {
            
            [retrievedSalon setValue:obj forKey:(NSString *)key];
        }
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

    delta.portfolio = [NSArray arrayWithArray:newSalon.portfolio];
    
    return delta;
}

- (NSString *)convertToJSON {
    
    // exctract portfolio picture URLs, so we're able to serialize them with no errors...FUCK THIS BULLSHIT !!!!
    NSMutableArray *portfolioArray = [NSMutableArray new];
    for (Pictures *pic in self.portfolio) {
        
        [portfolioArray addObject:@{@"pictureID":pic.pictureID,
                                    @"picture":pic.picture
                                    }];
    }
    
    NSDictionary *details = @{
                              @"salonID" : self.salonID.length > 0 ? self.salonID : @"",
                              @"token" : self.token.length > 0 ? self.token : @"",
                              @"fName" : self.fName.length > 0 ? self.fName : @"",
                              @"lName" : self.lName.length > 0 ? self.lName : @"",
                              @"email" : self.email.length > 0 ? self.email : @"",
                              @"name" : self.name.length > 0 ? self.name : @"",
                              @"address" : self.address.length > 0 ? self.address : @"",
                              @"phone" : self.phone.length > 0 ? self.phone : @"",
                              @"portfolio" : portfolioArray.count > 0 ? portfolioArray : [NSArray new]
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
