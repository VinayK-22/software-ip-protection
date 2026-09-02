-- ============================================================
-- PRUTVYP1
-- Software & Application IP Protection System
-- MySQL-Optimized Database Schema
-- ============================================================
-- Changes vs original:
--   1. ENGINE=InnoDB + charset explicitly set per table (guarantees
--      FK enforcement even if a server default engine differs;
--      MyISAM silently ignores FOREIGN KEY clauses).
--   2. Removed indexes that duplicated indexes InnoDB creates
--      automatically for FK columns, or that were already covered
--      by the leftmost prefix of an existing UNIQUE key
--      (idx_authorities_jurisdiction, idx_sources_jurisdiction,
--      idx_sources_authority, idx_requirements_jurisdiction,
--      idx_requirements_category, idx_requirements_authority,
--      idx_project_requirements_project,
--      idx_project_requirements_requirement,
--      idx_project_documents_project). Fewer redundant indexes
--      = faster INSERT/UPDATE/DELETE, less disk/memory use.
--   3. Replaced them with composite indexes that actually match
--      likely query patterns (jurisdiction+category lookups,
--      jurisdiction+source type lookups, project+status lookups).
--   4. Added a CHECK constraint so effective_to can't precede
--      effective_from (MySQL 8.0.16+).
-- ============================================================

CREATE DATABASE IF NOT EXISTS software_ip_protection
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE software_ip_protection;


-- ============================================================
-- 1. JURISDICTIONS
-- ============================================================

