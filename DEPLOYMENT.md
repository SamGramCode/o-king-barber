# 🚀 Guía de Deployment - O-King Barber

## Paso 1: Crear Proyecto Supabase

1. Ir a [supabase.com](https://supabase.com)
2. Crear nuevo proyecto
3. Nombre: `o-king-barber`
4. Región: `South America (São Paulo)` o similar cercana a Santiago
5. Copiar:
   - **SUPABASE_URL** (Project URL)
   - **SUPABASE_KEY** (anon public key)

## Paso 2: Ejecutar SQL en Supabase

1. En Supabase Dashboard → SQL Editor
2. **Copiar y ejecutar** el contenido de `supabase.sql`
3. Luego copiar y ejecutar el contenido de `supabase-recordatorios.sql`

Esto crea todas las tablas necesarias.

## Paso 3: Actualizar Credenciales en index.html

En el archivo `index.html`, línea ~579, reemplazar:

```javascript
const SUPABASE_URL = 'YOUR_SUPABASE_URL';
const SUPABASE_KEY = 'YOUR_SUPABASE_KEY';
```

Con tus credenciales reales:

```javascript
const SUPABASE_URL = 'https://xxxxx.supabase.co';
const SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';
```

## Paso 4: Conectar Repositorio a GitHub

```bash
# Ir a la carpeta
cd /Users/air/o-king-barber

# Si no está en git
git init
git add .
git commit -m "O-King Barber complete system"

# Crear repositorio en GitHub
# 1. Ir a github.com
# 2. New Repository → o-king-barber
# 3. Conectar:
git remote add origin https://github.com/TU_USUARIO/o-king-barber.git
git branch -M main
git push -u origin main
```

## Paso 5: Desplegar en Vercel

**Opción A: Desde GitHub (Recomendado)**

1. Ir a [vercel.com](https://vercel.com)
2. Conectar GitHub
3. Importar repositorio `o-king-barber`
4. Vercel auto-detecta `vercel.json`
5. Hacer clic en Deploy
6. Tu sitio estará en `o-king-barber.vercel.app`

**Opción B: Desde CLI**

```bash
vercel
# Seguir instrucciones
# Deploy automático
```

## Paso 6: Configurar Dominio Personalizado (Opcional)

Si quieres `losminotos-grill.com` (u otro dominio):

1. En Vercel Dashboard → Settings → Domains
2. Agregar dominio
3. Vercel te da CNAME
4. En tu registrador de dominios (GoDaddy, etc):
   - Ir a DNS settings
   - Agregar CNAME: `cname.vercel-dns.com`
   - Esperar 24 horas propagación

## Paso 7: Configurar Google Maps API (Opcional pero Recomendado)

En `index.html`, línea ~542, actualizar:

```html
<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3329.7594697450346!2d-70.64596!3d-33.44242!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x9665a217c1b1b1b1%3A0x1b1b1b1b1b1b1b1b!2sArturo%20Prat%20653%2C%20Santiago!5e0!3m2!1ses!2scl!4v1234567890" 
```

(El código actual ya apunta a la dirección correcta)

## Paso 8: Configurar WhatsApp (Para Recordatorios Automáticos)

**Opción A: Manual (Ya implementado)**
- Admin → Recordatorios
- Click botones para enviar por WhatsApp
- ✅ **Ya funcionando, sin config extra**

**Opción B: Automático (Meta Developers)**
- Ver archivo `WHATSAPP_SETUP.md`

## ✅ Checklist Final

- [ ] Crear proyecto Supabase
- [ ] Ejecutar SQL en Supabase
- [ ] Actualizar credenciales en index.html
- [ ] Hacer push a GitHub
- [ ] Desplegar en Vercel
- [ ] Verificar que landing page funcione
- [ ] Probar agendamiento (llenar formulario)
- [ ] Probar admin panel
- [ ] Probar recordatorios manuales

## 🎯 URLs Finales

Después del deploy:
- **Landing Page**: `https://o-king-barber.vercel.app/`
- **Admin Panel**: `https://o-king-barber.vercel.app/admin`
- **Con dominio personalizado**: `https://losminotos-grill.com/`

## 🐛 Troubleshooting

### "Error de conexión a Supabase"
- Verificar credenciales en index.html
- Verificar que Supabase URL es válida
- Verificar que la key es la correcta (anon key, no service role)

### "Video no aparece"
- Verificar que `assets/video-presentacion.mp4` existe
- Verificar que la ruta es correcta: `./assets/video-presentacion.mp4`

### "Admin panel no abre"
- Verificar URL: `/admin` o `/admin.html`
- Verificar que vercel.json tiene las rewrites correctas

### "Google Maps no carga"
- Puede ser bloqueo de Google por abuso
- Crear API Key en Google Cloud Console
- Agregar a la URL de iframe

## 📞 Soporte

Para dudas o problemas:
1. Revisar `README.md`
2. Revisar `WHATSAPP_SETUP.md`
3. Revisar `RECORDATORIOS_MANUAL.md`

---

**O-King Barber - Sistema Listo para Producción** 💈🚀
