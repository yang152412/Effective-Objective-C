//
//  EOCAutoDictionary.h
//  Effective Objective-C
//
//  Created by Yang Shichang on 14-3-18.
//  Copyright (c) 2014年 Yang152412. All rights reserved.
//

// Item 12 Understand Message Forwarding
// Full example of Dynamic Method Resolution


#import <Foundation/Foundation.h>

@interface EOCAutoDictionary : NSObject

@property (nonatomic,strong) NSString *string;
@property (nonatomic,strong) NSNumber *number;
@property (nonatomic,strong) NSDate *date;
@property (nonatomic,strong) id opaqueObject;

@end
