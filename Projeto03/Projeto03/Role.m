//
//  Roles.m
//  Projeto03
//
//  Created by ARTHUR HENRIQUE VIEIRA DE OLIVEIRA on 11/03/14.
//  Copyright (c) 2014 ARTHUR HENRIQUE VIEIRA DE OLIVEIRA. All rights reserved.
//

#import "Role.h"

@implementation Role

- (id)initWithDono:(Usuario *)dono andEndereco:(Endereco *)endereco
{
    self = [super init];
    if (self)
    {
        [self setDono:dono];
        [self setEndereco:endereco];
    }
    return self;
}

@end