CREATE TABLE jurisdictions (
    jurisdiction_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    jurisdiction_code VARCHAR(20) NOT NULL UNIQUE,
    jurisdiction_name VARCHAR(100) NOT NULL,
    jurisdiction_type ENUM('COUNTRY', 'REGION') NOT NULL,

    description TEXT,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ============================================================
-- 2. IP CATEGORIES
-- ============================================================

CREATE TABLE ip_categories (
    category_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    category_code VARCHAR(30) NOT NULL UNIQUE,
    category_name VARCHAR(100) NOT NULL UNIQUE,

    description TEXT,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ============================================================
-- 3. IP AUTHORITIES
-- ============================================================

CREATE TABLE authorities (
    authority_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    jurisdiction_id INT UNSIGNED NOT NULL,

    authority_name VARCHAR(255) NOT NULL,
    authority_abbreviation VARCHAR(50),

    official_website VARCHAR(500),

    description TEXT,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_authority_jurisdiction
        FOREIGN KEY (jurisdiction_id)
        REFERENCES jurisdictions(jurisdiction_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT uq_authority_jurisdiction_name
        UNIQUE (jurisdiction_id, authority_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ============================================================
-- 4. SOURCES
-- ============================================================

CREATE TABLE sources (
    source_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    jurisdiction_id INT UNSIGNED NOT NULL,
    authority_id INT UNSIGNED NULL,

    source_title VARCHAR(500) NOT NULL,

    source_type ENUM(
        'LAW',
        'RULE',
        'GUIDELINE',
        'MANUAL',
        'OFFICIAL_WEBSITE',
        'REGISTRATION_PORTAL',
        'FORM',
        'OTHER'
    ) NOT NULL,

    source_url VARCHAR(1000),

    publication_date DATE,
    last_reviewed_date DATE,

    description TEXT,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_source_jurisdiction
        FOREIGN KEY (jurisdiction_id)
        REFERENCES jurisdictions(jurisdiction_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_source_authority
        FOREIGN KEY (authority_id)
        REFERENCES authorities(authority_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ============================================================
-- 5. REQUIREMENTS
-- ============================================================

CREATE TABLE requirements (
    requirement_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    jurisdiction_id INT UNSIGNED NOT NULL,
    category_id INT UNSIGNED NOT NULL,
    authority_id INT UNSIGNED NULL,

    requirement_code VARCHAR(50) NOT NULL UNIQUE,
    requirement_name VARCHAR(500) NOT NULL,

    description TEXT,

    requirement_type ENUM(
        'ELIGIBILITY',
        'REGISTRATION',
        'DOCUMENT',
        'PROCEDURE',
        'OWNERSHIP',
        'FILING',
        'EXAMINATION',
        'RENEWAL',
        'OTHER'
    ) NOT NULL DEFAULT 'OTHER',

    applicability ENUM(
        'MANDATORY',
        'CONDITIONAL',
        'OPTIONAL',
        'INFORMATIONAL'
    ) NOT NULL DEFAULT 'INFORMATIONAL',

    priority ENUM(
        'HIGH',
        'MEDIUM',
        'LOW'
    ) NOT NULL DEFAULT 'MEDIUM',

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    effective_from DATE,
    effective_to DATE,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_requirement_jurisdiction
        FOREIGN KEY (jurisdiction_id)
        REFERENCES jurisdictions(jurisdiction_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_requirement_category
        FOREIGN KEY (category_id)
        REFERENCES ip_categories(category_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_requirement_authority
        FOREIGN KEY (authority_id)
        REFERENCES authorities(authority_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,

    CONSTRAINT chk_requirement_effective_dates
        CHECK (effective_to IS NULL OR effective_from IS NULL OR effective_to >= effective_from)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ============================================================
-- 6. REQUIREMENT SOURCES (M:N)
-- ============================================================

CREATE TABLE requirement_sources (
    requirement_id INT UNSIGNED NOT NULL,
    source_id INT UNSIGNED NOT NULL,

    PRIMARY KEY (requirement_id, source_id),

    CONSTRAINT fk_requirement_source_requirement
        FOREIGN KEY (requirement_id)
        REFERENCES requirements(requirement_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_requirement_source_source
        FOREIGN KEY (source_id)
        REFERENCES sources(source_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ============================================================
-- 7. DOCUMENT TYPES
-- ============================================================

CREATE TABLE document_types (
    document_type_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    document_code VARCHAR(50) NOT NULL UNIQUE,
    document_name VARCHAR(255) NOT NULL UNIQUE,

    description TEXT,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ============================================================
-- 8. REQUIREMENT DOCUMENTS
-- ============================================================

CREATE TABLE requirement_documents (
    requirement_id INT UNSIGNED NOT NULL,
    document_type_id INT UNSIGNED NOT NULL,

    is_mandatory BOOLEAN NOT NULL DEFAULT FALSE,

    description TEXT,

    PRIMARY KEY (requirement_id, document_type_id),

    CONSTRAINT fk_requirement_document_requirement
        FOREIGN KEY (requirement_id)
        REFERENCES requirements(requirement_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_requirement_document_type
        FOREIGN KEY (document_type_id)
        REFERENCES document_types(document_type_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ============================================================
-- 9. SOFTWARE PROJECTS
-- ============================================================

CREATE TABLE software_projects (
    project_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    project_name VARCHAR(255) NOT NULL,
    project_description TEXT,

    software_type ENUM(
        'WEB_APPLICATION',
        'MOBILE_APPLICATION',
        'DESKTOP_APPLICATION',
        'SAAS',
        'API',
        'AI_APPLICATION',
        'SOFTWARE_LIBRARY',
        'OTHER'
    ) NOT NULL DEFAULT 'OTHER',

    development_stage ENUM(
        'IDEA',
        'PROTOTYPE',
        'DEVELOPMENT',
        'TESTING',
        'PRODUCTION'
    ) NOT NULL DEFAULT 'IDEA',

    organization_name VARCHAR(255),
    created_by VARCHAR(255),

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ============================================================
-- 10. PROJECT JURISDICTIONS
-- ============================================================

CREATE TABLE project_jurisdictions (
    project_id INT UNSIGNED NOT NULL,
    jurisdiction_id INT UNSIGNED NOT NULL,

    PRIMARY KEY (project_id, jurisdiction_id),

    CONSTRAINT fk_project_jurisdiction_project
        FOREIGN KEY (project_id)
        REFERENCES software_projects(project_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_project_jurisdiction_jurisdiction
        FOREIGN KEY (jurisdiction_id)
        REFERENCES jurisdictions(jurisdiction_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ============================================================
-- 11. PROJECT IP CATEGORIES
-- ============================================================

CREATE TABLE project_ip_categories (
    project_id INT UNSIGNED NOT NULL,
    category_id INT UNSIGNED NOT NULL,

    PRIMARY KEY (project_id, category_id),

    CONSTRAINT fk_project_category_project
        FOREIGN KEY (project_id)
        REFERENCES software_projects(project_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_project_category_category
        FOREIGN KEY (category_id)
        REFERENCES ip_categories(category_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ============================================================
-- 12. PROJECT REQUIREMENTS
-- ============================================================

CREATE TABLE project_requirements (
    project_requirement_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    project_id INT UNSIGNED NOT NULL,
    requirement_id INT UNSIGNED NOT NULL,

    status ENUM(
        'NOT_STARTED',
        'IN_PROGRESS',
        'COMPLETED',
        'NOT_APPLICABLE'
    ) NOT NULL DEFAULT 'NOT_STARTED',

    response TEXT,
    notes TEXT,

    reviewed_by VARCHAR(255),
    reviewed_at DATETIME,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT uq_project_requirement
        UNIQUE (project_id, requirement_id),

    CONSTRAINT fk_project_requirement_project
        FOREIGN KEY (project_id)
        REFERENCES software_projects(project_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_project_requirement_requirement
        FOREIGN KEY (requirement_id)
        REFERENCES requirements(requirement_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ============================================================
-- 13. PROJECT DOCUMENTS
-- ============================================================

CREATE TABLE project_documents (
    project_document_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    project_id INT UNSIGNED NOT NULL,
    document_type_id INT UNSIGNED NULL,

    document_name VARCHAR(500) NOT NULL,
    file_path VARCHAR(1000),

    document_status ENUM(
        'UPLOADED',
        'PENDING',
        'VERIFIED',
        'REJECTED'
    ) NOT NULL DEFAULT 'PENDING',

    notes TEXT,

    uploaded_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_project_document_project
        FOREIGN KEY (project_id)
        REFERENCES software_projects(project_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_project_document_type
        FOREIGN KEY (document_type_id)
        REFERENCES document_types(document_type_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ============================================================
-- INDEXES
-- Only non-redundant indexes: InnoDB auto-indexes single FK
-- columns (and unique-key leftmost prefixes) on its own, so
-- those are intentionally NOT recreated here.
-- ============================================================

-- Composite: filter requirements by jurisdiction + category
-- (also serves as the FK index for jurisdiction_id)
CREATE INDEX idx_requirements_jurisdiction_category
    ON requirements(jurisdiction_id, category_id);

CREATE INDEX idx_requirements_type
    ON requirements(requirement_type);

CREATE INDEX idx_requirements_applicability
    ON requirements(applicability);

-- Composite: filter sources by jurisdiction + type
-- (also serves as the FK index for jurisdiction_id)
CREATE INDEX idx_sources_jurisdiction_type
    ON sources(jurisdiction_id, source_type);

-- Composite: "requirements pending/in-progress for project X"
-- (also serves as the FK index for project_id)
CREATE INDEX idx_project_requirements_project_status
    ON project_requirements(project_id, status);


-- ============================================================
-- INITIAL JURISDICTIONS
-- ============================================================

INSERT INTO jurisdictions (
    jurisdiction_code,
    jurisdiction_name,
    jurisdiction_type,
    description
)
VALUES
(
    'IN',
    'India',
    'COUNTRY',
    'Indian intellectual property jurisdiction.'
),
(
    'US',
    'United States',
    'COUNTRY',
    'United States intellectual property jurisdiction.'
),
(
    'EU',
    'European Union',
    'REGION',
    'European Union intellectual property framework.'
);


-- ============================================================
-- INITIAL IP CATEGORIES
-- ============================================================

INSERT INTO ip_categories (
    category_code,
    category_name,
    description
)
VALUES
(
    'COPYRIGHT',
    'Copyright',
    'Protection of original software code, documentation and related works.'
),
(
    'PATENT',
    'Patent',
    'Protection for eligible inventions and computer-implemented inventions.'
),
(
    'TRADEMARK',
    'Trademark',
    'Protection of names, logos and other identifiers.'
),
(
    'DESIGN',
    'Design',
    'Protection of eligible visual or industrial design aspects.'
),
(
    'TRADE_SECRET',
    'Trade Secret',
    'Protection of confidential and commercially valuable information.'
),
(
    'OWNERSHIP',
    'Ownership',
    'Information relating to ownership, assignment and licensing.'
);


-- ============================================================
-- INITIAL DOCUMENT TYPES
-- ============================================================

INSERT INTO document_types (
    document_code,
    document_name,
    description
)
VALUES
(
    'SOURCE_CODE',
    'Source Code',
    'Source code associated with the software.'
),
(
    'OBJECT_CODE',
    'Object Code',
    'Compiled software code where applicable.'
),
(
    'OWNERSHIP_PROOF',
    'Ownership Proof',
    'Document establishing ownership of the software or IP.'
),
(
    'ASSIGNMENT_AGREEMENT',
    'Assignment Agreement',
    'Agreement transferring IP rights.'
),
(
    'EMPLOYMENT_AGREEMENT',
    'Employment Agreement',
    'Employment agreement relevant to IP ownership.'
),
(
    'LICENSE_AGREEMENT',
    'License Agreement',
    'Agreement granting rights to use or exploit IP.'
),
(
    'SOFTWARE_DESCRIPTION',
    'Software Description',
    'Description of the software and its functionality.'
),
(
    'USER_MANUAL',
    'User Manual',
    'Documentation for using the software.'
),
(
    'APPLICATION_FORM',
    'Application Form',
    'Official IP application or registration form.'
),
(
    'OTHER',
    'Other',
    'Other supporting document.'
);


-- ============================================================
-- END OF PRUTVYP1 SCHEMA (MYSQL-OPTIMIZED)
-- ============================================================
