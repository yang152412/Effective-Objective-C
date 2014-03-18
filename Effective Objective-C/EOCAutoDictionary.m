//
//  EOCAutoDictionary.m
//  Effective Objective-C
//
//  Created by Yang Shichang on 14-3-18.
//  Copyright (c) 2014年 Yang152412. All rights reserved.
//

#import "EOCAutoDictionary.h"
#import <objc/runtime.h>

@interface EOCAutoDictionary ()

@property (nonatomic,strong) NSMutableDictionary *backingStore;

@end

@implementation EOCAutoDictionary

@dynamic string,number,date,opaqueObject;

- (id)init {
    if (self = [super init]) {
        _backingStore = [NSMutableDictionary new];
    }
    return self;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSString *selectorString = NSStringFromSelector(sel);
    if ([selectorString hasPrefix:@"set"]) {
        class_addMethod(self, sel, (IMP)autoDictionarySetter, "v@:@");
    } else {
        class_addMethod(self, sel, (IMP)autoDictionaryGetter, "@@:");
    }
    return YES;
}

// The getter function would then be implemented as follows:
id autoDictionaryGetter(id self,SEL _cmd) {
    // Get the backing store from the object
    EOCAutoDictionary *typedSelf = (EOCAutoDictionary *)self;
    NSMutableDictionary *backingStore = typedSelf.backingStore;
    
    // The key is simply the selector name
    NSString *key = NSStringFromSelector(_cmd);
    
    return [backingStore objectForKey:key];
}

void autoDictionarySetter(id self,SEL _cmd,id value) {
    // Get the backing store from the object
    EOCAutoDictionary *typedSelf = (EOCAutoDictionary *)self;
    NSMutableDictionary *backingStore = typedSelf.backingStore;
    
    /** The selector will be for example, "setOpaqueObject:".
     We need to remove the "set",":" and lowercase the first letter of the remainder.*/
    NSString *selectorString = NSStringFromSelector(_cmd);
    NSMutableString *key = [selectorString mutableCopy];
    
    // Remove the ":" at the end
    [key deleteCharactersInRange:NSMakeRange(key.length-1, 1)];
    
    // Remvoe the 'set' prefix
    [key deleteCharactersInRange:NSMakeRange(0, 3)];
    
    // Lowercase the first character
    NSString *lowercaseFirstChar = [[key substringToIndex:1] lowercaseString];
    [key replaceCharactersInRange:NSMakeRange(0, 1) withString:lowercaseFirstChar];
    
    if (value) {
        [backingStore setObject:value forKey:key];
    } else {
        [backingStore removeObjectForKey:key];
    }
}


@end
