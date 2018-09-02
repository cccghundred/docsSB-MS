# Manual de MongoDB

## Instalación

1. Ingresar a la página oficial de [MongoDB][MongoDB] y hacer clic en la opción _"Get MongoDB"_

    ![Pagina Mongo](/imgs/instalacion/PaginaMongo.png)

2. Seleccionar la opción _"Community Server"_ y hacer clic en _"DOWNLOAD (msi)"_
   
    ![Download](/imgs/instalacion/DownloadServer.png)

3. Esperar a que finalice la descarga.

    ![Waiting](/imgs/instalacion/ProcesoDescarga.png)

4. Ejecutar el archivo _"mongodb-win32-x86_64-2008plus-ssl-4.0.1-signed.msi"_

5. Hacer clic en Next 

    ![Paso 1](/imgs/instalacion/Paso1.png)

6. Marcar el check _"I accept the terms in the License Agreement"_ y hacer clic en Next:

    ![Paso 2](/imgs/instalacion/Paso2.png)

7. Seleccionar la opción _Complete_:

    ![Paso 3](/imgs/instalacion/Paso3.png)

8. Desmarcar el check _"Install MongoD as a Service"_ y hacer clic en Next:

    ![Paso 4](/imgs/instalacion/Paso4.png)

9. Marcar el check _"Install MongoDB Compass"_ y hacer clic en Next:

    ![Paso 5](/imgs/instalacion/Paso5.png)

10. Hacer clic en Install:

    ![Paso 6](/imgs/instalacion/Paso6.png)

11. Esperar a que finalice la instalación:
    
    ![Paso 7](/imgs/instalacion/Paso7.png)

12. Si durante el proceso de instalación aparece el siguiente mensaje, hacer clic en Ignore:
    
    ![Paso 8](/imgs/instalacion/Paso8.png)

13. Hacer clic en Finish
    
    ![Paso 9](/imgs/instalacion/Paso9.png)

14. Hacer clic derecho en el archivo _"CrearVariable.cmd"_ y seleccionar la opción _"Ejecutar como administrador"_
    
    ![Paso 10](/imgs/instalacion/CreaVariableEntorno.png)

15. Para verificar la correcta configuración de la variable de entorno; abrir una consola de comandos, escribir lo siguiente y presionar la tecla Enter:
```CMD
   mongo --version
```
14. Si está correctamente configurado, se mostrará lo siguiente:
    
    ![Paso 11](/imgs/instalacion/MongoVersion.png)
    
## Cliente NoSql Booster
1. Ingresar a la página de [NoSQL Booster][Booster] y hacer clic en _Downloads_
   
    ![Booster 1](/imgs/instalacion/BoosterDownload.png)
	
2. Hacer clic en el botón _Download_ de la sección correspondiente al sistema operativo que este utilizando:
   
    ![Booster 2](/imgs/instalacion/BoosterDownload2.png)
	
3. Ir a la ruta de descarga y hacer doble clic en el instalador _"nosqlbooster4mongo-4.7.1.exe"_:
   
    ![Booster 3](/imgs/instalacion/BoosterInstall.png)
	
4. Esperar a que finalice la instalación:
   
    ![Booster 4](/imgs/instalacion/BoosterInstall2.png)
	
5. Se mostrará la ventana de la apliación _NoSQL Booster_ con el formulario para administrar conexiones con MongoDB
   
    ![Booster 5](/imgs/instalacion/BoosterFinal.png)
	
6. Hacer clic en el botón _"From URI"_
   
    ![Booster 6](/imgs/instalacion/Conexion1.png)
	
7. Colocar la siguiente cadena de conexión, correspondiente a MongoDB QAs, y hacer clic en OK:
```Conn
mongodb+srv://usrmongotddev:Mongo2018@personalizacionqas-xfhrx.mongodb.net/?authSource=admin&ssl=true
```
![Booster 7](/imgs/instalacion/Conexion2.png)

8. Finalmente, hacer clic en  _"Save & Connect"_
   
    ![ Booster 8](/imgs/instalacion/Conexion3.png)

## [Consultas NoSQL][Documentacion MongoDB]

### Insertar documentos
```MongoDB
//Inserta documentos en la colección orders
db.orders.insert([
   { "item" : "almonds", "price" : 12, "quantity" : 2 },
   { "item" : "pecans", "price" : 20, "quantity" : 1 },
   //Inserta documento vacío
   { }
])

//Inserta documentos en la colección inventory
db.inventory.insert([
   { "sku" : "almonds", description: "product 1", "instock" : 120 },
   { "sku" : "bread", description: "product 2", "instock" : 80 },
   { "sku" : "cashews", description: "product 3", "instock" : 60 },
   { "sku" : "pecans", description: "product 4", "instock" : 70 },
   { "sku": null, description: "Incomplete" },
   {  }
])
```

