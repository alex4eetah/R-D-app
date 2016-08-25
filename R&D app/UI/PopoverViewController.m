//
//  PopoverViewController.m
//  R&D app
//
//  Created by Oleksandr Chechetkin on 8/17/16.
//  Copyright © 2016 softserve. All rights reserved.
//

#import "PopoverViewController.h"
#import "RDServerManager.h"

@interface PopoverViewController ()

@property (weak, nonatomic) IBOutlet UIButton *logOutButt;
@property (weak, nonatomic) IBOutlet UIButton *changePassButt;
@property (strong, nonatomic) RDServerManager *serverManager;

@end

@implementation PopoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.logOutButt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.changePassButt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    self.serverManager = [RDServerManager sharedManager];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)logOut:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.serverManager logOutWithCompletion:^(BOOL done) {
        [self.delegate dismissToRoot];
    }];
}
- (IBAction)changePass:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.delegate showChangePasswordModal];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*//*
- (ction)logOut:(UIButton *)sender {
//LOGOUT
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.delegate dismissToRoot];
}

- (void)changePass:(UIButton *)sender {

    [self dismissViewControllerAnimated:NO completion:nil];
    [self.delegate showChangePasswordModal];
    
}*/

@end
