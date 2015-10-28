//
//  Teams.m
//  ios-teams-API
//
//  Created by Treinamento Mobile on 10/28/15.
//  Copyright © 2015 Treinamento Mobile. All rights reserved.
//

#import "Teams.h"

@implementation Teams

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"name":@"name",
             @"logo_url":@"logo_url"
             };
}
@end
