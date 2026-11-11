# KODAHUB WordPress Starter

**Entorno de desarrollo local para proyectos WordPress utilizando Docker.**

KODAHUB WordPress Starter es una plantilla diseñada para facilitar la creación y administración de sitios web WordPress en entornos locales, utilizando Docker y Docker Compose.

El objetivo es disponer de un entorno de desarrollo estandarizado, reproducible y aislado que permita iniciar nuevos proyectos web sin tener que configurar manualmente PHP, Apache, WordPress y MariaDB en cada ocasión.

Está pensado especialmente para desarrolladores y agencias que trabajan con múltiples proyectos WordPress y necesitan mantener entornos independientes.

---

## Características

- **WordPress:** instalación mediante la imagen oficial de Docker.
- **PHP 8.4:** entorno PHP preparado para WordPress.
- **Apache:** servidor web con soporte para reglas de reescritura.
- **MariaDB 11.4:** base de datos independiente y persistente.
- **Docker Compose:** administración sencilla de los servicios.
- **phpMyAdmin:** administración visual de la base de datos mediante un perfil opcional.
- **Configuración PHP:** límites de memoria, tamaño de archivos y tiempos de ejecución ajustados para trabajar con constructores visuales.
- **Persistencia:** volúmenes Docker para conservar los archivos de WordPress y la base de datos.
- **Aislamiento:** cada proyecto puede funcionar con sus propios contenedores, puertos y credenciales.

## Arquitectura

El entorno utiliza los siguientes servicios:

| Servicio | Tecnología | Función |
|---|---|---|
| wordpress | WordPress + PHP 8.4 + Apache | Aplicación web |
| db | MariaDB 11.4 | Base de datos |
| phpmyadmin | phpMyAdmin 5 | Administración de base de datos (opcional) |

### Estructura del proyecto

```text
wordpress-starter/
│
├── docker-compose.yml
├── Dockerfile
├── .env.example
├── .gitignore
├── README.md
│
└── docker/
    └── php/
        └── uploads.ini
```

Los archivos y la base de datos de WordPress se almacenan en volúmenes Docker independientes.

Esto permite reconstruir los contenedores sin perder la información persistida.

---

## Requisitos

Antes de comenzar, asegúrate de contar con:

- Linux, Ubuntu o WSL2.
- Docker Engine.
- Docker Compose V2.
- Git.
- Conexión a Internet para descargar las imágenes y completar la instalación.

Puedes comprobar las versiones instaladas con:

```bash
docker --version
docker compose version
git --version
```

## Instalación

### 1. Clonar el repositorio

```bash
git clone <URL_DEL_REPOSITORIO> wordpress-starter
```

Ingresar al directorio:

```bash
cd wordpress-starter
```

### 2. Configurar las variables de entorno

Crear el archivo `.env` a partir del ejemplo:

```bash
cp .env.example .env
```

Editar las variables:

```bash
nano .env
```

Configuración de ejemplo:

```dotenv
COMPOSE_PROJECT_NAME=kh_web_cliente01

WP_PORT=8080
PMA_PORT=8081

DB_NAME=wordpress
DB_USER=wp_user
DB_PASSWORD=cambiar_password
DB_ROOT_PASSWORD=cambiar_root_password

WP_TABLE_PREFIX=wp_
WP_DEBUG=1
```

Descripción de las variables:

| Variable | Descripción |
|---|---|
| COMPOSE_PROJECT_NAME | Identificador del proyecto Docker |
| WP_PORT | Puerto local de WordPress |
| PMA_PORT | Puerto local de phpMyAdmin |
| DB_NAME | Nombre de la base de datos |
| DB_USER | Usuario de MariaDB |
| DB_PASSWORD | Contraseña del usuario |
| DB_ROOT_PASSWORD | Contraseña del administrador de MariaDB |
| WP_TABLE_PREFIX | Prefijo de las tablas WordPress |
| WP_DEBUG | Activar o desactivar el modo debug |

**Importante:** utiliza contraseñas seguras y diferentes para cada proyecto. No compartas el archivo `.env` ni lo subas al repositorio.

### 3. Construir e iniciar los contenedores

Ejecutar:

```bash
docker compose up -d --build
```

Docker descargará las imágenes necesarias, construirá el contenedor de WordPress e iniciará los servicios.

Comprobar el estado:

```bash
docker compose ps
```

### 4. Completar la instalación de WordPress

Abrir el navegador:

```text
http://localhost:8080
```

Seguir el asistente de instalación de WordPress:

1. Seleccionar el idioma.
2. Introducir el título del sitio.
3. Crear el usuario administrador.
4. Configurar una contraseña segura.
5. Introducir un correo electrónico administrativo.
6. Finalizar la instalación.

Una vez completado el proceso, podrás ingresar al panel:

```text
http://localhost:8080/wp-admin
```

---

## Administración de la base de datos

phpMyAdmin se encuentra disponible como servicio opcional.

Para iniciar WordPress junto con phpMyAdmin:

```bash
docker compose --profile tools up -d
```

Acceder desde:

```text
http://localhost:8081
```

Credenciales:

- Servidor: `db`
- Usuario: el definido en `DB_USER`
- Contraseña: la definida en `DB_PASSWORD`

También puedes ingresar como administrador utilizando `root` y `DB_ROOT_PASSWORD`.

Para iniciar únicamente WordPress:

```bash
docker compose up -d
```

---

## Configuración PHP

El entorno incluye una configuración personalizada para facilitar el trabajo con WordPress y constructores visuales como Divi.

Archivo: `docker/php/uploads.ini`

```ini
memory_limit=512M

upload_max_filesize=128M
post_max_size=128M

max_execution_time=300
max_input_time=300
max_input_vars=5000
```

