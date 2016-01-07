//
//  UIViewController+KeyboardManagment.m
//  merry-jane-mobile
//
//  Created by German Pereyra on 12/2/15.
//  Copyright © 2015 Neon Roots. All rights reserved.
//

#define kMarginBottom 10 

#import "UIViewController+KeyboardManagment.h"

@implementation KeyboardManagerViewController (KeyboardManagment)

- (void)keyboardWillShow:(NSNotification*)notification {
    if (self.isViewLoaded && self.view.window) {
        [self moveControls:notification up:YES];
    }
}

- (void)keyboardWillBeHidden:(NSNotification*)notification {
    if (self.isViewLoaded && self.view.window) {
        [self moveControls:notification up:NO];
    }
}

- (void)moveControls:(NSNotification*)notification up:(BOOL)up {
    NSDictionary* userInfo = [notification userInfo];
    CGRect newFrame = [self getNewControlsFrame:userInfo up:up];
    
    [self animateControls:userInfo withFrame:newFrame];
}

- (CGRect)getNewControlsFrame:(NSDictionary*)userInfo up:(BOOL)up {
    CGRect kbFrame = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    kbFrame = [self.view convertRect:kbFrame fromView:nil];
    
    CGRect newFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat navigationBarMargin = (screenRect.size.height - self.view.frame.size.height) - self.tabBarController.tabBar.frame.size.height;
    CGFloat keyboardYPositionInView = screenRect.size.height - kbFrame.size.height - navigationBarMargin;

    if (up) {
        if (CGRectGetMaxY(newFrame) > keyboardYPositionInView) {
            CGFloat offset = self.textFieldMaxY + kMarginBottom - keyboardYPositionInView;
            if (offset > 0) {
                newFrame.origin.y -= offset;
            }
        }
    }
    else {
        newFrame.origin.y = 0;
    }
    
    return newFrame;
}

- (void)animateControls:(NSDictionary*)userInfo withFrame:(CGRect)newFrame {
    NSTimeInterval duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve animationCurve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:animationOptionsWithCurve(animationCurve)
                     animations:^{
                         self.view.frame = newFrame;
                     }
                     completion:^(BOOL finished){}];
}

static inline UIViewAnimationOptions animationOptionsWithCurve(UIViewAnimationCurve curve) {
    return (UIViewAnimationOptions)curve << 16;
}

@end
