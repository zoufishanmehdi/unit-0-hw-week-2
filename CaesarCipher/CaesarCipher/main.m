//
//  main.m
//  CaesarCipher
//
//  Created by Michael Kavouras on 6/21/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaesarCipher : NSObject

- (NSString *)decode:(NSString *)string offset:(int)offset;
- (NSString *)encode:(NSString *)string offset:(int)offset;

@end

@implementation CaesarCipher

- (NSString *)encode:(NSString *)string offset:(int)offset {
    unsigned long count = [string length];
    unichar result[count];
    unichar buffer[count];
    [string getCharacters:buffer range:NSMakeRange(0, count)];
    
    for (int i = 0; i < count; i++) {
        if (buffer[i] == ' ') {
            result[i] = buffer[i];
            continue;
        }
        
        int low = islower(buffer[i]) ? 'a' : 'A';
        int high = islower(buffer[i]) ? 'z' : 'Z';
        BOOL wrap = buffer[i] + offset > high || buffer[i] + offset < low;
        
        result[i] = wrap ? ((buffer[i] + offset) % high) + (low - 1) : buffer[i] + offset;
    }
    
    return [NSString stringWithCharacters:result length:count];
}

- (NSString *)decode:(NSString *)string offset:(int)offset {
    return [self encode:string offset:26 - offset];
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
       

    }
}