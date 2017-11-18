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

            retrievedProfessional.portfolio = [NSArray arrayWithArray:picsArray];
            
        } else {
         
            [retrievedProfessional setValue:obj forKey:(NSString *)key];
        }
    }];
    
    return retrievedProfessional;
}

+ (Professional *)updateProfessional:(Professional *)existingProfessional from:(Professional *)newProfessional {
    
    Professional *delta = [Professional new];
    
    delta.professionalID = newProfessional.professionalID.length > 0 ? newProfessional.professionalID : existingProfessional.professionalID;

    delta.fName = newProfessional.fName.length > 0 ? newProfessional.fName : existingProfessional.fName;
    delta.lName = newProfessional.lName.length > 0 ? newProfessional.lName : existingProfessional.lName;
    delta.email = newProfessional.email.length > 0 ? newProfessional.email : existingProfessional.email;
    delta.phone = newProfessional.phone.length > 0 ? newProfessional.phone : existingProfessional.phone;
    delta.about = newProfessional.about.length > 0 ? newProfessional.about : existingProfessional.about;
    
    delta.profilePicture = newProfessional.profilePicture.length > 0 ? newProfessional.profilePicture : existingProfessional.profilePicture;
    
    delta.portfolio = [NSArray arrayWithArray:newProfessional.portfolio];
    
    delta.token = newProfessional.token.length > 0 ? newProfessional.token : existingProfessional.token;

    return delta;
}

#pragma mark - Helpers

- (NSString *)convertToJSON {
    
    // exctract portfolio picture URLs, so we're able to serialize them with no errors...FUCK THIS BULLSHIT !!!!
    NSMutableArray *portfolioArray = [NSMutableArray new];
    for (Pictures *pic in self.portfolio) {
        
        [portfolioArray addObject:@{@"pictureID":pic.pictureID,
                                    @"picture":pic.picture
                                    }];
    }
    
    NSDictionary *details = @{
                              @"professionalID" : self.professionalID.length > 0 ? self.professionalID : @"",
                              @"profilePicture" : self.profilePicture.length > 0 ? self.profilePicture : @"",
                              @"fName" : self.fName.length > 0 ? self.fName : @"",
                              @"lName" : self.lName.length > 0 ? self.lName : @"",
                              @"phone" : self.phone.length > 0 ? self.phone : @"",
                              @"email" : self.email.length > 0 ? self.email : @"",
                              @"about" : self.about.length > 0 ? self.about : @"",
                              @"portfolio" : portfolioArray.count > 0 ? portfolioArray : [NSArray new],
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
