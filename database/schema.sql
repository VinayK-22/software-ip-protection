-- ============================================================
-- PRUTVYP1
-- Software Intellectual Property Protection System
-- Database Schema - SQLite
-- ============================================================

-- Enable foreign key enforcement
PRAGMA foreign_keys = ON;


-- ============================================================
-- 1. USERS
-- ============================================================

CREATE TABLE IF NOT EXISTS users (
    user_id INTEGER PRIMARY KEY AUTOINCREMENT,
    full_name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    role TEXT NOT NULL DEFAULT 'user'
        CHECK (role IN ('user', 'admin')),
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);


-- ============================================================
-- 2. REGIONS
-- ============================================================

CREATE TABLE IF NOT EXISTS regions (
    region_id INTEGER PRIMARY KEY AUTOINCREMENT,
    region_name TEXT NOT NULL UNIQUE,
    country_code TEXT NOT NULL UNIQUE,
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);


-- ============================================================
-- 3. IP TYPES
-- ============================================================

CREATE TABLE IF NOT EXISTS ip_types (
    ip_type_id INTEGER PRIMARY KEY AUTOINCREMENT,
    ip_type_name TEXT NOT NULL UNIQUE,
    description TEXT,
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);


-- ============================================================
-- 4. APPLICATIONS
-- ============================================================

CREATE TABLE IF NOT EXISTS applications (
    application_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    application_name TEXT NOT NULL,
    description TEXT,
    ip_type_id INTEGER NOT NULL,
    status TEXT NOT NULL DEFAULT 'draft'
        CHECK (
            status IN (
                'draft',
                'submitted',
                'under_review',
                'approved',
                'rejected'
            )
        ),
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (ip_type_id)
        REFERENCES ip_types(ip_type_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);


-- ============================================================
-- 5. IP REQUIREMENTS
-- ============================================================

CREATE TABLE IF NOT EXISTS ip_requirements (
    requirement_id INTEGER PRIMARY KEY AUTOINCREMENT,
    ip_type_id INTEGER NOT NULL,
    requirement_title TEXT NOT NULL,
    requirement_description TEXT NOT NULL,
    mandatory INTEGER NOT NULL DEFAULT 1
        CHECK (mandatory IN (0, 1)),
    source_reference TEXT,
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (ip_type_id)
        REFERENCES ip_types(ip_type_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- ============================================================
-- 6. APPLICATION REQUIREMENTS
-- ============================================================

CREATE TABLE IF NOT EXISTS application_requirements (
    application_requirement_id INTEGER PRIMARY KEY AUTOINCREMENT,
    application_id INTEGER NOT NULL,
    requirement_id INTEGER NOT NULL,
    status TEXT NOT NULL DEFAULT 'pending'
        CHECK (
            status IN (
                'pending',
                'completed',
                'not_applicable'
            )
        ),
    notes TEXT,
    completed_at TEXT,

    FOREIGN KEY (application_id)
        REFERENCES applications(application_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (requirement_id)
        REFERENCES ip_requirements(requirement_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    UNIQUE (application_id, requirement_id)
);


-- ============================================================
-- 7. APPLICATION REGIONS
-- ============================================================

CREATE TABLE IF NOT EXISTS application_regions (
    application_region_id INTEGER PRIMARY KEY AUTOINCREMENT,
    application_id INTEGER NOT NULL,
    region_id INTEGER NOT NULL,

    FOREIGN KEY (application_id)
        REFERENCES applications(application_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (region_id)
        REFERENCES regions(region_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    UNIQUE (application_id, region_id)
);


-- ============================================================
-- INDEXES
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_applications_user
ON applications(user_id);

CREATE INDEX IF NOT EXISTS idx_applications_ip_type
ON applications(ip_type_id);

CREATE INDEX IF NOT EXISTS idx_applications_status
ON applications(status);

CREATE INDEX IF NOT EXISTS idx_ip_requirements_ip_type
ON ip_requirements(ip_type_id);

CREATE INDEX IF NOT EXISTS idx_application_requirements_application
ON application_requirements(application_id);

CREATE INDEX IF NOT EXISTS idx_application_requirements_requirement
ON application_requirements(requirement_id);

CREATE INDEX IF NOT EXISTS idx_application_regions_application
ON application_regions(application_id);

CREATE INDEX IF NOT EXISTS idx_application_regions_region
ON application_regions(region_id);


-- ============================================================
-- END OF SCHEMA
-- ============================================================
