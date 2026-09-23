# Sistema de Recordatorios Manuales por WhatsApp

## ¿Cómo Funciona?

El admin panel tiene una **sección de Recordatorios** que muestra todas las citas próximas (próximas 24 horas).

Para cada cita hay un botón **"Enviar por WhatsApp"** que:

1. ✅ Genera automáticamente un mensaje personalizado
2. ✅ Abre WhatsApp Web con el mensaje ya escrito
3. ✅ Solo necesitas hacer clic en "Enviar"

## 📍 Ubicación en Admin

**Pasos:**
1. Ir a `/admin` (panel administrativo)
2. En el menú izquierdo, hacer clic en **"🔔 Recordatorios"**
3. Ver tabla de citas próximas
4. Hacer clic en **"Enviar por WhatsApp"**

## 📋 Campos de la Tabla

| Campo | Descripción |
|-------|-------------|
| Fecha | Fecha de la cita |
| Hora | Hora programada |
| Cliente | Nombre del cliente |
| WhatsApp | Número de teléfono |
| Barbero | Barbero asignado |
| Servicio | Servicio a realizar |
| Enviar | Botón para mandar recordatorio |

## 📝 Mensaje Automático

El sistema genera:

```
📅 Recordatorio de Cita - O-King Barber

¡Hola Juan! 👋

Te recordamos que tienes una cita próximamente

🕒 Hora: 10:00 AM
💈 Barbero: Carlos
✂️ Servicio: Corte + Barba
📍 Ubicación: Arturo Prat 653, Santiago

Si no puedes asistir, avísanos con tiempo.
¡Te esperamos! 💪
```

## 🔧 Personalizar Mensaje

Editar en `admin.html`, línea ~585:

```javascript
const mensaje = `
📅 Recordatorio de Cita - O-King Barber

¡Hola ${nombre}! 👋

// Aquí tu mensaje personalizado

🕒 Hora: ${hora}
💈 Barbero: ${barbero}
`;
```

## ⚙️ Requisitos

✅ Tener WhatsApp abierto en el navegador (`web.whatsapp.com`)
✅ Estar logueado en WhatsApp Web
✅ Números de teléfono en formato internacional (+56 9 XXXX XXXX)

## 🎯 Flujo Típico

```
1. 08:00 AM → Cliente agenda cita para 10:00 AM
2. 09:00 AM → Admin abre panel de recordatorios
3. 09:00 AM → Ve cita de Juan a las 10:00 AM
4. 09:00 AM → Hace clic en "Enviar por WhatsApp"
5. 09:00 AM → Se abre WhatsApp Web con mensaje listo
6. 09:00 AM → Admin hace clic en "Enviar"
7. 09:01 AM → Juan recibe recordatorio por WhatsApp
8. 10:00 AM → Juan llega a la cita ✅
```

## ✅ Ventajas

- ✨ **Sin costo** - No necesita API ni Meta Developers
- 🚀 **Instant** - Mensaje se envía al momento
- 📱 **Personal** - Mensaje personalizado para cada cliente
- 🔐 **Seguro** - Controla qué se envía antes de enviar
- 🎯 **Flexible** - Puedes enviar cuando quieras

## ⚠️ Limitaciones

- 🖱️ **Manual** - Debe hacer clic cada recordatorio
- 📱 **Requiere WhatsApp Web** - Debe estar abierto
- ⏰ **No automático** - No se envía solo en la hora exacta

## 🚀 Alternativa: Automático

Si después quieres automatizar (sin Meta Developers), puedes usar:
- **Twilio** (~$0.01 USD por mensaje)
- **n8n** (Gratis, self-hosted)
- **Zapier** (Pago, pero más fácil)

## 📞 Soporte

Para cambiar el mensaje, editar `admin.html` en la función `enviarRecordatorio()`.

---

**O-King Barber - Recordatorios Simple y Efectivo** 💈
