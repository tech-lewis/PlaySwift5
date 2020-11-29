//
//  ViewController.m
//  WebService
//
//  Created by mac on 22.11.20.
//  Copyright © 2020 mac. All rights reserved.
//

#import "ViewController.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import "HTTPServer.h"
#import "DDLog.h"
#import "DDTTYLogger.h"
#import "MyHTTPConnection.h"
@interface ViewController ()
@property (nonatomic, strong) HTTPServer * httpServer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor grayColor];
    [self setupWebService];
}

- (void)setupWebService {
    _httpServer = [[HTTPServer alloc] init];
       [_httpServer setPort:1234];
       [_httpServer setType:@"_http._tcp."];
       // webPath是server搜寻HTML等文件的路径
       NSString * webPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"web"];
       [_httpServer setDocumentRoot:webPath];
       [_httpServer setConnectionClass:[MyHTTPConnection class]];
       NSError *err;
       if ([_httpServer start:&err]) {
           NSLog(@"port %hu",[_httpServer listeningPort]);
       }else{
           NSLog(@"%@",err);
       }
       NSString *ipStr = [self getIpAddresses];
       NSLog(@"ip地址 %@", ipStr);
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"IP"
                              message:[NSString stringWithFormat:@"ip地址 %@:%i",  ipStr,[_httpServer listeningPort]] delegate:nil cancelButtonTitle:@"Done" otherButtonTitles: nil];
    [alertView show];
}

- (NSString *)getIpAddresses{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0)
    {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL)
        {
            if(temp_addr->ifa_addr->sa_family == AF_INET)
            {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])
                {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}
@end
