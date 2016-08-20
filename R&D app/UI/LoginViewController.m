//
//  LoginViewController.m
//  R&D app
//
//  Created by AlexCheetah on 8/9/16.
//  Copyright © 2016 softserve. All rights reserved.
//

#import "UiUtil.h"
#import "LoginViewController.h"
#import "RDServerManager.h"

@interface LoginViewController ()

@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *potraitConstraints;

@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *landscapeConstraints;

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (strong, nonatomic) UiUtil *animator;

@property (strong, nonatomic) RDServerManager *serverManager;

@property (assign, nonatomic) BOOL isInLandscape;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureSelf];
}

- (void)configureSelf
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChange:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    self.animator = [UiUtil sharedUtil];
    self.isInLandscape = (self.view.frame.size.width > self.view.frame.size.height);;
    [self.animator animateConstraintsChangingToOrientation: self.isInLandscape? Landscape: Portrait
                                         ForViewController:self];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    self.serverManager = [RDServerManager sharedManager];
}

/*
**** Visual configuration
*/

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    self.isInLandscape = (size.width > size.height);
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {

        [self.animator animateConstraintsChangingToOrientation: self.isInLandscape? Landscape: Portrait
                                             ForViewController:self];
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {

    }];
}

- (void)keyboardWillChange:(NSNotification *)notification
{
    if (self.view.frame.origin.y == 0 && self.isInLandscape) {
        NSDictionary* keyboardInfo = [notification userInfo];
        NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
        CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
        double keyboardHeight = keyboardFrameBeginRect.size.height;
        [self.animator animateChangingOfFrameForView:self.view
                                             ToValue:CGRectMake(self.view.frame.origin.x,
                                                                -keyboardHeight,
                                                                self.view.frame.size.width,
                                                                self.view.frame.size.height)
                                        WithDuration:0.1];
    }
}

-(void)keyboardWillHide
{
    if (self.view.frame.origin.y != 0) {
        [self.animator animateChangingOfFrameForView:self.view
                                             ToValue:CGRectMake(self.view.frame.origin.x,
                                                                0,
                                                                self.view.frame.size.width,
                                                                self.view.frame.size.height)
                                        WithDuration:0.1];
    }
}

-(void)dismissKeyboard
{
    [self.view endEditing:YES];
}

/*
**** action implementation
*/

- (IBAction)SignInButtonBeenPressed:(UIButton *)sender
{
    NSString *email = self.emailTextField.text;
    NSString *pass = self.passwordTextField.text;
    if ([email isEqualToString: @""] || [email isEqualToString:@" "]) {
        [self.animator animateWrongInputOnLayer:self.emailTextField.layer];
    } else if ([pass isEqualToString: @""] || [pass isEqualToString:@" "]) {
        [self.animator animateWrongInputOnLayer:self.passwordTextField.layer];
    } else {
        [self.serverManager authorizeUserWithCredentials:@{@"Login":email, @"Password":pass} Completion:^(BOOL done) {
            if (done == YES) {
                self.emailTextField.text = nil;
                self.passwordTextField.text = nil;
                [self performSegueWithIdentifier:@"LoggedInSegue" sender:self];
            } else {
                [self.animator animateWrongInputOnLayer:self.emailTextField.layer];
                [self.animator animateWrongInputOnLayer:self.passwordTextField.layer];
            }
        }];
    }
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
