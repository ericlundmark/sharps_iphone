//
//  Connection.m
//  Sharps 1
//
//  Created by Eric Lundmark on 2012-01-29.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Connection.h"

@implementation Connection
@synthesize _request;
-(id)initWithRequest:(Request *)request{
    _request=request;
    self=[super initWithRequest:request delegate:self];
    return self;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [_request.delegate performSelector:_request.didFailSelector withObject:self._request];
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse.
    
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    _request.responseData=nil;
    // receivedData is an instance variable declared elsewhere.
    
    [_request.delegate performSelector:_request.didStartSelector withObject:self._request];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    if (!_request.responseData) {
        _request.responseData=[[NSMutableData alloc] initWithData:data];
    }else{
        [_request.responseData appendData:data];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    _request.responseString=[[NSMutableString alloc] initWithData:_request.responseData encoding:NSUTF8StringEncoding ];
    [_request.delegate performSelector:_request.didFinishSelector withObject:self._request];
}

@end
