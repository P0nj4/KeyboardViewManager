//
//  UIViewController+KeyboardManagment.h
//  merry-jane-mobile
//
//  Created by German Pereyra on 12/2/15.
//  Copyright © 2015 Neon Roots. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardManagerViewController.h"

@interface KeyboardManagerViewController (KeyboardManagment)
- (void)keyboardWillShow:(NSNotification*)notification;
- (void)keyboardWillBeHidden:(NSNotification*)notification;
@end
