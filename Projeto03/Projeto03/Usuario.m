//
//  Usuario.m
//  Projeto03
//
//  Created by Luiz Fernando Silva on 11/03/14.
//  Copyright (c) 2014 ARTHUR HENRIQUE VIEIRA DE OLIVEIRA. All rights reserved.
//

#import "Usuario.h"

@implementation Usuario

- (id)initWithNomeAndAvatar:(NSString *)nome:(UIImage *)avatar
{
    self = [super init];
    if (self)
    {
        [self setNome:nome];
        [self setAvatar:avatar];
    }
    return self;
}

@end