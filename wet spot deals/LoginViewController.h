//
//  LoginViewController.h
//  wet spot deals
//
//  Created by KOMI Marketing on 14/05/15.
//  Copyright (c) 2015 KOMI Marketing All rights reserved.
//

#import <UIKit/UIKit.h>

#import <FBSDKLoginKit/FBSDKLoginButton.h>
#import <FBSDKLoginKit/FBSDKLoginManagerLoginResult.h>

@interface LoginViewController : UIViewController
- (IBAction)close:(id)sender;
@property (strong, nonatomic) IBOutlet FBSDKLoginButton *loginButton;

@property (strong, nonatomic) IBOutlet UIButton *closeBtn;
@end
