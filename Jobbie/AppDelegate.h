//
//  AppDelegate.h
//  Navigation
//
//  Created by Tammy Coron on 1/19/13.
//  Copyright (c) 2013 Tammy L Coron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Classes/Network/Messenger.h"
#import "Model.h"
#import "AFNetworkActivityIndicatorManager.h"

@class MainViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MainViewController *viewController;
@property (strong, nonatomic) Model* model;

@property (strong, nonatomic) Messenger* messenger;

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator ;


-(NSURLSessionDataTask*)handleGETRequestToPath:(NSString*)path toServer:(int)server;

@end
