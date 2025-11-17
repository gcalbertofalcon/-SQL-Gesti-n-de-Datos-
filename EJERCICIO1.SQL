-- =========================================================================
-- 1. CREACIÓN Y USO DE LA BASE DE DATOS
-- =========================================================================

-- Crea la base de datos para el proyecto.
CREATE DATABASE ejercO1_db;

-- Selecciona la base de datos para trabajar con ella.
USE ejercO1_db;

-- =========================================================================
-- 2. TABLA TPROFESORES (ASUMIMOS QUE TACADEMIA ERAN PROFESORES)
-- Esta tabla debería ser la TPROFESORES, ya que tiene nombres y apellidos.
-- =========================================================================

CREATE TABLE TPROFESORES (
    -- Clave Primaria (PK): Identificador único del profesor.
    ID_PROFESOR INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    NOMBRE VARCHAR(255) NOT NULL,
    APELLIDO1 VARCHAR(150) NOT NULL,
    APELLIDO2 VARCHAR(150),
    -- El email es único para cada profesor.
    EMAIL VARCHAR(255) UNIQUE, 
    TELEFONO VARCHAR(20)
);

-- =========================================================================
-- 3. TABLA ALUMNOS
-- Almacena la información de cada estudiante.
-- =========================================================================

CREATE TABLE ALUMNOS (
    -- Clave Primaria (PK): Identificador único del alumno.
    ID_ALUMNO INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    NOMBRE VARCHAR(255) NOT NULL,
    APELLIDO1 VARCHAR(150) NOT NULL,
    APELLIDO2 VARCHAR(150),
    -- El email es único para cada alumno.
    EMAIL VARCHAR(255) UNIQUE,
    TELEFONO VARCHAR(20)
    -- ID_ACADEMIA: Se asume que esta tabla debería ser la Academia principal
    -- ID_ACADEMIA INT NOT NULL -- Se elimina temporalmente si no hay tabla ACADEMIAS
);


-- =========================================================================
-- 4. TABLA TCURSOS
-- Almacena la información de los cursos que se ofrecen.
-- =========================================================================

CREATE TABLE TCURSOS (
    -- Clave Primaria (PK): Identificador único del curso.
    ID_CURSO INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    NOMBRE VARCHAR(255) NOT NULL,
    DESCRIPCION TEXT,
    -- Clave Foránea (FK): Relaciona el curso con el profesor que lo imparte.
    -- RELACIÓN: Profesor (1) imparte a Curso (N) -> 1,N
    ID_PROFESOR INT NOT NULL, 
    FOREIGN KEY (ID_PROFESOR) REFERENCES TPROFESORES(ID_PROFESOR)
);


-- =========================================================================
-- 5. TABLA TCURSOS_ALUMNOS (Tabla Intermedia)
-- Resuelve la relación Muchos a Muchos (N, M) entre Alumnos y Cursos.
-- =========================================================================

CREATE TABLE TCURSOS_ALUMNOS (
    -- Clave Foránea (FK): Identifica al alumno que toma el curso.
    ID_ALUMNO INT NOT NULL, 
    -- Clave Foránea (FK): Identifica el curso que es tomado.
    ID_CURSO INT NOT NULL, 
    
    -- La combinación de ambos IDs es la Clave Primaria compuesta.
    PRIMARY KEY (ID_ALUMNO, ID_CURSO),
    
    -- RELACIÓN: Alumno (N) se matricula en Curso (M) -> N, M
    FOREIGN KEY (ID_ALUMNO) REFERENCES ALUMNOS(ID_ALUMNO),
    FOREIGN KEY (ID_CURSO) REFERENCES TCURSOS(ID_CURSO)
);


-- =========================================================================
-- 6. TABLA NOTAS (Corregida y Relacionada)
-- Almacena las calificaciones de un alumno en un curso específico.
-- =========================================================================

CREATE TABLE NOTAS (
    -- Clave Primaria (PK) de la tabla NOTAS
    ID_NOTA INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    
    -- Claves Foráneas (FK) para relacionar la nota con la matrícula
    -- Asumimos que la nota es para una matrícula (Alumno + Curso)
    ID_ALUMNO INT NOT NULL,
    ID_CURSO INT NOT NULL,
    
    NOTA DECIMAL(4, 2) NOT NULL, -- Uso de DECIMAL para notas con decimales
    FECHA_NOTA DATE,
    
    -- RELACIÓN: Matrícula (1) tiene Notas (N) -> 1, N
    FOREIGN KEY (ID_ALUMNO, ID_CURSO) REFERENCES TCURSOS_ALUMNOS(ID_ALUMNO, ID_CURSO)
);

-- =========================================================================
-- 7. TABLA TIENEN (Se elimina o se define con un propósito claro, ej: ASIGNATURAS)
-- La tabla original estaba vacía. Si no tiene un propósito claro, se omite.
-- =========================================================================
