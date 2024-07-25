

![alt text](<img/Captura desde 2024-07-23 12-50-23.png>)

# Casos de Uso para la Base de Datos

###    Caso de Uso 1: Gestión de Inventario de Bicicletas

**Descripción: Este caso de uso describe cómo el sistema gestiona el inventario de bicicletas,**
**permitiendo agregar nuevas bicicletas, actualizar la información existente y eliminar bicicletas que**
**ya no están disponibles.**

##### Actores:

Administrador de Inventario

##### Flujo Principal: 

1. El administrador de inventario ingresa al sistema.

2. El administrador selecciona la opción para agregar una nueva bicicleta.

3. El administrador ingresa los detalles de la bicicleta (modelo, marca, precio, stock).

   ```sql
   INSERT INTO bike (id_bike_model,id_bike_brand, price, stock) VALUES (5, 5, 2200.00, 6);
   ```

4. El sistema valida y guarda la información de la nueva bicicleta.

5. El administrador selecciona una bicicleta existente para actualizar.

6. El administrador actualiza la información (precio, stock).

   ```sql
   UPDATE bike
   SET price=1800 ,stock=25
   WHERE id=?;
   ```

7. El sistema valida y guarda los cambios.

8. El administrador selecciona una bicicleta para eliminar.

   ```SQL
   DELETE FROM bike WHERE id=?;
   ```

9. El sistema elimina la bicicleta seleccionada del inventario.

### Caso de Uso 2: Registro de Ventas

**Descripción: Este caso de uso describe el proceso de registro de una venta de bicicletas,**

**incluyendo la creación de una nueva venta, la selección de las bicicletas vendidas y el cálculo del**
**total de la venta.**

##### Actores:

Vendedor

##### Flujo Principal:

1. El vendedor ingresa al sistema.

2. El vendedor selecciona la opción para registrar una nueva venta.

3. El vendedor selecciona el cliente que realiza la compra.

   ```sql
   INSERT INTO sale (sale_date,id_customer,total) VALUES (NOW(),?,0);
   ```

4. El vendedor selecciona las bicicletas que el cliente desea comprar y especifica la cantidad.

   ```sql
   INSERT INTO sale_detail (id_sale,id_bike,amount,unit_price) VALUES (?,?,?,?);
   ```

5. El sistema calcula el total de la venta.

   ```java
   float newtotal=amount*unit_price;
   ```

6. El vendedor confirma la venta.

7. El sistema guarda la venta y actualiza el inventario de bicicletas.

   ```sql
   UPDATE sale 
   SET total=newtotal
   WHERE id=?;
   
   newstock=stock-amount
   
   UPDATE bike
   SET stock=newstock
   WHERE id=?;
   ```

### Caso de Uso 3: Gestión de Proveedores y Repuestos

**Descripción: Este caso de uso describe cómo el sistema gestiona la información de proveedores y**
**repuestos, permitiendo agregar nuevos proveedores y repuestos, actualizar la información**
**existente y eliminar proveedores y repuestos que ya no están activos.**

##### Actores:

Administrador de Proveedores

##### Flujo Principal:

1. El administrador de proveedores ingresa al sistema.

2. El administrador selecciona la opción para agregar un nuevo proveedor.

3. El administrador ingresa los detalles del proveedor (nombre, contacto, teléfono, correo
    electrónico, ciudad).

    ```sql
    INSERT INTO supplier (supplier_name,contact_name,phone,email,id_city) VALUES
    (? ,? ,? ,? ,? );
    ```

4. El sistema valida y guarda la información del nuevo proveedor.

5. El administrador selecciona la opción para agregar un nuevo repuesto.

6. El administrador ingresa los detalles del repuesto (nombre, descripción, precio, stock,
    proveedor).

    ```sql
    INSERT INTO replacement (replacement_name,replacement_description,price,stock,id_supplier) VALUES
    (? ,? ,? ,? ,? );
    ```

7. El sistema valida y guarda la información del nuevo repuesto.

8. El administrador selecciona un proveedor existente para actualizar.

9. El administrador actualiza la información del proveedor.

    ```sql
    UPDATE supplier
    SET supplier_name=? ,contact_name=? ,phone=? ,email=? ,id_city=?
    WHERE id=?;
    ```

10. El sistema valida y guarda los cambios.

11. El administrador selecciona un repuesto existente para actualizar.

12. El administrador actualiza la información del repuesto.

     ```sql
     UPDATE replacement
     SET replacement_name=? ,replacement_description=? ,price,stock=? ,id_supplier=?
     WHERE id=?;
     ```

