# NAATTest
Examen práctico para la empresa NA-AT Technologies

Examen de conocimientos Desarrollador Senior Versión: 1.0

Instrucciones: Desarrollar una aplicación móvil en Android (Java) o iOS (Swift 3) que tenga las siguientes funcionalidades:
1. Invocar el siguiente servicio REST
https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=X X.XXXXX,YY.YYYYYY&radius=2000&type=bank&key=AIzaSyA7m5YQp_O QXvZ7DzylErwubKq7BhIVUcs
Donde la latitud y longitud a enviar en el servicio son:
- Latitud: 19.409737
- Longitud: -99.169601
También debe contar con las siguientes implementaciones:
- Manejo de Spinners durante el proceso de invocación del
servicio
- Manejo de errores (por timeouts, errores provenientes del
servidor, etc.)
2. Presentar una lista con los registros contenidos dentro del objeto JSON obtenido del servicio
3. Ordenar los registros de menor a mayor distancia al punto origen. La unidad de medida son metros
4. La información que debe aparecer en cada renglón de la lista es:
a. Nombre del lugar
b. Dirección completa
c. Distancia
5. Al dar tap en un registro, deberá abrir una nueva pantalla mostrando el detalle de ese registro.
