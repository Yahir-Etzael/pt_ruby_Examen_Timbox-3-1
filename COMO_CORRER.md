# Como Correr El Proyecto

Este archivo tiene dos formas de levantar la aplicacion:

1. Local en tu computadora.
2. Con Docker.

Si estas empezando, usa Docker porque evita muchos problemas de versiones. Si ya tienes Ruby, Rails y PostgreSQL instalados, puedes usar la opcion local.

## Opcion 1: Correr Local

Esta opcion usa lo que tienes instalado en tu computadora.

### 1. Abre una terminal en la carpeta del proyecto

Entra a esta carpeta:

```bash
cd "C:\Users\etza9\OneDrive\Documentos\Etzael 9015\Desarrollos\prueba_ruby"
```

### 2. Instala las dependencias

```bash
bundle install
```

### 3. Asegurate de tener PostgreSQL encendido

La aplicacion necesita PostgreSQL para guardar usuarios, colaboradores y demas informacion.

Si PostgreSQL esta instalado en tu computadora, solo verifica que este iniciado.

### 4. Prepara la base de datos

```bash
bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails db:seed
```

El comando `db:seed` crea el usuario demo.

### 5. Levanta Rails

```bash
bundle exec rails server
```

Abre en el navegador:

```text
http://localhost:3000
```

Usuario demo:

```text
Correo: demo@example.com
Password: Password123
```

### Si Algo Falla En Local

Revisa primero estas tres cosas:

- Que PostgreSQL este encendido.
- Que el puerto `3000` no este ocupado.
- Que hayas corrido `bundle install`.

Si el error es de base de datos, intenta:

```bash
bundle exec rails db:prepare
```

## Opcion 2: Correr Con Docker

Esta opcion corre Ruby, Rails y PostgreSQL dentro de contenedores Linux. Es la forma mas estable si estas trabajando desde Windows.

### 1. Abre Docker Desktop

Espera a que Docker Desktop diga que ya esta listo.

### 2. Abre una terminal en la carpeta del proyecto

```bash
cd "C:\Users\etza9\OneDrive\Documentos\Etzael 9015\Desarrollos\prueba_ruby"
```

### 3. Construye y levanta la app

```bash
docker compose up --build
```

La primera vez puede tardar porque instala Ruby y las dependencias dentro de Ubuntu.

### 4. Abre la app

```text
http://localhost:3000
```

Usuario demo:

```text
Correo: demo@example.com
Password: Password123
```

### Comandos Utiles De Docker

Ver contenedores:

```bash
docker compose ps
```

Apagar la app:

```bash
docker compose down
```

Entrar a la consola de Rails:

```bash
docker compose exec web bundle exec rails console
```

Cargar usuario demo:

```bash
docker compose exec web bundle exec rails db:seed
```

Reiniciar todo desde cero, incluyendo la base de datos:

```bash
docker compose down -v
docker compose up --build
```

## Puertos

- Aplicacion Rails: `http://localhost:3000`
- PostgreSQL con Docker desde Windows: `localhost:5433`
- PostgreSQL dentro de Docker: `db:5432`

