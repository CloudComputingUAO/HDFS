# Escenarios de fallo

| Incidente | Qué observar | Qué no asumir |
| --- | --- | --- |
| Se detiene un DataNode | El NameNode deja de recibir heartbeats; las réplicas supervivientes pueden servir lecturas. | La detección no es instantánea. |
| Quedan dos DataNodes con replicación 3 | Los bloques pueden quedar infrarreplicados. | No se pueden mantener tres copias en tres nodos distintos si solo hay dos nodos sanos. |
| Regresa un DataNode con su volumen | Puede volver a anunciar bloques existentes. | No siempre se reconstruyen todos los bloques. |
| Se detiene el único NameNode | Las operaciones normales de metadatos dejan de funcionar. | Los bloques no se borran automáticamente por detener el NameNode. |
| Un usuario elimina un archivo | Se elimina del namespace y se programa la eliminación de los bloques no referenciados. | La replicación no deshace la eliminación. |
| El host Docker completo falla | Todos los contenedores y volúmenes del mismo host pueden quedar inaccesibles. | Tres contenedores no equivalen a tres máquinas físicas independientes. |

## Preguntas de discusión

1. ¿Qué diferencia hay entre disponibilidad y durabilidad?
2. ¿Qué protege la replicación y qué protege un backup?
3. ¿Por qué la caída del NameNode es distinta a la caída de un DataNode?
4. ¿Por qué la cantidad de DataNodes disponibles limita la replicación efectiva?
5. ¿Qué cambia al desplegar los DataNodes en servidores físicos distintos?
