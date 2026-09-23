// Este archivo corre cada 5-10 minutos (configurar en Vercel CRON)
// Envía recordatorios por WhatsApp 30 minutos antes de las citas

export default async function handler(req, res) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Solo POST' });
  }

  // Credenciales de WhatsApp Business API (obtener en meta.com)
  const WHATSAPP_TOKEN = process.env.WHATSAPP_TOKEN;
  const WHATSAPP_PHONE_ID = process.env.WHATSAPP_PHONE_ID;
  const SUPABASE_URL = process.env.SUPABASE_URL;
  const SUPABASE_KEY = process.env.SUPABASE_KEY;

  try {
    // 1. Obtener todas las citas de HOY
    const ahora = new Date();
    const hoy = ahora.toISOString().split('T')[0];

    const response = await fetch(
      `${SUPABASE_URL}/rest/v1/citas?fecha=eq.${hoy}&select=*,clientes(*),barberos(*),servicios(*)`,
      {
        headers: {
          'apikey': SUPABASE_KEY,
          'Content-Type': 'application/json'
        }
      }
    );

    const citas = await response.json();

    // 2. Filtrar citas que son en 30 minutos
    const citasParaRecordar = citas.filter(cita => {
      const [horaStr, minutoStr] = cita.hora.split(':');
      const horaCita = new Date();
      horaCita.setHours(parseInt(horaStr), parseInt(minutoStr), 0);

      // Diferencia en milisegundos
      const diferencia = horaCita - ahora;

      // Si está entre 25-35 minutos, enviar recordatorio
      return diferencia > 25 * 60 * 1000 && diferencia < 35 * 60 * 1000;
    });

    console.log(`Encontradas ${citasParaRecordar.length} citas para recordar`);

    // 3. Enviar mensajes por WhatsApp
    for (const cita of citasParaRecordar) {
      // Verificar si ya se envió el recordatorio (agregar flag en DB)
      const yaSendMensaje = await checkMensajeEnviado(cita.id, SUPABASE_URL, SUPABASE_KEY);

      if (yaSendMensaje) continue;

      const mensaje = `
📅 *Recordatorio de Cita - O-King Barber*

¡Hola ${cita.clientes.nombre}! 👋

Te recordamos que tienes una cita en *30 minutos*

🕒 *Hora:* ${cita.hora}
💈 *Barbero:* ${cita.barberos.nombre}
✂️ *Servicio:* ${cita.servicios.nombre}
📍 *Ubicación:* Arturo Prat 653, Santiago

Si no puedes asistir, avísanos con tiempo.

¡Te esperamos! 💪
      `.trim();

      // Enviar por WhatsApp Business API
      await enviarWhatsApp(
        cita.clientes.whatsapp,
        mensaje,
        WHATSAPP_TOKEN,
        WHATSAPP_PHONE_ID
      );

      // Marcar como enviado
      await marcarRecordatorioEnviado(cita.id, SUPABASE_URL, SUPABASE_KEY);

      console.log(`✅ Recordatorio enviado a ${cita.clientes.whatsapp}`);
    }

    res.status(200).json({
      success: true,
      mensaje: `${citasParaRecordar.length} recordatorios enviados`
    });

  } catch (error) {
    console.error('Error:', error);
    res.status(500).json({ error: error.message });
  }
}

async function enviarWhatsApp(telefono, mensaje, token, phoneId) {
  try {
    const response = await fetch(
      `https://graph.instagram.com/v18.0/${phoneId}/messages`,
      {
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${token}`,
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          messaging_product: 'whatsapp',
          to: telefono.replace(/[^0-9]/g, ''), // Solo números
          type: 'text',
          text: {
            preview_url: true,
            body: mensaje
          }
        })
      }
    );

    if (!response.ok) {
      throw new Error(`WhatsApp API error: ${response.status}`);
    }

    return await response.json();
  } catch (error) {
    console.error('Error enviando WhatsApp:', error);
    throw error;
  }
}

async function checkMensajeEnviado(citaId, url, key) {
  try {
    const response = await fetch(
      `${url}/rest/v1/recordatorios?cita_id=eq.${citaId}`,
      {
        headers: {
          'apikey': key,
          'Content-Type': 'application/json'
        }
      }
    );
    const data = await response.json();
    return data.length > 0;
  } catch {
    return false;
  }
}

async function marcarRecordatorioEnviado(citaId, url, key) {
  try {
    await fetch(
      `${url}/rest/v1/recordatorios`,
      {
        method: 'POST',
        headers: {
          'apikey': key,
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          cita_id: citaId,
          tipo: 'pre_cita_30min',
          enviado: true,
          fecha_envio: new Date().toISOString()
        })
      }
    );
  } catch (error) {
    console.error('Error marcando recordatorio:', error);
  }
}
