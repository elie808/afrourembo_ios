//
//  EKNetworkManager.m
//  afrourembo-ios
//
//  Created by Elie El Khoury on 4/29/17.
//  Copyright © 2017 Elie El Khoury. All rights reserved.
//

#import "EKNetworkManager.h"

@implementation EKNetworkManager

+ (void)configureRestKit {
    
    //---- Restkit Logging
        RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
        RKLogConfigureByName("Restkit/Network", RKLogLevelDebug);
    
    //---- initialize AFNetworking HTTPClient
    AFRKHTTPClient *client = [[AFRKHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:kBaseURL]];
    
    //---- initialize RestKit
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    [[objectManager HTTPClient] setDefaultHeader:@"content-type" value:RKMIMETypeJSON];
    [objectManager setRequestSerializationMIMEType:RKMIMETypeJSON];
    
    [EKNetworkManager configureRequestDescriptors:objectManager];
    [EKNetworkManager configureResponseDescriptors:objectManager];
}

#pragma mark - Request

+ (void)configureRequestDescriptors:(RKObjectManager *)objectManager {
    
    [objectManager addRequestDescriptorsFromArray:@[
                                                    [Day availabilityRequestDescriptor]
                                                    ]];
    
    [objectManager addRequestDescriptorsFromArray:@[
                                                    [Customer userRegistrationRequestDescriptor],
                                                    [Customer fbCustomerRequestDescriptor],
                                                    [Customer userFavoritesRequestDescriptor]
                                                    ]];
    
    [objectManager addRequestDescriptorsFromArray:@[
                                                    [ProfessionalLogin professionalLoginRequestDescriptor],
                                                    [ProfessionalLogin fbProfessionalRequestDescriptor]
                                                    ]];
    
    [objectManager addRequestDescriptorsFromArray:@[
                                                    [ProfessionalInfo professionalInfoRequestDescriptor]
                                                    ]];
    
    [objectManager addRequestDescriptorsFromArray:@[
                                                    [Professional professionalRegistrationRequestDescriptor]
                                                    ]];
    
    [objectManager addRequestDescriptor:[Reservation reservationsRequestDescriptor]];
    
    [objectManager addRequestDescriptor:[ResetPassword resetPasswordRequestDescriptor]];
    
    [objectManager addRequestDescriptorsFromArray:@[
                                                    [Review postReviewsRequestDescriptor]
                                                    ]];
    
    [objectManager addRequestDescriptorsFromArray:@[
                                                    [Salon salonRegistrationRequestDescriptor],
                                                    [Salon salonInfoRequestDescriptor]
                                                    ]];
    
    [objectManager addRequestDescriptorsFromArray:@[
                                                    [SalonLogin salonLoginRequestDescriptor],
                                                    [SalonLogin salonFBRequestDescriptor]
                                                    ]];
    
    [objectManager addRequestDescriptorsFromArray:@[
                                                    [Service postServicesRequestDescriptor]
                                                    ]];
}

#pragma mark - Response

