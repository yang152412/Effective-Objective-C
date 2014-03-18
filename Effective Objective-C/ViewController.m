//
//  ViewController.m
//  Effective Objective-C
//
//  Created by Yang Shichang on 14-3-18.
//  Copyright (c) 2014年 Yang152412. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
@interface ViewController ()<UIAlertViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self askUserAQuestion];
    [self askUserBQuestion];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 关联对象
static void *EOCMyAlertViewKey = "EOCMyalertViewKey";
- (void)askUserAQuestion {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Question A" message:@"What do you want to do?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Continue", nil];
    
    void (^block)(NSInteger) = ^(NSInteger buttonIndex) {
        if (buttonIndex == 0) {
            [self doCancel:@"Question A"];
        } else {
            [self doContinue:@"Question A"];
        }
    };
    
    objc_setAssociatedObject(alert, EOCMyAlertViewKey, block, OBJC_ASSOCIATION_COPY);
    [alert show];
}

- (void)askUserBQuestion {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Question B" message:@"What do you want to do?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Continue", nil];
    
    void (^block)(NSInteger) = ^(NSInteger buttonIndex) {
        if (buttonIndex == 0) {
            [self doCancel:@"Question B" ];
        } else {
            [self doContinue:@"Question B" ];
        }
    };
    
    objc_setAssociatedObject(alert, EOCMyAlertViewKey, block, OBJC_ASSOCIATION_COPY);
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    void (^block)(NSInteger) = objc_getAssociatedObject(alertView, EOCMyAlertViewKey);
    block(buttonIndex);
}

- (void)doCancel:(NSString *)str { NSLog(@"doCancel   %@",str); }

- (void)doContinue:(NSString *)str { NSLog(@"doContinue   %@",str); }



@end
