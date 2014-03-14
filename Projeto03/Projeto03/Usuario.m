//
//  Usuario.m
//  Projeto03
//
//  Created by Luiz Fernando Silva on 11/03/14.
//  Copyright (c) 2014 ARTHUR HENRIQUE VIEIRA DE OLIVEIRA. All rights reserved.
//

#import "Usuario.h"

@implementation Usuario

- (id)initWithNomeAndAvatar:(NSString *)nome avatar:(UIImage *)avatar
{
    self = [super init];
    if (self)
    {
        [self set_nome:nome];
        [self set_avatar:avatar];
    }
    return self;
}

- (Usuario*)clonar
{
    Usuario *usuario = [[Usuario alloc] initWithNomeAndAvatar:self._nome avatar:self._avatar];
    usuario._id = self._id;
    
    return usuario;
}

- (void)copiarCamposDe:(Usuario*)usuario
{
    self._nome = usuario._nome;
    self._avatar = usuario._avatar;
    self._id = usuario._id;
}

@end