//
//  Roles.m
//  Projeto03
//
//  Created by ARTHUR HENRIQUE VIEIRA DE OLIVEIRA on 11/03/14.
//  Copyright (c) 2014 ARTHUR HENRIQUE VIEIRA DE OLIVEIRA. All rights reserved.
//

#import "Role.h"

@implementation Role

/*
 @property Usuario *dono;
 @property Endereco *endereco;
 @property NSString *descricao;
 @property NSDate *data;
 @property NSMutableArray *convidados; // mutable array de objetos do tipo 'Usuario'
 @property BOOL publico;
 @property int _id;
 */

- (Role*)clonar
{
    Role *novoRole = [[Role alloc] init];
    
    novoRole.dono = self.dono;
    novoRole.endereco = self.endereco;
    novoRole.data = self.data;
    novoRole.convidados = self.convidados;
    novoRole.publico = self.publico;
    novoRole._id = self._id;
    
    return novoRole;
}

@end