13. El sistema valida y guarda los cambios.

14. El administrador selecciona un proveedor para eliminar.

     ```sql
     DELETE supplier WHERE id=?;
     ```

15. El sistema elimina el proveedor seleccionado.

16. El administrador selecciona un repuesto para eliminar.

     ```sql
     DELETE replacement WHERE id=?;
     ```

17. El sistema elimina el repuesto seleccionado.

### Caso de Uso 4: Consulta de Historial de Ventas por Cliente

**Descripción: Este caso de uso describe cómo el sistema permite a un usuario consultar el**
**historial de ventas de un cliente específico, mostrando todas las compras realizadas por el cliente**
**y los detalles de cada venta.**

##### Actores:

Vendedor
Administrador

##### Flujo Principal:

1. El usuario ingresa al sistema.

2. El usuario selecciona la opción para consultar el historial de ventas.

3. El usuario selecciona el cliente del cual desea ver el historial.

4. El sistema muestra todas las ventas realizadas por el cliente seleccionado.

    ```sql
    SELECT 
    	id,
    	sale_date,
    	total
    FROM
    	sale
    WHERE
    	id_customer=?;
    ```

5. El usuario selecciona una venta específica para ver los detalles.

6. El sistema muestra los detalles de la venta seleccionada (bicicletas compradas, cantidad,
    precio).

    ```sql
    SELECT
    	sd.id,
    	b.id_bike_model,
        b.id_bike_brand,
        sd.amount,
        s.total
    FROM sale_detail sd
    JOIN sale s ON s.id = sd.id_sale
    JOIN bike b ON b.id = sd.id_bike
    WHERE id_sale=?;
    ```

    

### Caso de Uso 5: Gestión de Compras de Repuestos

Descripción: Este caso de uso describe cómo el sistema gestiona las compras de repuestos a
proveedores, permitiendo registrar una nueva compra, especificar los repuestos comprados y
actualizar el stock de repuestos.

##### Actores:

Administrador de Compras

##### Flujo Principal:

1. El administrador de compras ingresa al sistema.

2. El administrador selecciona la opción para registrar una nueva compra.

3. El administrador selecciona el proveedor al que se realizó la compra.

4. El administrador ingresa los detalles de la compra (fecha, total).

    ```sql
    INSERT INTO purchase (purchase_date, id_supplier, total) VALUES (?,?,?);
    ```

5. El sistema guarda la compra y genera un identificador único.

6. El administrador selecciona los repuestos comprados y especifica la cantidad y el precio
    unitario.

    ```sql
    INSERT INTO purchase_detail ()
    ```

7. El sistema guarda los detalles de la compra y actualiza el stock de los repuestos comprados.

## Casos de Uso con Subconsultas

### Caso de Uso 6: Consulta de Bicicletas Más Vendidas por Marca

**Descripción: Este caso de uso describe cómo el sistema permite a un usuario consultar las**
**bicicletas más vendidas por cada marca.**

##### Actores:

Vendedor
Administrador

##### Flujo Principal:

1. El usuario ingresa al sistema.
2. El usuario selecciona la opción para consultar las bicicletas más vendidas por marca.
3. El sistema muestra una lista de marcas y el modelo de bicicleta más vendido para cada
    marca.

### Caso de Uso 7: Clientes con Mayor Gasto en un Año Específico

**Descripción: Este caso de uso describe cómo el sistema permite consultar los clientes que han**
**gastado más en un año específico.**

##### Actores:

Administrador

##### Flujo Principal:

1. El administrador ingresa al sistema.
2. El administrador selecciona la opción para consultar los clientes con mayor gasto en un año
    específico.
3. El administrador ingresa el año deseado.
4. El sistema muestra una lista de los clientes que han gastado más en ese año, ordenados por
    total gastado.

### Caso de Uso 8: Proveedores con Más Compras en el Último Mes

**Descripción: Este caso de uso describe cómo el sistema permite consultar los proveedores que**
**han recibido más compras en el último mes.**

##### Actores:

Administrador de Compras

##### Flujo Principal:

1. El administrador de compras ingresa al sistema.
2. El administrador selecciona la opción para consultar los proveedores con más compras en el
    último mes.
3. El sistema muestra una lista de proveedores ordenados por el número de compras recibidas
    en el último mes.

### Caso de Uso 9: Repuestos con Menor Rotación en el Inventario

