//
//  WebVIewController.m
//  R&D app
//
//  Created by Oleksandr Chechetkin on 8/18/16.
//  Copyright © 2016 softserve. All rights reserved.
//

#import "WebVIewController.h"

@interface WebVIewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebVIewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *urlAddress = self.url;
    NSURL *url = [NSURL URLWithString:urlAddress];
    self.webView.delegate = self;
    
    if (self.cache) {
        [self.webView loadHTMLString:self.cache baseURL:url];
    } else if (self.url) {
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:requestObj];
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
