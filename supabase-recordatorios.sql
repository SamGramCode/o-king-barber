-- Tabla para registrar recordatorios enviados
CREATE TABLE recordatorios (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  cita_id UUID NOT NULL REFERENCES citas(id) ON DELETE CASCADE,
  tipo TEXT DEFAULT 'pre_cita_30min',
  enviado BOOLEAN DEFAULT false,
  fecha_envio TIMESTAMP,
  fecha_confirmacion TIMESTAMP,
  created_at TIMESTAMP DEFAULT now()
);

-- Tabla para configuración de WhatsApp
CREATE TABLE whatsapp_config (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  token TEXT NOT NULL,
  phone_id TEXT NOT NULL,
  numero_whatsapp TEXT,
  activo BOOLEAN DEFAULT true,
  created_at TIMESTAMP DEFAULT now()
);

-- Habilitar RLS
ALTER TABLE recordatorios ENABLE ROW LEVEL SECURITY;
ALTER TABLE whatsapp_config ENABLE ROW LEVEL SECURITY;

-- Políticas
CREATE POLICY "recordatorios_insert" ON recordatorios FOR INSERT WITH CHECK (true);
CREATE POLICY "recordatorios_update" ON recordatorios FOR UPDATE USING (true);
CREATE POLICY "whatsapp_config_read" ON whatsapp_config FOR SELECT USING (true);