**Descripción: Este caso de uso describe cómo el sistema permite consultar los repuestos que han**
**tenido menor rotación en el inventario, es decir, los menos vendidos.**

##### Actores:

Administrador de Inventario

##### Flujo Principal:

1. El administrador de inventario ingresa al sistema.
2. El administrador selecciona la opción para consultar los repuestos con menor rotación.
3. El sistema muestra una lista de repuestos ordenados por la cantidad vendida, de menor a
    mayor.

### Caso de Uso 10: Ciudades con Más Ventas Realizadas

**Descripción: Este caso de uso describe cómo el sistema permite consultar las ciudades donde se**
**han realizado más ventas de bicicletas.**

##### Actores:

Administrador

##### Flujo Principal:

1. El administrador ingresa al sistema.
2. El administrador selecciona la opción para consultar las ciudades con más ventas realizadas.
3. El sistema muestra una lista de ciudades ordenadas por la cantidad de ventas realizadas.
    Casos de Uso con Joins

### Caso de Uso 11: Consulta de Ventas por Ciudad

**Descripción: Este caso de uso describe cómo el sistema permite consultar el total de ventas**
**realizadas en cada ciudad.**

##### Actores:

Administrador

##### Flujo Principal:

1. El administrador ingresa al sistema.
2. El administrador selecciona la opción para consultar las ventas por ciudad.
3. El sistema muestra una lista de ciudades con el total de ventas realizadas en cada una.

### Caso de Uso 12: Consulta de Proveedores por País

**Descripción: Este caso de uso describe cómo el sistema permite consultar los proveedores**
**agrupados por país.**

##### Actores:

Administrador de Compras

##### Flujo Principal:

1. El administrador de compras ingresa al sistema.
2. El administrador selecciona la opción para consultar los proveedores por país.
3. El sistema muestra una lista de países con los proveedores en cada país.

### Caso de Uso 13: Compras de Repuestos por Proveedor

**Descripción: Este caso de uso describe cómo el sistema permite consultar el total de repuestos**
**comprados a cada proveedor.**

##### Actores:

Administrador de Compras

##### Flujo Principal:

1. El administrador de compras ingresa al sistema.
2. El administrador selecciona la opción para consultar las compras de repuestos por
    proveedor.
3. El sistema muestra una lista de proveedores con el total de repuestos comprados a cada
    uno.

### Caso de Uso 14: Clientes con Ventas en un Rango de Fechas

**Descripción: Este caso de uso describe cómo el sistema permite consultar los clientes que han**
**realizado compras dentro de un rango de fechas específico.**

##### Actores:

Vendedor
Administrador

##### Flujo Principal:

1. El usuario ingresa al sistema.
2. El usuario selecciona la opción para consultar los clientes con ventas en un rango de fechas.
3. El usuario ingresa las fechas de inicio y fin del rango.
4. El sistema muestra una lista de clientes que han realizado compras dentro del rango de
    fechas especificado.

## Casos de Uso para Implementar Procedimientos Almacenados

### Caso de Uso 1: Actualización de Inventario de Bicicletas

**Descripción: Este caso de uso describe cómo el sistema actualiza el inventario de bicicletas**
**cuando se realiza una venta.**

##### Actores:

Vendedor

##### Flujo Principal:

1. El vendedor ingresa al sistema.

2. El vendedor registra una venta de bicicletas.

3. El sistema llama a un procedimiento almacenado para actualizar el inventario de las
    bicicletas vendidas.

    ```sql
    
    ```

4. El procedimiento almacenado actualiza el stock de cada bicicleta.

### Caso de Uso 2: Registro de Nueva Venta

**Descripción: Este caso de uso describe cómo el sistema registra una nueva venta, incluyendo la**
**creación de la venta y la inserción de los detalles de la venta.**

##### Actores:

Vendedor

##### Flujo Principal:

1. El vendedor ingresa al sistema.
2. El vendedor registra una nueva venta.
3. El sistema llama a un procedimiento almacenado para registrar la venta y sus detalles.
4. El procedimiento almacenado inserta la venta y sus detalles en las tablas correspondientes.

###   Caso de Uso 3: Generación de Reporte de Ventas por Cliente

  **Descripción: Este caso de uso describe cómo el sistema genera un reporte de ventas para un**
  **cliente específico, mostrando todas las ventas realizadas por el cliente y los detalles de cada venta.**

#####   Actores:

  Administrador

#####   Flujo Principal:

