//
//  WebVIewController.m
//  R&D app
//
//  Created by Oleksandr Chechetkin on 8/18/16.
//  Copyright © 2016 softserve. All rights reserved.
//

#import "WebVIewController.h"

#import "Reachability.h"

@interface WebVIewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

//@property (strong, nonatomic) Reachability *reachabilityManager;

@end

@implementation WebVIewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.reachabilityManager = [Reachability reachabilityForInternetConnection];
    
    NSString *urlAddress = self.url;
    NSURL *url = [NSURL URLWithString:urlAddress];
    self.webView.delegate = self;
    if (!urlAddress || [urlAddress isEqualToString:@""] || [urlAddress isEqualToString:@" "]) {
        [self.webView loadHTMLString:@"<HTML><h1>Something went wrong...</h1></HTML>" baseURL:[NSURL URLWithString:@"Something went wrong..."]];
    } else {
       /* if (self.reachabilityManager.currentReachabilityStatus == NotReachable) {
            [self.webView loadHTMLString:self.cache baseURL:url];
        } else {*/
                NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
                [self.webView loadRequest:requestObj];
        //}
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}
@end
