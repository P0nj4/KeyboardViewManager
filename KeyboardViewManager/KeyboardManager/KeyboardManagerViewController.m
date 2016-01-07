//
//  MJDataEnterViewController.m
//  merry-jane-mobile
//
//  Created by German Pereyra on 12/2/15.
//  Copyright © 2015 Neon Roots. All rights reserved.
//

#import "KeyboardManagerViewController.h"
#import "UIViewController+KeyboardManagment.h"

@interface KeyboardManagerViewController () <UITextFieldDelegate>

@end

@implementation KeyboardManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.textFieldMaxY = [self textFieldPosition:textField] + textField.frame.size.height;
    return YES;
}

- (CGFloat)textFieldPosition:(UIView *)view {
    if (view == self.view) {
        return 0;
    } else {
        return [self textFieldPosition:view.superview] + view.frame.origin.y;
    }
}

@end