1. El administrador ingresa al sistema.
2. El administrador selecciona un cliente para generar un reporte de ventas.
3. El sistema llama a un procedimiento almacenado para generar el reporte.
4. El procedimiento almacenado obtiene las ventas y los detalles de las ventas realizadas por el
      cliente.

###   Caso de Uso 4: Registro de Compra de Repuestos

  **Descripción: Este caso de uso describe cómo el sistema registra una nueva compra de repuestos**
  **a un proveedor.**

#####   Actores:

  Administrador de Compras

#####   Flujo Principal:

1. El administrador de compras ingresa al sistema.
2. El administrador registra una nueva compra.
3. El sistema llama a un procedimiento almacenado para registrar la compra y sus detalles.
4. El procedimiento almacenado inserta la compra y sus detalles en las tablas correspondientes
      y actualiza el stock de repuestos.

###   Caso de Uso 5: Generación de Reporte de Inventario

  **Descripción: Este caso de uso describe cómo el sistema genera un reporte de inventario de**
  **bicicletas y repuestos.**

#####   Actores:

  Administrador de Inventario

#####   Flujo Principal:

1. El administrador de inventario ingresa al sistema.
2. El administrador solicita un reporte de inventario.
3. El sistema llama a un procedimiento almacenado para generar el reporte.
4. El procedimiento almacenado obtiene la información del inventario de bicicletas y repuestos.

###   Caso de Uso 6: Actualización Masiva de Precios

#####   **Descripción: Este caso de uso describe cómo el sistema permite actualizar masivamente los**

  **precios de todas las bicicletas de una marca específica.**

#####   Actores:

  Administrador

#####   Flujo Principal:

1. El administrador ingresa al sistema.
2. El administrador selecciona la opción para actualizar los precios de una marca específica.
3. El administrador ingresa la marca y el porcentaje de incremento.
4. El sistema llama a un procedimiento almacenado para actualizar los precios.
5. El procedimiento almacenado actualiza los precios de todas las bicicletas de la marca
      especificada.

###   Caso de Uso 7: Generación de Reporte de Clientes por Ciudad

  **Descripción: Este caso de uso describe cómo el sistema genera un reporte de clientes agrupados**
  **por ciudad.**

#####   Actores:

  Administrador

#####   Flujo Principal:

1. El administrador ingresa al sistema.
2. El administrador selecciona la opción para generar un reporte de clientes por ciudad.
3. El sistema llama a un procedimiento almacenado para generar el reporte.
4. El procedimiento almacenado obtiene la información de los clientes agrupados por ciudad.

### Caso de Uso 8: Verificación de Stock antes de Venta

**Descripción: Este caso de uso describe cómo el sistema verifica el stock de una bicicleta antes de**
**permitir la venta.**

##### Actores:

Vendedor

##### Flujo Principal:

1. El vendedor ingresa al sistema.
2. El vendedor selecciona una bicicleta para vender.
3. El sistema llama a un procedimiento almacenado para verificar el stock.
4. El procedimiento almacenado devuelve un mensaje indicando si hay suficiente stock para
    realizar la venta.

### Caso de Uso 9: Registro de Devoluciones

**Descripción: Este caso de uso describe cómo el sistema registra la devolución de una bicicleta por**
**un cliente.**

##### Actores:

Vendedor

##### Flujo Principal:

1. El vendedor ingresa al sistema.
2. El vendedor registra una devolución de bicicleta.
3. El sistema llama a un procedimiento almacenado para registrar la devolución.
4. El procedimiento almacenado inserta la devolución y actualiza el stock de la bicicleta.

### Caso de Uso 10: Generación de Reporte de Compras por Proveedor

**Descripción: Este caso de uso describe cómo el sistema genera un reporte de compras realizadas a un proveedor específico, mostrando todos los detalles de las compras.**

##### Actores:

Administrador de Compras

##### Flujo Principal:

1. El administrador de compras ingresa al sistema.
2. El administrador selecciona un proveedor para generar un reporte de compras.
3. El sistema llama a un procedimiento almacenado para generar el reporte.
4. El procedimiento almacenado obtiene las compras y los detalles de las compras realizadas al
    proveedor.

Caso de Uso 11: Calculadora de Descuentos en Ventas
Descripción: Este caso de uso describe cómo el sistema aplica un descuento a una venta antes de
registrar los detalles de la venta.
Actores:
Vendedor
Flujo Principal:
1. El vendedor ingresa al sistema.
2. El vendedor aplica un descuento a una venta.
3. El sistema llama a un procedimiento almacenado para calcular el total con descuento.
4. El procedimiento almacenado calcula el total con el descuento aplicado y registra la venta.

