-- ============================================================
-- PRUTVYP1
-- Software Intellectual Property Protection System
-- Final Database Schema - SQLite
-- ============================================================

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
        ON UPDATE CASCADE
);


-- ============================================================
-- 5. APPLICATION REGIONS
-- ============================================================
-- Stores the regions selected for each software application.
--
-- Example:
-- Application 1 → India
-- Application 1 → USA
-- Application 1 → Europe
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
-- 6. APPLICATION IP TYPES
-- ============================================================
-- Stores the IP types selected for a software application.
--
-- Example:
-- Application 1 → Copyright
-- Application 1 → Patent
-- Application 1 → Trademark
-- ============================================================

CREATE TABLE IF NOT EXISTS application_ip_types (
    application_ip_type_id INTEGER PRIMARY KEY AUTOINCREMENT,

    application_id INTEGER NOT NULL,
    ip_type_id INTEGER NOT NULL,

    FOREIGN KEY (application_id)
        REFERENCES applications(application_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (ip_type_id)
        REFERENCES ip_types(ip_type_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    UNIQUE (application_id, ip_type_id)
);


-- ============================================================
-- 7. IP REQUIREMENTS
-- ============================================================
-- Master list of requirements.
--
-- Each requirement belongs to:
--   1. An IP type
--   2. A region
--
-- Each requirement also stores:
--   - What the requirement is
--   - What needs to be done
--   - Whether it is mandatory
--   - Official source
--   - Official source URL
-- ============================================================

CREATE TABLE IF NOT EXISTS ip_requirements (
    requirement_id INTEGER PRIMARY KEY AUTOINCREMENT,

    ip_type_id INTEGER NOT NULL,
    region_id INTEGER NOT NULL,

    requirement_title TEXT NOT NULL,
    requirement_description TEXT NOT NULL,

    action_required TEXT NOT NULL,

    mandatory INTEGER NOT NULL DEFAULT 1
        CHECK (mandatory IN (0, 1)),

    source_name TEXT,
    source_url TEXT,

    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (ip_type_id)
        REFERENCES ip_types(ip_type_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (region_id)
        REFERENCES regions(region_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- ============================================================
-- 8. APPLICATION REQUIREMENTS
-- ============================================================
-- Stores the actual assessment result for each application.
--
-- Example:
--
-- AI Healthcare Platform
-- India
-- Copyright Requirement 1 → completed
-- Copyright Requirement 2 → completed
-- Copyright Requirement 3 → completed
--
-- AI Healthcare Platform
-- India
-- Patent Requirement 1 → completed
-- Patent Requirement 2 → pending
-- Patent Requirement 3 → pending
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
-- 9. INDEXES
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_applications_user
ON applications(user_id);

CREATE INDEX IF NOT EXISTS idx_applications_status
ON applications(status);

CREATE INDEX IF NOT EXISTS idx_application_regions_application
ON application_regions(application_id);

CREATE INDEX IF NOT EXISTS idx_application_regions_region
ON application_regions(region_id);

CREATE INDEX IF NOT EXISTS idx_application_ip_types_application
ON application_ip_types(application_id);

CREATE INDEX IF NOT EXISTS idx_application_ip_types_ip_type
ON application_ip_types(ip_type_id);

CREATE INDEX IF NOT EXISTS idx_ip_requirements_ip_type
ON ip_requirements(ip_type_id);

CREATE INDEX IF NOT EXISTS idx_ip_requirements_region
ON ip_requirements(region_id);

CREATE INDEX IF NOT EXISTS idx_application_requirements_application
ON application_requirements(application_id);

CREATE INDEX IF NOT EXISTS idx_application_requirements_requirement
ON application_requirements(requirement_id);


-- ============================================================
-- END OF SCHEMA
-- ============================================================
