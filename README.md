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

### Requisitos
- Docker 20.10+
- Docker Compose 2.0+

### 1. Clonar el repositorio
```bash
git clone https://github.com/Follaburros420/devseniorcode-meet.git
cd devseniorcode-meet
```

### 2. Construir y ejecutar con Docker Compose
```bash
# Construir imagen
docker-compose build

# Iniciar contenedor
docker-compose up -d

# Ver logs
docker-compose logs -f web
```

### 3. Acceder a la aplicación
```
http://localhost:8080
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

## 📁 Estructura de Archivos Principales

```
devseniorcode-meet/
├── css/
│   ├── devsenior_custom.scss    # Tema premium glassmorphism
│   └── main.scss                 # Importa tema personalizado
├── images/
│   ├── devsenior-logo.svg        # Logo principal
│   └── watermark.svg             # Watermark con gradiente
├── lang/
│   ├── main-es.json              # Traducciones españolas
│   └── main.json                 # Traducciones inglesas
├── react/features/welcome/
│   └── components/
│       └── WelcomePage.web.tsx  # Welcome page con bullets
├── Dockerfile                     # Multi-stage build
├── docker-compose.yml             # Configuración Dokploy
├── nginx-devsenior.conf          # Configuración nginx
├── interface_config.js           # Configuración UI
├── title.html                     # Metadatos completos
├── manifest.json                 # PWA manifest
└── README.md                      # Este archivo
```

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
npm run dev
```

Abrir: http://localhost:8080/index_dev.html

### Compilación para producción
```bash
# Compilar CSS
npx sass css/main.scss css/all.bundle.css
./node_modules/.bin/cleancss --skip-rebase css/all.bundle.css -o css/all.css

# Compilar React
npm run build
```

### Linter
```bash
npm run lint:ci
npm run tsc:web
```

---

## 📦 Optimizaciones

### Imagen Docker Multi-Stage
- **Stage 1 (Builder)**: Node.js 20 Alpine para compilar
- **Stage 2 (Production)**: Nginx Alpine para servir
- **Tamaño optimizado**: Solo incluye archivos necesarios

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
1. Abrir http://localhost:8080 en modo incógnito
2. Verificar título de pestaña: "DevSeniorCode"
3. Inspeccionar meta tags en DevTools
4. Verificar diseño responsive

---

## 📝 Changelog

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
3. Commit: `git commit -m 'feat: Agregar mi feature'`
4. Push: `git push origin feature/mi-feature`
5. Pull Request

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
