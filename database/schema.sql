CREATE DATABASE IF NOT EXISTS software_ip_protection;

USE software_ip_protection;


-- Jurisdictions

CREATE TABLE jurisdictions (
    jurisdiction_id INT AUTO_INCREMENT PRIMARY KEY,
    jurisdiction_code VARCHAR(20) NOT NULL UNIQUE,
    jurisdiction_name VARCHAR(100) NOT NULL,
    jurisdiction_type ENUM('COUNTRY', 'REGION') NOT NULL,
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP
);


-- IP categories

CREATE TABLE ip_categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_code VARCHAR(30) NOT NULL UNIQUE,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- IP authorities

CREATE TABLE authorities (
    authority_id INT AUTO_INCREMENT PRIMARY KEY,
    jurisdiction_id INT NOT NULL,
    authority_name VARCHAR(255) NOT NULL,
    authority_abbreviation VARCHAR(50),
    official_website VARCHAR(500),
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (jurisdiction_id)
        REFERENCES jurisdictions(jurisdiction_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);


-- Sources

CREATE TABLE sources (
    source_id INT AUTO_INCREMENT PRIMARY KEY,
    jurisdiction_id INT NOT NULL,
    authority_id INT,
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
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (jurisdiction_id)
        REFERENCES jurisdictions(jurisdiction_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    FOREIGN KEY (authority_id)
        REFERENCES authorities(authority_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);


-- IP requirements

CREATE TABLE requirements (
    requirement_id INT AUTO_INCREMENT PRIMARY KEY,
    jurisdiction_id INT NOT NULL,
    category_id INT NOT NULL,
    authority_id INT,

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
    ) DEFAULT 'OTHER',

    applicability ENUM(
        'MANDATORY',
        'CONDITIONAL',
        'OPTIONAL',
        'INFORMATIONAL'
    ) DEFAULT 'INFORMATIONAL',

    priority ENUM(
        'HIGH',
        'MEDIUM',
        'LOW'
    ) DEFAULT 'MEDIUM',

    is_active BOOLEAN DEFAULT TRUE,

    effective_from DATE,
    effective_to DATE,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (jurisdiction_id)
        REFERENCES jurisdictions(jurisdiction_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    FOREIGN KEY (category_id)
        REFERENCES ip_categories(category_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    FOREIGN KEY (authority_id)
        REFERENCES authorities(authority_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);


-- Requirement sources

CREATE TABLE requirement_sources (
    requirement_id INT NOT NULL,
    source_id INT NOT NULL,

    PRIMARY KEY (requirement_id, source_id),

    FOREIGN KEY (requirement_id)
        REFERENCES requirements(requirement_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (source_id)
        REFERENCES sources(source_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- Document types

CREATE TABLE document_types (
    document_type_id INT AUTO_INCREMENT PRIMARY KEY,
    document_code VARCHAR(50) NOT NULL UNIQUE,
    document_name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Documents associated with requirements

CREATE TABLE requirement_documents (
    requirement_id INT NOT NULL,
    document_type_id INT NOT NULL,
    is_mandatory BOOLEAN DEFAULT FALSE,
    description TEXT,

    PRIMARY KEY (requirement_id, document_type_id),

    FOREIGN KEY (requirement_id)
        REFERENCES requirements(requirement_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (document_type_id)
        REFERENCES document_types(document_type_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- Software projects

CREATE TABLE software_projects (
    project_id INT AUTO_INCREMENT PRIMARY KEY,

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
    ) DEFAULT 'OTHER',

    development_stage ENUM(
        'IDEA',
        'PROTOTYPE',
        'DEVELOPMENT',
        'TESTING',
        'PRODUCTION'
    ) DEFAULT 'IDEA',

    organization_name VARCHAR(255),
    created_by VARCHAR(255),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP
);


-- Project jurisdictions

CREATE TABLE project_jurisdictions (
    project_id INT NOT NULL,
    jurisdiction_id INT NOT NULL,

    PRIMARY KEY (project_id, jurisdiction_id),

    FOREIGN KEY (project_id)
        REFERENCES software_projects(project_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (jurisdiction_id)
        REFERENCES jurisdictions(jurisdiction_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- Project IP categories

CREATE TABLE project_ip_categories (
    project_id INT NOT NULL,
    category_id INT NOT NULL,

    PRIMARY KEY (project_id, category_id),

    FOREIGN KEY (project_id)
        REFERENCES software_projects(project_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (category_id)
        REFERENCES ip_categories(category_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- Project requirement status

CREATE TABLE project_requirements (
    project_requirement_id INT AUTO_INCREMENT PRIMARY KEY,

    project_id INT NOT NULL,
    requirement_id INT NOT NULL,

    status ENUM(
        'NOT_STARTED',
        'IN_PROGRESS',
        'COMPLETED',
        'NOT_APPLICABLE'
    ) DEFAULT 'NOT_STARTED',

    response TEXT,
    notes TEXT,

    reviewed_by VARCHAR(255),
    reviewed_at DATETIME,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    UNIQUE (project_id, requirement_id),

    FOREIGN KEY (project_id)
        REFERENCES software_projects(project_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (requirement_id)
        REFERENCES requirements(requirement_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- Project documents

CREATE TABLE project_documents (
    project_document_id INT AUTO_INCREMENT PRIMARY KEY,

    project_id INT NOT NULL,
    document_type_id INT,

    document_name VARCHAR(500) NOT NULL,
    file_path VARCHAR(1000),

    document_status ENUM(
        'UPLOADED',
        'PENDING',
        'VERIFIED',
        'REJECTED'
    ) DEFAULT 'PENDING',

    notes TEXT,

    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (project_id)
        REFERENCES software_projects(project_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (document_type_id)
        REFERENCES document_types(document_type_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);


-- Indexes

CREATE INDEX idx_requirements_jurisdiction
    ON requirements(jurisdiction_id);

CREATE INDEX idx_requirements_category
    ON requirements(category_id);

CREATE INDEX idx_requirements_authority
    ON requirements(authority_id);

CREATE INDEX idx_sources_jurisdiction
    ON sources(jurisdiction_id);

CREATE INDEX idx_project_requirements_status
    ON project_requirements(status);


-- Initial jurisdictions

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


-- Initial IP categories

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


-- Initial document types

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
