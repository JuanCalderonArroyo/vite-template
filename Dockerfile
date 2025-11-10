# Etapa 1: Construcción
FROM node:20-slim AS build
WORKDIR /app

# Copiar archivos de dependencias
COPY package*.json ./

# Instalar dependencias (usa npm install por compatibilidad)
RUN npm install

# Copiar el resto del código
COPY . .

# Construir la app para producción
RUN npm run build

# Etapa 2: Servidor web
FROM nginx:alpine
# Copiar la build generada al directorio público de nginx
COPY --from=build /app/dist /usr/share/nginx/html

# Exponer el puerto 80
EXPOSE 80

# Comando para mantener Nginx en ejecución
CMD ["nginx", "-g", "daemon off;"]
