//
//  NetworkMediatorDelegate.h
//  sharps
//
//  Created by Eric Lundmark on 2012-01-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol LoginDelegate<NSURLConnectionDelegate>
-(void)loginDidSucceed:(BOOL)succeeded;
@end