### Consultar datos
Consultar todos los documentos de una colección
```MongoDB
db.inventory.find({})
db.orders.find({})
```

![ Booster 8](/imgs/ConsultarInventory.png)
    
![ Booster 8](/imgs/ConsultarOrders.png)


Consultar por campos

```MongoDB
//Consultar solo el campo description de la tabla inventory
db.inventory.find({},{
    description:1
})

//Ocultar el campo _id, que siempre se muestra por defecto
db.inventory.find({},{
    description:1,
    _id: 0
})
```
![ Booster 8](/imgs/FiltroDescripcion1.png)

![ Booster 8](/imgs/FiltroDescripcion2.png)

Realizar un lookup (Join SQL)

```MongoDB
db.orders.aggregate([
   {
     $lookup:
       {
         from: "inventory",
         localField: "item",
         foreignField: "sku",
         as: "inventory_docs"
       }
  }
])
```
![ Booster 8](/imgs/ConsultaJoin.png)

Filtrar por campos

```MongoDB
//Filtra las estrategias de la campaña 201811 y con codigo 2003
db.Estrategia.find({
    CodigoCampania: '201811',
    CodigoEstrategia: 2003
},
{
	//Oculta la columna _id
    _id: 0
})

//Filtra las estrategias de la campaña 201811 y que contengan algún tono con cuv 30916
db.Estrategia.find({
    CodigoCampania: '201811',
    "Tonos.Cuv": "30916"
},
{
    _id: 0
})
```

Operadores de comparación
```MongoDB
//Lista estrategias de la campaña 201811 con precio mayor a 25
db.Estrategia.find({
    CodigoCampania: '201811',
    Precio: {$gt: 25.0}
})

//Lista estrategias de la campaña 201811 con precio menor o igual a 25
db.Estrategia.find({
    CodigoCampania: '201811',
    Precio: {$lte: 25.0}
})

//Lista estrategias de la campaña 201811 con Codigo Estrategia 2001 ó 2003
db.Estrategia.find({
    CodigoCampania: '201811',
    CodigoEstrategia: { $in: [2001,2003] }
})

//Lista estrategias de la campaña 201811 con Codigo Estrategia diferente a 2002
db.Estrategia.find({
    CodigoCampania: '201811',
    CodigoEstrategia: { $ne: 2002 }
})

//Lista estrategias de la campaña 201811 con Codigo Estrategia diferente a 2001 ó 2003
db.Estrategia.find({
    CodigoCampania: '201811',
    CodigoEstrategia: { $nin: [2001,2003] }
})
```

Operadores lógicos
```MongoDB
//Operador And
db.Estrategia.find({
    $and:
    //Lista de condiciones
    [
        {CodigoCampania: '201811'},
        {Activo: true}
    ]
})

//Operador Or
db.Estrategia.find({
    $or:
    //Lista de condiciones
    [
        {CodigoTipoEstrategia: '007'},
        {CodigoTipoEstrategia: '008'}
    ]
})
```

### Actualizar documentos

```MongoDB
//Cambia los campos Activo y TextoLibre de las estrategias de la campaña 201811 
//y tipo de estrategia 009
db.Estrategia.update(
	//Filtro de documentos a actualizar
    {
        CodigoCampania: '201811',
        CodigoTipoEstrategia: '009'
    },
    //Campos que se van a actualizar
    {    	
    	$set:
        {
            Activo: true,
            TextoLibre: 'Oferta último minuto'
        }
    },
{ 
//Indica si se actualizarán varios registros o solo el primero que se encuentre
multi: true,
//Si es verdadero y no encuentra el registro para actualizar, lo inserta
upsert: false
})
```
### Remover documentos 
```MongoDB
//Remueve todos los documentos con estado activo falso y tipo de estrategia 030
db.Estrategia.remove(
    //Filtros de los documentos a remover
    {
        Activo: false,
        CodigoTipoEstrategia: '030'
    },
    //Indica si se eliminarán varios documentos o solo el primero que encuentre 
    {justOne: false}
)

//Remueve todos los documentos de una colección
db.inventory.remove({})
db.orders.remove({})
```
[MongoDB]: https://www.mongodb.com/
[Booster]: https://nosqlbooster.com/home
[Documentacion MongoDB]: https://docs.mongodb.com/manual/reference/operator/query/