+ (void)configureResponseDescriptors:(RKObjectManager *)objectManager {
    
    [objectManager addResponseDescriptorsFromArray:@[
                                                     [Booking getBookingsForVendorResponseDescriptor]
                                                     ]];
    
    [objectManager addResponseDescriptorsFromArray:@[
                                                     [Reservation getReservationsResponseDescriptor],
                                                     [Reservation postReservationsResponseDescriptor]
                                                     ]];
    
    [objectManager addResponseDescriptor:[Category categoryResponseDescriptor]];
    
    [objectManager addResponseDescriptorsFromArray:@[
                                                     [Customer userRegistrationResponseDescriptor],
                                                     [Customer userLoginResponseDescriptor],
                                                     [Customer putUserProfileResponseDescriptor],
                                                     [Customer fbUserRegistrationResponseDescriptor],
                                                     [Customer fbUserLoginResponseDescriptor],
                                                     [Customer userResetPassResponseDescriptor],
                                                     [Customer userBookingsResponseDescriptor],
                                                     [Customer userPostFavoritesResponseDescriptor],
                                                     [Customer userGetFavoritesResponseDescriptor],
                                                     [Customer userDeleteFavoritesResponseDescriptor]
                                                     ]];
    
    [objectManager addResponseDescriptorsFromArray:@[
                                                     [Dashboard getDashboardResponseDescriptor],
                                                     [Dashboard getSalonDashboardResponseDescriptor]
                                                     ]];
    
    [objectManager addResponseDescriptorsFromArray:@[
                                                     [Day availabilityResponseDescriptor],
                                                     [Day vendorAvailabilityResponseDescriptor],
                                                     [Day getAvailabilityResponseDescriptor]
                                                     ]];
    
    [objectManager addResponseDescriptorsFromArray:@[
                                                     [Explore exploreProfessionalsResponseDescriptor],
                                                     [Explore exploreSalonsResponseDescriptor]
                                                     ]];
    
    [objectManager addResponseDescriptorsFromArray:@[
                                                     [ProfilePicture postUserProfilePictureResponseDescriptor],
                                                     [ProfilePicture postProfessionalProfilePictureResponseDescriptor],
                                                     [ProfilePicture postSalonProfilePictureResponseDescriptor],
                                                     [ProfilePicture postProfessionalPortfolioPictureResponseDescriptor],
                                                     [ProfilePicture deleteProfessionalPortfolioPictureResponseDescriptor],
                                                     [ProfilePicture postSalonPortfolioPictureResponseDescriptor],
                                                     [ProfilePicture deleteSalonPortfolioPictureResponseDescriptor]
                                                     ]];
    
    [objectManager addResponseDescriptorsFromArray:@[
                                                     [ProfessionalLogin professionalLoginResponseDescriptor],
                                                     [ProfessionalLogin fbProfessionalLoginResponseDescriptor],
                                                     [ProfessionalLogin fbProfessionalRegistrationResponseDescriptor]
                                                     ]];
    
    [objectManager addResponseDescriptor:[ProfessionalInfo professionalInfoResponseDescriptor]];
    
    [objectManager addResponseDescriptorsFromArray:@[
                                                     [Professional professionalRegistrationResponseDescriptor],
                                                     [Professional professionalResetPassResponseDescriptor],
                                                     [Professional professionalResetPassResponseDescriptor],
                                                     [Professional professionalClientsResponseDescriptor],
                                                     [Professional professionalProfileResponseDescriptor],
                                                     [Professional getProfessionalProfileResponseDescriptor],
                                                     [Professional putProfessionalProfileResponseDescriptor],
                                                     [Professional postProfessionalSalonJoinResponseDescriptor],
                                                     [Professional getSalonClientsResponseDescriptor]
                                                     ]];
    
    [objectManager addResponseDescriptorsFromArray:@[
                                                     [Review getReviewsResponseDescriptor],
                                                     [Review postReviewsResponseDescriptor]
                                                     ]];
    
    [objectManager addResponseDescriptorsFromArray:@[
                                                     [Salon salonRegistrationResponseDescriptor],
                                                     [Salon getStaffResponseDescriptor],
                                                     [Salon getSalonListResponseDescriptor],
                                                     [Salon getStaffJoinRequestsResponseDescriptor],
                                                     [Salon getCurrentStaffResponseDescriptor],
                                                     [Salon postSalonInfoResponseDescriptor],
                                                     [Salon getSalonProfileResponseDescriptor],
                                                     [Salon putSalonProfileResponseDescriptor]
                                                     ]];
    
    [objectManager addResponseDescriptorsFromArray:@[
                                                     [SalonLogin salonLoginResponseDescriptor],
                                                     [SalonLogin salonResetPassResponseDescriptor],
                                                     [SalonLogin salonFBRegistrationResponseDescriptor]
                                                     ]];
    
    [objectManager addResponseDescriptorsFromArray:@[
                                                     [Service postServicesResponseDescriptor],
                                                     [Service deleteServiceResponseDescriptor]
                                                     ]];
}

@end
