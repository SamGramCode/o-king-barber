-- Tabla de Barberos
CREATE TABLE barberos (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre TEXT NOT NULL,
  foto_url TEXT,
  experiencia TEXT,
  activo BOOLEAN DEFAULT true,
  created_at TIMESTAMP DEFAULT now()
);

-- Tabla de Servicios
CREATE TABLE servicios (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre TEXT NOT NULL,
  precio INTEGER NOT NULL,
  descripcion TEXT,
  activo BOOLEAN DEFAULT true,
  created_at TIMESTAMP DEFAULT now()
);

-- Tabla de Clientes
CREATE TABLE clientes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre TEXT NOT NULL,
  whatsapp TEXT UNIQUE NOT NULL,
  fecha_nacimiento DATE,
  cortes_realizados INTEGER DEFAULT 0,
  gasto_total INTEGER DEFAULT 0,
  created_at TIMESTAMP DEFAULT now()
);

-- Tabla de Citas
CREATE TABLE citas (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  cliente_id UUID NOT NULL REFERENCES clientes(id) ON DELETE CASCADE,
  barbero_id UUID NOT NULL REFERENCES barberos(id) ON DELETE CASCADE,
  servicio_id UUID NOT NULL REFERENCES servicios(id) ON DELETE CASCADE,
  fecha DATE NOT NULL,
  hora TEXT NOT NULL,
  estado TEXT DEFAULT 'confirmada',
  precio INTEGER,
  created_at TIMESTAMP DEFAULT now()
);

-- Tabla de Productos
CREATE TABLE productos (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre TEXT NOT NULL,
  precio INTEGER NOT NULL,
  stock INTEGER DEFAULT 0,
  foto_url TEXT,
  activo BOOLEAN DEFAULT true,
  created_at TIMESTAMP DEFAULT now()
);

-- Tabla de Promociones
CREATE TABLE promociones (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tipo TEXT NOT NULL,
  descripcion TEXT,
  descuento INTEGER DEFAULT 0,
  condicion TEXT,
  fecha_inicio DATE,
  fecha_fin DATE,
  activo BOOLEAN DEFAULT true,
  created_at TIMESTAMP DEFAULT now()
);

-- Tabla de Souvenirs
CREATE TABLE souvenirs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre TEXT NOT NULL,
  descripcion TEXT,
  foto_url TEXT,
  stock INTEGER DEFAULT 0,
  reclamados INTEGER DEFAULT 0,
  created_at TIMESTAMP DEFAULT now()
);

-- Tabla de Auditoría (registro de ganancia por barbero)
CREATE TABLE auditoria_barberos (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  barbero_id UUID NOT NULL REFERENCES barberos(id),
  fecha DATE NOT NULL,
  citas_realizadas INTEGER,
  ganancias_totales INTEGER,
  created_at TIMESTAMP DEFAULT now()
);

-- Tabla de Descuentos por Cumpleaños
CREATE TABLE descuentos_cumpleanos (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  cliente_id UUID NOT NULL REFERENCES clientes(id) ON DELETE CASCADE,
  porcentaje INTEGER DEFAULT 20,
  fecha_cumpleanos DATE,
  notificacion_enviada BOOLEAN DEFAULT false,
  created_at TIMESTAMP DEFAULT now()
);

-- Insertar datos de ejemplo
INSERT INTO barberos (nombre, experiencia) VALUES
  ('Carlos', '5 años'),
  ('Juan', '7 años'),
  ('Miguel', '3 años');

INSERT INTO servicios (nombre, precio, descripcion) VALUES
  ('Corte Clásico', 15000, 'Corte de cabello profesional'),
  ('Barba Completa', 10000, 'Afeitado y arreglo de barba'),
  ('Corte + Barba', 20000, 'Paquete completo'),
  ('Coloración', 25000, 'Tinte de cabello'),
  ('Tratamiento', 18000, 'Tratamiento capilar'),
  ('Suscripción Mensual', 60000, '4 cortes + 1 gratis');

INSERT INTO souvenirs (nombre, descripcion, stock) VALUES
  ('Toalla O-King', 'Toalla branded O-King Barber', 50),
  ('Gorra O-King', 'Gorra negra con logo O-King', 30),
  ('Espejo Barbero', 'Espejo con logo de la barbería', 20);

-- Habilitar RLS
ALTER TABLE barberos ENABLE ROW LEVEL SECURITY;
ALTER TABLE servicios ENABLE ROW LEVEL SECURITY;
ALTER TABLE clientes ENABLE ROW LEVEL SECURITY;
ALTER TABLE citas ENABLE ROW LEVEL SECURITY;
ALTER TABLE productos ENABLE ROW LEVEL SECURITY;
ALTER TABLE promociones ENABLE ROW LEVEL SECURITY;
ALTER TABLE souvenirs ENABLE ROW LEVEL SECURITY;
ALTER TABLE auditoria_barberos ENABLE ROW LEVEL SECURITY;
ALTER TABLE descuentos_cumpleanos ENABLE ROW LEVEL SECURITY;

-- Políticas de acceso público (lectura)
CREATE POLICY "barberos_read" ON barberos FOR SELECT TO PUBLIC USING (true);
CREATE POLICY "servicios_read" ON servicios FOR SELECT TO PUBLIC USING (activo = true);
CREATE POLICY "productos_read" ON productos FOR SELECT TO PUBLIC USING (activo = true);
CREATE POLICY "promociones_read" ON promociones FOR SELECT TO PUBLIC USING (activo = true);
CREATE POLICY "souvenirs_read" ON souvenirs FOR SELECT TO PUBLIC USING (true);