## Casos de Uso para Funciones de Resumen

### Caso de Uso 1: Calcular el Total de Ventas Mensuales

**Descripción: Este caso de uso describe cómo el sistema calcula el total de ventas realizadas en un**
**mes específico.**

##### Actores:

Administrador

##### Flujo Principal:

1. El administrador ingresa al sistema.
2. El administrador selecciona la opción para calcular el total de ventas mensuales.
3. El administrador ingresa el mes y el año.
4. El sistema llama a un procedimiento almacenado para calcular el total de ventas.
5. El procedimiento almacenado devuelve el total de ventas del mes especificado.

### Caso de Uso 2: Calcular el Promedio de Ventas por Cliente

  **Descripción: Este caso de uso describe cómo el sistema calcula el promedio de ventas realizadas**
  **por un cliente específico.**

#####   Actores:

  Administrador

#####   Flujo Principal:

1. El administrador ingresa al sistema.
2. El administrador selecciona la opción para calcular el promedio de ventas por cliente.
3. El administrador ingresa el ID del cliente.
4. El sistema llama a un procedimiento almacenado para calcular el promedio de ventas.
5. El procedimiento almacenado devuelve el promedio de ventas del cliente especificado.

### Caso de Uso 3: Contar el Número de Ventas Realizadas en un Rango de fechas

**Descripción: Este caso de uso describe cómo el sistema cuenta el número de ventas realizadas**
**dentro de un rango de fechas específico.**

##### Actores:

Administrador

##### Flujo Principal:

1. El administrador ingresa al sistema.
2. El administrador selecciona la opción para contar el número de ventas en un rango de
  fechas.
3. El administrador ingresa las fechas de inicio y fin.
4. El sistema llama a un procedimiento almacenado para contar las ventas.
5. El procedimiento almacenado devuelve el número de ventas en el rango de fechas
  especificado.

### Caso de Uso 4: Calcular el Total de Repuestos Comprados por Proveedor

**Descripción: Este caso de uso describe cómo el sistema calcula el total de repuestos comprados a**
**un proveedor específico.**

##### Actores:

Administrador de Compras

##### Flujo Principal:

1. El administrador de compras ingresa al sistema.
2. El administrador selecciona la opción para calcular el total de repuestos comprados por
  proveedor.
3. El administrador ingresa el ID del proveedor.
4. El sistema llama a un procedimiento almacenado para calcular el total de repuestos.
5. El procedimiento almacenado devuelve el total de repuestos comprados al proveedor
  especificado.

### Caso de Uso 5: Calcular el Ingreso Total por Año

**Descripción: Este caso de uso describe cómo el sistema calcula el ingreso total generado en un**
**año específico.**

##### Actores:

Administrador

##### Flujo Principal:

1. El administrador ingresa al sistema.
2. El administrador selecciona la opción para calcular el ingreso total por año.
3. El administrador ingresa el año.
4. El sistema llama a un procedimiento almacenado para calcular el ingreso total.
5. El procedimiento almacenado devuelve el ingreso total del año especificado.

### Caso de Uso 6: Calcular el Número de Clientes Activos en un Mes

Descripción: Este caso de uso describe cómo el sistema cuenta el número de clientes que han
**realizado al menos una compra en un mes es pecífico.**

##### Actores:

Administrador

##### Flujo Principal:

1. El administrador ingresa al sistema.
2. El administrador selecciona la opción para contar el número de clientes activos en un mes.
3. El administrador ingresa el mes y el año.
4. El sistema llama a un procedimiento almacenado para contar los clientes activos.
5. El procedimiento almacenado devuelve el número de clientes que han realizado compras en
  el mes especificado.

### Caso de Uso 7: Calcular el Promedio de Compras por Proveedor

**Descripción: Este caso de uso describe cómo el sistema calcula el promedio de compras**
**realizadas a un proveedor específico.**

##### Actores:

Administrador de Compras

##### Flujo Principal:

1. El administrador de compras ingresa al sistema.
2. El administrador selecciona la opción para calcular el promedio de compras por proveedor.
3. El administrador ingresa el ID del proveedor.
4. El sistema llama a un procedimiento almacenado para calcular el promedio de compras.
5. El procedimiento almacenado devuelve el promedio de compras del proveedor especificado.