Esta configuración permite trabajar con archivos multimedia de mayor tamaño, importaciones de contenido y operaciones que requieren más tiempo de ejecución.

Los valores pueden ajustarse según las necesidades de cada proyecto.

---

## Integración con Divi

Esta plantilla es compatible con el uso de Divi como constructor visual para WordPress.

Para utilizarlo:

1. Acceder al panel administrativo de WordPress.
2. Ingresar a la sección de temas.
3. Subir el archivo ZIP de Divi obtenido desde tu cuenta oficial de Elegant Themes.
4. Activar el tema.
5. Configurar la licencia desde las opciones correspondientes de Divi.

**Licencia:** Divi es un producto comercial de Elegant Themes. Este repositorio no incluye sus archivos, licencia ni recursos protegidos por derechos de autor. Cada usuario debe disponer de una licencia válida según las condiciones del proveedor.

También puedes utilizar otros temas y constructores visuales compatibles con WordPress.

---

## Comandos de uso frecuente

### Iniciar el proyecto

```bash
docker compose up -d
```

### Detener los contenedores

```bash
docker compose stop
```

### Detener y eliminar los contenedores

```bash
docker compose down
```

Este comando conserva los volúmenes y, por tanto, los datos del proyecto.

### Reconstruir los contenedores

```bash
docker compose up -d --build
```

### Consultar los contenedores activos

```bash
docker compose ps
```

### Consultar los registros

```bash
docker compose logs -f
```

### Consultar los registros de WordPress

```bash
docker compose logs -f wordpress
```

### Ingresar al contenedor WordPress

```bash
docker compose exec wordpress bash
```

### Ingresar a MariaDB

```bash
docker compose exec db mariadb -u root -p
```

### Eliminar el proyecto y sus volúmenes

```bash
docker compose down -v
```

**Advertencia:** este último comando elimina los volúmenes asociados, incluyendo los archivos de WordPress y la base de datos. Úsalo únicamente cuando quieras eliminar definitivamente los datos del entorno.

---

## Crear nuevos proyectos a partir de la plantilla

Una de las principales ventajas de este repositorio es que permite generar múltiples proyectos independientes.

Por ejemplo, para crear un nuevo sitio:

```bash
cd ~/proyectos

git clone <URL_DEL_REPOSITORIO> KodaHubWeb

cd KodaHubWeb
```

Crear el archivo de configuración:

```bash
cp .env.example .env
```

Modificar los parámetros del nuevo proyecto:

```dotenv
COMPOSE_PROJECT_NAME=kh_kodahubweb

WP_PORT=8082
PMA_PORT=8083

DB_NAME=kodahubweb
DB_USER=wp_user
DB_PASSWORD=contraseña_segura
DB_ROOT_PASSWORD=contraseña_root_segura

WP_TABLE_PREFIX=wp_
WP_DEBUG=1
```

Iniciar:

```bash
docker compose up -d --build
```

El nuevo proyecto estará disponible en:

```text
WordPress:    http://localhost:8082
phpMyAdmin:  http://localhost:8083
```

Cada proyecto tendrá sus propios contenedores y volúmenes, evitando interferencias con otros sitios web.

### Recomendación para Git

Al clonar la plantilla para crear un proyecto independiente, el repositorio original también se conserva como remoto `origin`.

Si deseas que el nuevo proyecto tenga su propio repositorio:

```bash
git remote remove origin
git remote add origin <URL_DEL_NUEVO_REPOSITORIO>
```

Después:

```bash
git add .
git commit -m "Initial commit"
git push -u origin main
```

---

## Persistencia y respaldos

La información se almacena mediante volúmenes Docker:

| Volumen | Contenido |
|---|---|
| wordpress_data | Instalación de WordPress, temas, plugins y archivos multimedia |
| db_data | Base de datos MariaDB |

Los volúmenes sobreviven a la eliminación de los contenedores mediante `docker compose down`.

**Importante:** los volúmenes no forman parte del repositorio Git. Por ello, es necesario implementar respaldos independientes para conservar los archivos y la base de datos.

Para proyectos importantes se recomienda realizar:

- Exportación periódica de la base de datos.
- Respaldo de los archivos de WordPress.
- Conservación de los archivos de configuración necesarios.
- Verificación periódica de la restauración de los respaldos.

---

## Seguridad y buenas prácticas

Para utilizar esta plantilla en proyectos reales:

- No subir archivos `.env` al repositorio.
- No almacenar contraseñas reales en archivos versionados.
- Mantener Docker, WordPress, PHP y MariaDB actualizados.
- Utilizar versiones controladas de las imágenes.
- Instalar plugins y temas desde fuentes confiables.
- Mantener copias de seguridad externas.
- No exponer phpMyAdmin públicamente sin controles adicionales.
- Desactivar `WP_DEBUG` en producción.
- Utilizar HTTPS en los entornos publicados.
- No considerar esta configuración local como una configuración de producción lista para desplegar.

---

## Objetivo del proyecto

Este repositorio forma parte de las herramientas de desarrollo de **KODAHUB**.

Su finalidad es estandarizar la creación de sitios web con WordPress, reducir el tiempo de configuración inicial y facilitar el trabajo con múltiples proyectos utilizando Docker.

La plantilla puede utilizarse como punto de partida para:

- Sitios web corporativos.
- Landing pages.
- Portales institucionales.
- Sitios comerciales.
- Páginas personales y profesionales.
- Proyectos WordPress con Divi.

## Licencia

Este repositorio se distribuye bajo la licencia MIT.

Consulta el archivo `LICENSE` para conocer los términos de uso, modificación y distribución.

---

**Desarrollado por KODAHUB**

[https://kodahub.dev](https://kodahub.dev)

*Herramientas y soluciones para el desarrollo web.*
