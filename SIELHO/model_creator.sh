#!/bin/bash

rails g model tipo_documento regla:string nombre:string tipoPersona:integer fechaCrear:datetime fechaMod:datetime usuarioRes:integer usuarioMod:integer

rails g model documento numero:string fechaCrear:datetime fechaMod:datetime usuarioRes:integer usuarioMod:integer

rails g model solicitante nombre:string documento_id:integer tipo_solicitante:integer modo_contacto:text ocupacion_id:integer genero:string nivel_educativo:string telefono:string email:string direccion_postal:text fax:string poder:string  fechaCrear:datetime fechaMod:datetime usuarioRes:integer usuarioMod:integer

rails g model estado nombre:string descripcion:text fechaCrear:datetime fechaMod:datetime usuarioRes:integer usuarioMod:integer

rails g model asignacion enlace_id:integer descripcion:text fechaInic:datetime expediente_id:integer fechaCrear:datetime fechaMod:datetime usuarioRes:integer usuarioMod:integer

rails g model departamento institucion_id:integer descripcion:text nombre:string enlace_id:integer fechaCrear:datetime fechaMod:datetime usuarioRes:integer usuarioMod:integer

rails g model enlace usuario_id:integer departamento_id:integer institucion_id:integer pnombre:string snombre:string papellido:string sapellido:string email:string email2:string tlf:string fechaCrear:datetime fechaMod:datetime usuarioRes:integer usuarioMod:integer

rails g model oip usuario_id:integer institucion_id:integer pnombre:string snombre:string papellido:string sapellido:string email:string email2:string tlf:string fechaCrear:datetime fechaMod:datetime usuarioRes:integer usuarioMod:integer

rails g model institucion oip_id:integer descripcion:text nombre:string tipo_institucion:string fechaCrear:datetime fechaMod:datetime usuarioRes:integer usuarioMod:integer

rails g model rol nombre:string descripcion:text fechaCrear:datetime fechaMod:datetime usuarioRes:integer usuarioMod:integer

rails g model permiso nombre:string descripcion:text fechaCrear:datetime fechaMod:datetime usuarioRes:integer usuarioMod:integer

rails g model administrador usuario_id:integer pnombre:string snombre:string papellido:string sapellido:string email:string email2:string tlf:string fechaCrear:datetime fechaMod:datetime usuarioRes:integer usuarioMod:integer

rails g model mensaje emisor_id:integer destinatario_id:integer titulo:string texto:text documento_adjunto:binary fecha:datetime expediente_id:integer fechaCrear:datetime fechaMod:datetime usuarioRes:integer usuarioMod:integer


rails g model clasificacion nombre:string descripcion:text fechaCrear:datetime fechaMod:datetime usuarioRes:integer usuarioMod:integer

rails g model ocupacion nombre:string fechaCrear:datetime fechaMod:datetime usuarioRes:integer usuarioMod:integer

rails g model solicitud solicitante_id:integer descripcion:text institucion_id:integer fecha:datetime clasificacion_id:integer expediente_id:integer fechaCrear:datetime fechaMod:datetime usuarioRes:integer usuarioMod:integer

rails g model expediente estado_id:integer solicitud_id:integer creador:integer fechaEntrega:datetime fechaEmision:datetime fechaCrear:datetime fechaMod:datetime usuarioRes:integer usuarioMod:integer

rails g model justificacion descripcion:text fecha_cambio:datetime fechaCrear:datetime fechaMod:datetime usuarioRes:integer usuarioMod:integer

rails g model ley_acuerdo noLey:string noAcuerdo:string fechaGaceta:datetime  fechaCrear:datetime fechaMod:datetime usuarioRes:integer usuarioMod:integer


rails g migration create_rols_permisos 
rails g migration create_justificacions_ley_acuerdos
rails g migration create_estados_estados


