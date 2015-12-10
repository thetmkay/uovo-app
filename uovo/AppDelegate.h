//
//  AppDelegate.h
//  uovo
//
//  Created by George Nishimura on 07/12/2015.
//  Copyright © 2015 ytil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "DATAStack/DATAStack.h"
#import "AFNetworking/AFNetworking.h"
#import "UovoService.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) DATAStack *dataStack;

@property (strong, nonatomic) AFHTTPSessionManager * manager;

@end

