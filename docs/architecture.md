# HDFS: arquitectura y flujos

## Lectura de un archivo

```mermaid
sequenceDiagram
    participant Client
    participant NN as NameNode
    participant DN1 as DataNode 1
    participant DN2 as DataNode 2
    Client->>NN: Open /datasets/transactions.csv
    NN-->>Client: Block IDs and replica locations
    Client->>DN1: Read block 1
    DN1-->>Client: Block 1 bytes
    Client->>DN2: Read block 2
    DN2-->>Client: Block 2 bytes
```

El NameNode responde con metadatos; el cliente obtiene los bytes directamente de los DataNodes. El cliente puede seleccionar réplicas accesibles según la ubicación y las condiciones del clúster.

## Escritura de un bloque

```mermaid
sequenceDiagram
    participant Client
    participant NN as NameNode
    participant DN1 as DataNode 1
    participant DN2 as DataNode 2
    participant DN3 as DataNode 3
    Client->>NN: Create file / request block targets
    NN-->>Client: DN1, DN2, DN3
    Client->>DN1: Stream packets
    DN1->>DN2: Forward packets
    DN2->>DN3: Forward packets
    DN3-->>DN2: Acknowledge
    DN2-->>DN1: Acknowledge
    DN1-->>Client: Acknowledge
```

El ejemplo simplifica el protocolo de escritura para mostrar la idea del pipeline. Las confirmaciones y el manejo de errores reales dependen del estado del clúster y de la configuración.

## Almacenamiento frente a metadatos

```mermaid
flowchart LR
    NN[NameNode: namespace, file-to-block map] -.-> D1[DataNode 1: block replicas]
    NN -.-> D2[DataNode 2: block replicas]
    NN -.-> D3[DataNode 3: block replicas]
```

**Pregunta:** si aumentamos el número de DataNodes, ¿se reduce automáticamente la cantidad de metadatos que mantiene el NameNode? No. El crecimiento de los archivos y los bloques sigue presionando su memoria.
