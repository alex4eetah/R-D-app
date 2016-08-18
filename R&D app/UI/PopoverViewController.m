//
//  PopoverViewController.m
//  R&D app
//
//  Created by Oleksandr Chechetkin on 8/17/16.
//  Copyright © 2016 softserve. All rights reserved.
//

#import "PopoverViewController.h"

@interface PopoverViewController ()

@property (strong, nonatomic) UIButton *logOutButt;
@property (strong, nonatomic) UIButton *changePassButt;

@end

@implementation PopoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.logOutButt = [[UIButton alloc] initWithFrame:CGRectMake(8, 8, self.view.frame.size.width-16, 30)];
    [self.logOutButt addTarget:self action:@selector(logOut:) forControlEvents:UIControlEventTouchUpInside];
    self.logOutButt.backgroundColor = [UIColor blackColor];
    [self.logOutButt setTitle:@"Log out" forState:UIControlStateNormal];
    //[self.logOutButt.titleLabel setFont:[UIFont fontWithName:@"MuseoSansCyrl-700" size:16]];
    [self.logOutButt.titleLabel setTextColor:[UIColor greenColor]];//[UIColor colorWithRed:155/255 green:155/255 blue:155/255 alpha:1]];
    [self.view addSubview:self.logOutButt];
    
    self.changePassButt = [[UIButton alloc] initWithFrame:CGRectMake(8, 8 + 8 + 30, self.view.frame.size.width-16, 30)];
    [self.changePassButt addTarget:self action:@selector(changePass:) forControlEvents:UIControlEventTouchUpInside];
    self.changePassButt.backgroundColor = [UIColor greenColor];
    [self.changePassButt setTitle:@"Change password" forState:UIControlStateNormal];
    [self.changePassButt.titleLabel setFont:[UIFont fontWithName:@"MuseoSansCyrl-700" size:16]];
    [self.changePassButt.titleLabel setTextColor:[UIColor blackColor]];
    [self.view addSubview:self.changePassButt];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)logOut:(UIButton *)sender {
//LOGOUT
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.delegate dismissToRoot];
}

- (void)changePass:(UIButton *)sender {

    [self dismissViewControllerAnimated:NO completion:nil];
    [self.delegate showChangePasswordModal];
    
}

@end
