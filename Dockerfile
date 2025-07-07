# --- Etapa 1: Build ---
# Usamos una imagen oficial de Go como constructor
FROM golang:1.22-alpine AS builder

# Establecemos el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiamos los archivos de dependencias (si los tuvieras, como go.mod y go.sum)
# Para este caso simple, copiamos todo el código fuente.
COPY . .

# Construimos el binario de la aplicación.
# CGO_ENABLED=0 crea un binario estático sin dependencias de C.
# GOOS=linux especifica que el binario es para el sistema operativo Linux.
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /poc-rest-api .

# --- Etapa 2: Final ---
# Usamos una imagen base mínima para la imagen final
FROM alpine:latest

# Creamos un usuario no-root para correr la aplicación por seguridad
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copiamos solo el binario compilado desde la etapa de 'builder'
COPY --from=builder /poc-rest-api /poc-rest-api

# Exponemos el puerto en el que la aplicación escucha
EXPOSE 8080

# Asignamos permisos al usuario no-root
USER appuser

# Comando para ejecutar la aplicación cuando el contenedor inicie
CMD ["/poc-rest-api"]
