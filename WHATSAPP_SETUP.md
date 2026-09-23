# Configurar Recordatorios por WhatsApp

## Pasos para Habilitar Recordatorios Automáticos

### 1. Crear Cuenta en Meta (Facebook)

1. Ir a [Meta for Developers](https://developers.facebook.com)
2. Crear nuevo proyecto (seleccionar "WhatsApp Business")
3. Nombrar el proyecto: "O-King Barber"

### 2. Obtener Credenciales

1. En el dashboard de Meta, ir a **WhatsApp** → **Getting Started**
2. Copiar:
   - **Phone Number ID** (número de teléfono asociado)
   - **Business Account ID**
   - **Access Token** (generar nuevo)

### 3. Obtener Número de WhatsApp

Opciones:
- **Opción A**: Usar número existente (+56 9 8185 9024)
- **Opción B**: Crear nuevo número en Meta Business

### 4. Configurar Variables en Vercel

En Vercel Dashboard → Project Settings → Environment Variables:

```
WHATSAPP_TOKEN=YOUR_ACCESS_TOKEN
WHATSAPP_PHONE_ID=YOUR_PHONE_ID
SUPABASE_URL=YOUR_SUPABASE_URL
SUPABASE_KEY=YOUR_SUPABASE_KEY
```

### 5. Configurar CRON en Vercel

En `vercel.json`, agregar:

```json
{
  "crons": [{
    "path": "/api/recordatorios",
    "schedule": "*/5 * * * *"
  }]
}
```

Esto ejecuta el recordatorio cada 5 minutos.

### 6. Ejecutar SQL de Recordatorios

En Supabase SQL Editor, copiar y ejecutar:
```sql
-- (Contenido de supabase-recordatorios.sql)
```

### 7. Testear Recordatorios

```bash
# Localmente
curl -X POST http://localhost:3000/api/recordatorios

# En Vercel
curl -X POST https://tu-dominio.vercel.app/api/recordatorios
```

## 📝 Flujo de Recordatorios

1. **08:00 AM** - Cliente agenda cita para las **08:30 AM**
2. **08:00 AM** - Sistema guarda cita en Supabase
3. **Cada 5 minutos** - Cron ejecuta `/api/recordatorios`
4. **08:25 AM** - Sistema detecta cita en 30 minutos
5. **08:25 AM** - Envía mensaje WhatsApp al cliente:
   ```
   📅 Recordatorio de Cita - O-King Barber
   
   ¡Hola Juan! 👋
   Te recordamos que tienes una cita en 30 minutos
   
   🕒 Hora: 08:30
   💈 Barbero: Carlos
   ✂️ Servicio: Corte + Barba
   📍 Ubicación: Arturo Prat 653, Santiago
   ```
6. **08:30 AM** - Cliente asiste a la cita

## 🎯 Personalizar Mensaje

En `api/recordatorios.js`, editar la sección:

```javascript
const mensaje = `
📅 *Recordatorio de Cita - O-King Barber*

¡Hola ${cita.clientes.nombre}! 👋
// ... tu mensaje personalizado
`.trim();
```

## ⚠️ Costos

- **WhatsApp Business API**: $0.05 USD por mensaje (aproximadamente)
- Para O-King Barber (~10 citas/día): ~$15-20 USD/mes

## 🔗 Recursos Útiles

- [Meta WhatsApp Business API Docs](https://developers.facebook.com/docs/whatsapp/cloud-api)
- [Vercel CRON Jobs](https://vercel.com/docs/crons)
- [Twilio Alternative](https://www.twilio.com/whatsapp) (más simple pero más caro)

## ✅ Checklist

- [ ] Crear cuenta en Meta Developers
- [ ] Obtener WhatsApp Token y Phone ID
- [ ] Agregar variables en Vercel
- [ ] Ejecutar SQL de recordatorios
- [ ] Configurar CRON en vercel.json
- [ ] Testear recordatorios
- [ ] Personalizar mensaje
- [ ] Deploy en Vercel