### Caso de Uso 8: Calcular el Total de Ventas por Marca

**Descripción: Este caso de uso describe cómo el sistema calcula el total de ventas agrupadas por**
**la marca de las bicicletas vendidas.**

##### Actores:

Administrador

##### Flujo Principal:

1. El administrador ingresa al sistema.
2. El administrador selecciona la opción para calcular el total de ventas por marca.
3. El sistema llama a un procedimiento almacenado para calcular el total de ventas por marca.
4. El procedimiento almacenado devuelve el total de ventas agrupadas por marca.

### Caso de Uso 9: Calcular el Promedio de Precios de Bicicletas por Marca

**Descripción: Este caso de uso describe cómo el sistema calcula el promedio de precios de las**
**bicicletas agrupadas por marca.**

##### Actores:

Administrador

##### Flujo Principal:

1. El administrador ingresa al sistema.
2. El administrador selecciona la opción para calcular el promedio de precios por marca.
3. El sistema llama a un procedimiento almacenado para calcular el promedio de precios.
4. El procedimiento almacenado devuelve el promedio de precios agrupadas por marca.

### Caso de Uso 10: Contar el Número de Repuestos por Proveedor

**Descripción: Este caso de uso describe cómo el sistema cuenta el número de repuestos**
**suministrados por cada proveedor.**

##### Actores:

Administrador de Compras

##### Flujo Principal:

1. El administrador de compras ingresa al sistema.
2. El administrador selecciona la opción para contar el número de repuestos por proveedor.
3. El sistema llama a un procedimiento almacenado para contar los repuestos.
4. El procedimiento almacenado devuelve el número de repuestos suministrados por cada
  proveedor.

### Caso de Uso 11: Calcular el Total de Ingresos por Cliente

**Descripción: Este caso de uso describe cómo el sistema calcula el total de ingresos generados por**
**cada cliente.**

##### Actores:

Administrador

##### Flujo Principal:

1. El administrador ingresa al sistema.
2. El administrador selecciona la opción para calcular el total de ingresos por cliente.
3. El sistema llama a un procedimiento almacenado para calcular el total de ingresos.
4. El procedimiento almacenado devuelve el total de ingresos generados por cada cliente.

### Caso de Uso 12: Calcular el Promedio de Compras Mensuales

**Descripción: Este caso de uso describe cómo el sistema calcula el promedio de compras**
**realizadas mensualmente por todos los clientes.**

##### Actores:

Administrador

##### Flujo Principal:

1. El administrador ingresa al sistema.
2. El administrador selecciona la opción para calcular el promedio de compras mensuales.
3. El sistema llama a un procedimiento almacenado para calcular el promedio de compras
  mensuales.
4. El procedimiento almacenado devuelve el promedio de compras realizadas mensualmente.

### Caso de Uso 13: Calcular el Total de Ventas por Día de la Semana

**Descripción: Este caso de uso describe cómo el sistema calcula el total de ventas realizadas en**
**cada día de la semana.**

##### Actores:

Administrador

##### Flujo Principal:

1. El administrador ingresa al sistema.
2. El administrador selecciona la opción para calcular el total de ventas por día de la semana.
3. El sistema llama a un procedimiento almacenado para calcular el total de ventas.
4. El procedimiento almacenado devuelve el total de ventas agrupadas por día de la semana.

### Caso de Uso 14: Contar el Número de Ventas por Categoría de Bicicleta

**Descripción: Este caso de uso describe cómo el sistema cuenta el número de ventas realizadas**
**para cada categoría de bicicleta (por ejemplo, montaña, carretera, híbrida).**

##### Actores:

Administrador

##### Flujo Principal:

1. El administrador ingresa al sistema.
2. El administrador selecciona la opción para contar el número de ventas por categoría de
  bicicleta.
3. El sistema llama a un procedimiento almacenado para contar las ventas.
4. El procedimiento almacenado devuelve el número de ventas por categoría de bicicleta.

### Caso de Uso 15: Calcular el Total de Ventas por Año y Mes

**Descripción: Este caso de uso describe cómo el sistema calcula el total de ventas realizadas cada**
**mes, agrupadas por año.**

##### Actores:

Administrador

##### Flujo Principal:

1. El administrador ingresa al sistema.
2. El administrador selecciona la opción para calcular el total de ventas por año y mes.
3. El sistema llama a un procedimiento almacenado para calcular el total de ventas.
4. El procedimiento almacenado devuelve el total de ventas agrupadas por año y mes.