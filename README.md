# DevSeniorCode Meet

<div align="center">

![DevSeniorCode Meet](images/devsenior-logo.svg)

**Videoconferencias premium con diseño SaaS moderno**

Una versión personalizada de Jitsi Meet con branding completo de DevSeniorCode, diseño glassmorphism oscuro, y optimizada para despliegues Docker/Dokploy.

[![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](LICENSE)
[![Docker](https://img.shields.io/badge/docker-ready-brightgreen.svg)](https://www.docker.com/)

</div>

---

## 🎨 Características

### Branding Completo
- ✅ **Título**: "DevSeniorCode" en pestaña del navegador
- ✅ **Meta tags**: OpenGraph, Twitter Cards, PWA manifest
- ✅ **Logos personalizados**: Watermark y welcome page
- ✅ **Sin referencias a Jitsi Meet** en la UI visible

### Diseño Premium SaaS
- 🎨 **Tema oscuro morado** (#8b5cf6)
- ✨ **Glassmorphism**: Blur, transparencias, bordes brillantes
- 📱 **Responsive**: Optimizado para desktop y móvil
- ⚡ **Microinteracciones**: Animaciones suaves (150-250ms)
- 🎯 **Accesibilidad**: Contraste WCAG AA compliant

### Welcome Page Moderna
- 🏠 **Hero impactante**: Título con gradiente y subtítulo
- 💎 **Bullets de valor**: HD audio/video, Compartir pantalla, Sin registro
- 📝 **Input premium**: Placeholder elegante con microtexto
- 🔄 **Recientes profesional**: Tarjetas translucidas con estado vacío
- 🌐 **100% español**: Localización completa

---

## 🚀 Quick Start (Docker)

### Requisitos Previos

⚠️ **IMPORTANTE**: Antes de hacer deploy, debes compilar localmente:

1. **Make** (installar en Windows: https://gnuwin32.sourceforge.net/packages/make.htm)
2. **Node.js** 20+ y npm
3. **Git**

### Paso 1: Compilar Localmente

En Windows (con Make instalado):

```bash
# Compilar JavaScript
make compile

# Deploy a libs/
make deploy

# Compilar CSS (si no existe)
npx sass css/main.scss css/all.bundle.css
.\node_modules\.bin\cleancss --skip-rebase css/all.bundle.css -o css/all.css
```

O usa el script de deployment:

```bash
# Linux/Git Bash
bash deploy.sh

# Windows PowerShell
# (Ejecuta los comandos manualmente como arriba)
```

### Paso 2: Verificar Build

Asegúrate de que estos archivos existen:
- `libs/app.bundle.min.js` ✅
- `libs/external_api.min.js` ✅
- `css/all.css` ✅

### Paso 3: Desplegar con Dokploy

1. **Hacer commit de los cambios**:
   ```bash
   git add .
   git commit -m "chore: update production build"
   git push origin master
   ```

2. **Dokploy construirá el contenedor automáticamente**:
   - ⏱️ **Tiempo**: ~2-5 minutos (antes: 30-60 minutos)
   - 📦 **Tamaño**: Solo archivos estáticos compilados
   - 🚀 **Sin recompilación en VPS**

3. **Verificar deployment**:
   ```bash
   docker-compose logs -f web
   ```

---

## 🐳 Por qué el deployment es rápido ahora

### Dockerfile Antiguo (❌ LENTO)
```dockerfile
FROM node:20-alpine
RUN npm install --legacy-peer-deps  # 2193 paquetes, ~5-10 min
RUN make compile                    # Webpack, ~20-40 min
```
**Tiempo total**: 30-60 minutos ⏳

### Dockerfile Nuevo (✅ RÁPIDO)
```dockerfile
FROM nginx:alpine
COPY libs/ /usr/share/nginx/html/libs/   # Solo copiar archivos ya compilados
COPY css/ /usr/share/nginx/html/css/
```
**Tiempo total**: 2-5 minutos ⚡

---

## 📁 Estructura de Archivos Principales

```
devseniorcode-meet/
├── css/
│   ├── devsenior_custom.scss    # Tema premium glassmorphism
│   ├── main.scss                 # Importa tema personalizado
│   └── all.css                   # CSS compilado (generado por make deploy)
├── images/
│   ├── devsenior-logo.svg        # Logo principal
│   └── watermark.svg             # Watermark con gradiente
├── lang/
│   ├── main-es.json              # Traducciones españolas
│   └── main.json                 # Traducciones inglesas
├── libs/
│   ├── app.bundle.min.js         # JS compilado (generado por make compile)
│   └── external_api.min.js       # API externa (generado por make compile)
├── react/features/welcome/
│   └── components/
│       └── WelcomePage.web.tsx  # Welcome page con bullets
├── Dockerfile                     # Solo copia archivos estáticos
├── docker-compose.yml             # Configuración Dokploy
├── nginx-devsenior.conf          # Configuración nginx
├── interface_config.js           # Configuración UI
├── title.html                     # Metadatos completos
├── manifest.json                 # PWA manifest
├── deploy.sh                      # Script de deployment local
└── README.md                      # Este archivo
```

---

## 🐳 Despliegue con Dokploy

### Configuración recomendada

1. **Crear nueva aplicación** en Dokploy:
   - Tipo: **Docker Compose**
   - Repository: `https://github.com/Follaburros420/devseniorcode-meet.git`
   - Branch: `master`
   - Ruta docker-compose: `/`

2. **Variables de entorno** (opcional):
   ```yaml
   NGINX_HOST=devseniorcode.com
   NGINX_PORT=80
   ```

3. **Puertos expuestos**:
   - `80` (HTTP)
   - `443` (HTTPS)

4. **Labels Traefik** (automáticos):
   - `traefik.enable=true`
   - `com.dokploy.app-name=devseniorcode-meet`

---

## ⚠️ WebRTC y HTTPS (Solución de Problemas)

### Problema: "WebRTC not available"

Si ves este error al desplegar en Docploit/Traefik:
- **Causa**: WebRTC requiere HTTPS (secure context).
- **Solución**: La configuración de Nginx incluida (`nginx-devsenior.conf`) ahora detecta automáticamente el HTTPS que provee Traefik.

### Cómo funciona la arquitectura:
1. **Traefik (Docploit)**: Recibe la conexión segura (HTTPS) en puerto 443.
2. **Nginx (Interno)**: Recibe la conexión en puerto 80, pero lee el header `X-Forwarded-Proto: https`.
3. **Navegador**: Detecta el contexto seguro y habilita WebRTC.

---

## 🎨 Personalización

### Colores del Tema

Edita `css/devsenior_custom.scss`:

```scss
// Paleta de colores principal
$color-purple-primary: #8b5cf6;
$color-purple-secondary: #a78bfa;
$color-purple-accent: #c4b5fd;
$color-bg-primary: #0a0a0f;
$color-bg-secondary: #12121a;
```

### Textos

Edita los archivos de idioma:
- Español: `lang/main-es.json`
- Inglés: `lang/main.json`

### Configuración

Edita `interface_config.js` para ajustar:
- `APP_NAME`: Nombre de la aplicación
- `DEFAULT_WELCOME_PAGE_LOGO_URL`: URL del logo
- `BRAND_WATERMARK_LINK`: Enlace del watermark

---

## 🔧 Desarrollo Local

### Instalación de dependencias
```bash
npm install
```

### Servidor de desarrollo
```bash
# Opción 1: Usar npm start (requiere Make)
npm start

# Opción 2: Webpack directo
node node_modules/webpack-dev-server/bin/webpack-dev-server.js --mode development
```

Abrir: https://localhost:8081/index_dev.html

### Compilación para producción
```bash
# Compilar todo (JS + CSS + assets)
make compile && make deploy

# Solo CSS
npx sass css/main.scss css/all.bundle.css
./node_modules/.bin/cleancss --skip-rebase css/all.bundle.css -o css/all.css
```

### Linter
```bash
npm run lint:ci
npm run tsc:web
```

---

## 📦 Optimizaciones

### Docker de Solo Archivos Estáticos
- ✅ **Sin Node.js** en imagen de producción
- ✅ **Sin compilación** en VPS
- ✅ **Tamaño mínimo**: Solo HTML, CSS, JS compilados
- ✅ **Build rápido**: 2-5 minutos en lugar de 30-60

### Nginx Configurado
- ✅ Gzip compression
- ✅ Cache de assets estáticos (1 año)
- ✅ Security headers
- ✅ Health checks

---

## 🧪 Testing

Ejecutar tests:
```bash
npm test
```

Tests visuales manuales:
1. Abrir http://localhost:8081/index_dev.html en modo incógnito
2. Verificar título de pestaña: "DevSeniorCode"
3. Inspeccionar meta tags en DevTools
4. Verificar diseño responsive

---

## 📝 Changelog

### v2.0.0 (2025-02-02)
- ✅ **Dockerfile optimizado**: Sin recompilación en VPS
- ✅ **Tiempo de deployment**: 2-5 min (antes: 30-60 min)
- ✅ **Deploy script**: Automatiza build local
- ✅ **.dockerignore**: Excluye archivos innecesarios
- ✅ Rebranding completo a DevSeniorCode
- ✅ Diseño SaaS premium con glassmorphism
- ✅ Welcome page con bullets de valor

### v1.0.0 (2025-02-02)
- ✅ Rebranding completo a DevSeniorCode
- ✅ Diseño SaaS premium con glassmorphism
- ✅ Welcome page con bullets de valor
- ✅ Dockerfile optimizado para Dokploy
- ✅ Actualización de todos los metadatos
- ✅ Traducciones en español e inglés
- ✅ Eliminación de footer de apps móviles

---

## 🤝 Contribuir

Este es un fork personalizado de [jitsi/jitsi-meet](https://github.com/jitsi/jitsi-meet).

1. Fork el repositorio
2. Crea rama: `git checkout -b feature/mi-feature`
3. **Compila localmente**: `make compile && make deploy`
4. Commit: `git commit -m 'feat: Agregar mi feature'`
5. Push: `git push origin feature/mi-feature`
6. Pull Request

---

## 📄 Licencia

Apache-2.0 - Ver archivo [LICENSE](LICENSE) para detalles.

Basado en [Jitsi Meet](https://jitsi.org/jitsi-meet/) © 8x8, Inc.

---

## 🔗 Links Útiles

- **Repositorio**: [https://github.com/Follaburros420/devseniorcode-meet](https://github.com/Follaburros420/devseniorcode-meet)
- **Issues**: [https://github.com/Follaburros420/devseniorcode-meet/issues](https://github.com/Follaburros420/devseniorcode-meet/issues)
- **Jitsi Meet Original**: [https://github.com/jitsi/jitsi-meet](https://github.com/jitsi/jitsi-meet)

---

<div align="center">

**Hecho con ❤️ por [DevSeniorCode](https://devseniorcode.com)**

_Fork personalizado de [Jitsi Meet](https://jitsi.org/jitsi-meet/) con diseño premium SaaS_

</div>
