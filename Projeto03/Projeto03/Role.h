//
//  Roles.h
//  Projeto03
//
//  Created by ARTHUR HENRIQUE VIEIRA DE OLIVEIRA on 11/03/14.
//  Copyright (c) 2014 ARTHUR HENRIQUE VIEIRA DE OLIVEIRA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Usuario.h"
#import "Endereco.h"

@interface Role : NSObject

@property Usuario *dono;
@property Endereco *endereco;
@property NSString *descricao;
@property NSDate *data;
@property NSMutableArray *convidados; // mutable array de objetos do tipo 'Usuario'
@property BOOL publico;

- (id)initWithDono:(Usuario *)dono andEndereco:(Endereco *)endereco;

@end