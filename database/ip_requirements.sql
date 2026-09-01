```sql
USE software_ip_protection;


-- ============================================================
-- Authorities
-- ============================================================

INSERT INTO authorities
(
    jurisdiction_id,
    authority_name,
    authority_abbreviation,
    official_website,
    description
)
VALUES

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'IN'),
    'Copyright Office, Government of India',
    'Copyright Office',
    'https://copyright.gov.in/',
    'Authority responsible for copyright registration and administration in India.'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'IN'),
    'Office of the Controller General of Patents, Designs and Trade Marks',
    'CGPDTM',
    'https://ipindia.gov.in/',
    'Indian authority responsible for patents, designs and trademarks.'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'US'),
    'United States Copyright Office',
    'USCO',
    'https://www.copyright.gov/',
    'United States authority responsible for copyright registration and related administration.'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'US'),
    'United States Patent and Trademark Office',
    'USPTO',
    'https://www.uspto.gov/',
    'United States authority responsible for patents and trademarks.'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'EU'),
    'European Patent Office',
    'EPO',
    'https://www.epo.org/',
    'Authority responsible for the European patent system.'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'EU'),
    'European Union Intellectual Property Office',
    'EUIPO',
    'https://www.euipo.europa.eu/',
    'EU agency responsible for EU trade marks and registered EU designs.'
);


-- ============================================================
-- Sources - India
-- ============================================================

INSERT INTO sources
(
    jurisdiction_id,
    authority_id,
    source_title,
    source_type,
    source_url,
    last_reviewed_date,
    description
)
VALUES

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'IN'),
    (
        SELECT authority_id
        FROM authorities
        WHERE authority_abbreviation = 'Copyright Office'
        AND jurisdiction_id = (
            SELECT jurisdiction_id
            FROM jurisdictions
            WHERE jurisdiction_code = 'IN'
        )
    ),
    'Copyright Registration Online Filing Instructions',
    'REGISTRATION_PORTAL',
    'https://copyright.gov.in/UserRegistration/frmLoginPage.aspx',
    '2026-09-01',
    'Official instructions for online copyright registration, including software works.'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'IN'),
    (
        SELECT authority_id
        FROM authorities
        WHERE authority_abbreviation = 'CGPDTM'
        AND jurisdiction_id = (
            SELECT jurisdiction_id
            FROM jurisdictions
            WHERE jurisdiction_code = 'IN'
        )
    ),
    'Patent Resources and Guidelines',
    'GUIDELINE',
    'https://ipindia.gov.in/resource/patents-resources-guidelines',
    '2026-09-01',
    'Official patent guidelines and resources published by IP India.'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'IN'),
    (
        SELECT authority_id
        FROM authorities
        WHERE authority_abbreviation = 'CGPDTM'
        AND jurisdiction_id = (
            SELECT jurisdiction_id
            FROM jurisdictions
            WHERE jurisdiction_code = 'IN'
        )
    ),
    'Patents Act 1970 - Section 3',
    'LAW',
    'https://ipindia.gov.in/acts/patent-act-1970/section-3',
    '2026-09-01',
    'Official text of Section 3 of the Indian Patents Act, including Section 3(k).'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'IN'),
    (
        SELECT authority_id
        FROM authorities
        WHERE authority_abbreviation = 'CGPDTM'
        AND jurisdiction_id = (
            SELECT jurisdiction_id
            FROM jurisdictions
            WHERE jurisdiction_code = 'IN'
        )
    ),
    'Trademark Filing Process',
    'REGISTRATION_PORTAL',
    'https://ipindia.gov.in/application-workflow/trademark-filing-process',
    '2026-09-01',
    'Official trademark filing process published by IP India.'
);


-- ============================================================
-- Sources - USA
-- ============================================================

INSERT INTO sources
(
    jurisdiction_id,
    authority_id,
    source_title,
    source_type,
    source_url,
    last_reviewed_date,
    description
)
VALUES

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'US'),
    (
        SELECT authority_id
        FROM authorities
        WHERE authority_abbreviation = 'USCO'
        AND jurisdiction_id = (
            SELECT jurisdiction_id
            FROM jurisdictions
            WHERE jurisdiction_code = 'US'
        )
    ),
    'Circular 61 - Copyright Registration of Computer Programs',
    'GUIDELINE',
    'https://copyright.gov/circs/',
    '2026-09-01',
    'Official U.S. Copyright Office guidance concerning registration of computer programs.'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'US'),
    (
        SELECT authority_id
        FROM authorities
        WHERE authority_abbreviation = 'USCO'
        AND jurisdiction_id = (
            SELECT jurisdiction_id
            FROM jurisdictions
            WHERE jurisdiction_code = 'US'
        )
    ),
    'Computer Programs',
    'OFFICIAL_WEBSITE',
    'https://www.copyright.gov/register/tx-programs.html',
    '2026-09-01',
    'Official information about copyright protection for computer programs.'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'US'),
    (
        SELECT authority_id
        FROM authorities
        WHERE authority_abbreviation = 'USPTO'
        AND jurisdiction_id = (
            SELECT jurisdiction_id
            FROM jurisdictions
            WHERE jurisdiction_code = 'US'
        )
    ),
    'Patent Essentials',
    'OFFICIAL_WEBSITE',
    'https://www.uspto.gov/patents/basics/essentials',
    '2026-09-01',
    'Official USPTO patent eligibility and patent basics information.'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'US'),
    (
        SELECT authority_id
        FROM authorities
        WHERE authority_abbreviation = 'USPTO'
        AND jurisdiction_id = (
            SELECT jurisdiction_id
            FROM jurisdictions
            WHERE jurisdiction_code = 'US'
        )
    ),
    'How to Apply for a Patent',
    'REGISTRATION_PORTAL',
    'https://www.uspto.gov/patents/basics/patent-process-overview',
    '2026-09-01',
    'Official USPTO patent application process.'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'US'),
    (
        SELECT authority_id
        FROM authorities
        WHERE authority_abbreviation = 'USPTO'
        AND jurisdiction_id = (
            SELECT jurisdiction_id
            FROM jurisdictions
            WHERE jurisdiction_code = 'US'
        )
    ),
    'Trademark Basics',
    'OFFICIAL_WEBSITE',
    'https://www.uspto.gov/trademarks/basics',
    '2026-09-01',
    'Official USPTO trademark requirements and registration information.'
);


-- ============================================================
-- Sources - Europe
-- ============================================================

INSERT INTO sources
(
    jurisdiction_id,
    authority_id,
    source_title,
    source_type,
    source_url,
    last_reviewed_date,
    description
)
VALUES

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'EU'),
    NULL,
    'Directive 2009/24/EC on the Legal Protection of Computer Programs',
    'LAW',
    'https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:32009L0024',
    '2026-09-01',
    'EU legal framework for copyright protection of computer programs.'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'EU'),
    (
        SELECT authority_id
        FROM authorities
        WHERE authority_abbreviation = 'EPO'
        AND jurisdiction_id = (
            SELECT jurisdiction_id
            FROM jurisdictions
            WHERE jurisdiction_code = 'EU'
        )
    ),
    'Patentability of Digital Inventions',
    'GUIDELINE',
    'https://www.epo.org/en/news-events/in-focus/digital-innovations/patentability-digital-inventions',
    '2026-09-01',
    'EPO guidance concerning patentability of software and digital inventions.'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'EU'),
    (
        SELECT authority_id
        FROM authorities
        WHERE authority_abbreviation = 'EPO'
        AND jurisdiction_id = (
            SELECT jurisdiction_id
            FROM jurisdictions
            WHERE jurisdiction_code = 'EU'
        )
    ),
    'EPC Guidelines - Computer-Implemented Inventions',
    'GUIDELINE',
    'https://www.epo.org/en/legal/guidelines-epc/2026/f_iv_3_9.html',
    '2026-09-01',
    'EPO examination guidance for claims relating to computer-implemented inventions.'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'EU'),
    (
        SELECT authority_id
        FROM authorities
        WHERE authority_abbreviation = 'EPO'
        AND jurisdiction_id = (
            SELECT jurisdiction_id
            FROM jurisdictions
            WHERE jurisdiction_code = 'EU'
        )
    ),
    'EPC Guidelines - Programs for Computers',
    'GUIDELINE',
    'https://www.epo.org/en/legal/guidelines-epc/2026/g_ii_3_6.html',
    '2026-09-01',
    'EPO guidance concerning computer programs and technical character.'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'EU'),
    (
        SELECT authority_id
        FROM authorities
        WHERE authority_abbreviation = 'EUIPO'
        AND jurisdiction_id = (
            SELECT jurisdiction_id
            FROM jurisdictions
            WHERE jurisdiction_code = 'EU'
        )
    ),
    'European Union Intellectual Property Office',
    'OFFICIAL_WEBSITE',
    'https://www.euipo.europa.eu/',
    '2026-09-01',
    'Official EUIPO information concerning EU intellectual property rights.'
);


-- ============================================================
-- INDIA REQUIREMENTS
-- ============================================================

INSERT INTO requirements
(
    jurisdiction_id,
    category_id,
    authority_id,
    requirement_code,
    requirement_name,
    description,
    requirement_type,
    applicability,
    priority
)
VALUES

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'IN'),
    (SELECT category_id FROM ip_categories WHERE category_code = 'COPYRIGHT'),
    (SELECT authority_id FROM authorities
     WHERE authority_abbreviation = 'Copyright Office'
     AND jurisdiction_id = (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'IN')),
    'IN-CR-001',
    'Complete Form XIV',
    'Complete the prescribed Form XIV for copyright registration.',
    'REGISTRATION',
    'MANDATORY',
    'HIGH'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'IN'),
    (SELECT category_id FROM ip_categories WHERE category_code = 'COPYRIGHT'),
    (SELECT authority_id FROM authorities
     WHERE authority_abbreviation = 'Copyright Office'
     AND jurisdiction_id = (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'IN')),
    'IN-CR-002',
    'Prepare Statement of Particulars',
    'Provide the required Statement of Particulars as part of the copyright registration process.',
    'DOCUMENT',
    'MANDATORY',
    'HIGH'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'IN'),
    (SELECT category_id FROM ip_categories WHERE category_code = 'COPYRIGHT'),
    (SELECT authority_id FROM authorities
     WHERE authority_abbreviation = 'Copyright Office'
     AND jurisdiction_id = (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'IN')),
    'IN-CR-003',
    'Prepare Statement of Further Particulars',
    'Provide the Statement of Further Particulars for software and other applicable works.',
    'DOCUMENT',
    'MANDATORY',
    'HIGH'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'IN'),
    (SELECT category_id FROM ip_categories WHERE category_code = 'COPYRIGHT'),
    (SELECT authority_id FROM authorities
     WHERE authority_abbreviation = 'Copyright Office'
     AND jurisdiction_id = (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'IN')),
    'IN-CR-004',
    'Prepare Software Source Code Deposit',
    'Prepare the software work for submission in the format and source-code form specified by the Copyright Office.',
    'DOCUMENT',
    'MANDATORY',
    'HIGH'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'IN'),
    (SELECT category_id FROM ip_categories WHERE category_code = 'COPYRIGHT'),
    (SELECT authority_id FROM authorities
     WHERE authority_abbreviation = 'Copyright Office'
     AND jurisdiction_id = (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'IN')),
    'IN-CR-005',
    'Upload Supporting Documents',
    'Prepare signatures, work and other documents required for online submission.',
    'DOCUMENT',
    'MANDATORY',
    'HIGH'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'IN'),
    (SELECT category_id FROM ip_categories WHERE category_code = 'PATENT'),
    (SELECT authority_id FROM authorities
     WHERE authority_abbreviation = 'CGPDTM'
     AND jurisdiction_id = (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'IN')),
    'IN-PT-001',
    'Check Patent Eligibility',
    'Determine whether the claimed invention satisfies applicable Indian patentability requirements.',
    'ELIGIBILITY',
    'MANDATORY',
    'HIGH'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'IN'),
    (SELECT category_id FROM ip_categories WHERE category_code = 'PATENT'),
    (SELECT authority_id FROM authorities
     WHERE authority_abbreviation = 'CGPDTM'
     AND jurisdiction_id = (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'IN')),
    'IN-PT-002',
    'Check Section 3(k)',
    'Determine whether the software-related invention falls within the exclusions applicable to mathematical methods, business methods, computer programmes per se or algorithms.',
    'ELIGIBILITY',
    'MANDATORY',
    'HIGH'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'IN'),
    (SELECT category_id FROM ip_categories WHERE category_code = 'PATENT'),
    (SELECT authority_id FROM authorities
     WHERE authority_abbreviation = 'CGPDTM'
     AND jurisdiction_id = (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'IN')),
    'IN-PT-003',
    'Assess Technical Contribution',
    'Assess whether the computer-related invention provides the technical contribution required under the applicable examination framework.',
    'ELIGIBILITY',
    'CONDITIONAL',
    'HIGH'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'IN'),
    (SELECT category_id FROM ip_categories WHERE category_code = 'TRADEMARK'),
    (SELECT authority_id FROM authorities
     WHERE authority_abbreviation = 'CGPDTM'
     AND jurisdiction_id = (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'IN')),
    'IN-TM-001',
    'Search Existing Trademarks',
    'Search existing marks before filing to identify potentially conflicting trademarks.',
    'PROCEDURE',
    'MANDATORY',
    'HIGH'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'IN'),
    (SELECT category_id FROM ip_categories WHERE category_code = 'TRADEMARK'),
    (SELECT authority_id FROM authorities
     WHERE authority_abbreviation = 'CGPDTM'
     AND jurisdiction_id = (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'IN')),
    'IN-TM-002',
    'Select Nice Classification',
    'Identify the appropriate goods or services class for the software or related service.',
    'FILING',
    'MANDATORY',
    'HIGH'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'IN'),
    (SELECT category_id FROM ip_categories WHERE category_code = 'TRADEMARK'),
    (SELECT authority_id FROM authorities
     WHERE authority_abbreviation = 'CGPDTM'
     AND jurisdiction_id = (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'IN')),
    'IN-TM-003',
    'Prepare TM-A Application',
    'Prepare the applicable trademark application and applicant information.',
    'FILING',
    'MANDATORY',
    'HIGH'
);


-- ============================================================
-- USA REQUIREMENTS
-- ============================================================

INSERT INTO requirements
(
    jurisdiction_id,
    category_id,
    authority_id,
    requirement_code,
    requirement_name,
    description,
    requirement_type,
    applicability,
    priority
)
VALUES

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'US'),
    (SELECT category_id FROM ip_categories WHERE category_code = 'COPYRIGHT'),
    (SELECT authority_id FROM authorities
     WHERE authority_abbreviation = 'USCO'
     AND jurisdiction_id = (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'US')),
    'US-CR-001',
    'Identify Copyrightable Computer Program',
    'Determine whether the software contains copyrightable expression within the scope of computer program protection.',
    'ELIGIBILITY',
    'MANDATORY',
    'HIGH'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'US'),
    (SELECT category_id FROM ip_categories WHERE category_code = 'COPYRIGHT'),
    (SELECT authority_id FROM authorities
     WHERE authority_abbreviation = 'USCO'
     AND jurisdiction_id = (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'US')),
    'US-CR-002',
    'Prepare Copyright Application',
    'Prepare the copyright registration application for the computer program.',
    'REGISTRATION',
    'CONDITIONAL',
    'HIGH'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'US'),
    (SELECT category_id FROM ip_categories WHERE category_code = 'COPYRIGHT'),
    (SELECT authority_id FROM authorities
     WHERE authority_abbreviation = 'USCO'
     AND jurisdiction_id = (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'US')),
    'US-CR-003',
    'Prepare Required Deposit Material',
    'Prepare the identifying portions or other deposit material required for computer program registration.',
    'DOCUMENT',
    'CONDITIONAL',
    'HIGH'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'US'),
    (SELECT category_id FROM ip_categories WHERE category_code = 'COPYRIGHT'),
    (SELECT authority_id FROM authorities
     WHERE authority_abbreviation = 'USCO'
     AND jurisdiction_id = (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'US')),
    'US-CR-004',
    'Identify Author and Claimant',
    'Record the relevant author and copyright claimant information.',
    'OWNERSHIP',
    'MANDATORY',
    'HIGH'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'US'),
    (SELECT category_id FROM ip_categories WHERE category_code = 'PATENT'),
    (SELECT authority_id FROM authorities
     WHERE authority_abbreviation = 'USPTO'
     AND jurisdiction_id = (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'US')),
    'US-PT-001',
    'Check Patent Eligibility',
    'Determine whether the software-related invention falls within eligible patent subject matter.',
    'ELIGIBILITY',
    'MANDATORY',
    'HIGH'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'US'),
    (SELECT category_id FROM ip_categories WHERE category_code = 'PATENT'),
    (SELECT authority_id FROM authorities
     WHERE authority_abbreviation = 'USPTO'
     AND jurisdiction_id = (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'US')),
    'US-PT-002',
    'Assess Utility',
    'Determine whether the claimed invention has a useful and operative purpose.',
    'ELIGIBILITY',
    'MANDATORY',
    'HIGH'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'US'),
    (SELECT category_id FROM ip_categories WHERE category_code = 'PATENT'),
    (SELECT authority_id FROM authorities
     WHERE authority_abbreviation = 'USPTO'
     AND jurisdiction_id = (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'US')),
    'US-PT-003',
    'Assess Novelty',
    'Assess whether the claimed invention is new in view of applicable prior art.',
    'ELIGIBILITY',
    'MANDATORY',
    'HIGH'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'US'),
    (SELECT category_id FROM ip_categories WHERE category_code = 'PATENT'),
    (SELECT authority_id FROM authorities
     WHERE authority_abbreviation = 'USPTO'
     AND jurisdiction_id = (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'US')),
    'US-PT-004',
    'Assess Non-Obviousness',
    'Assess whether the claimed invention would have been obvious to a person having ordinary skill in the relevant field.',
    'ELIGIBILITY',
    'MANDATORY',
    'HIGH'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'US'),
    (SELECT category_id FROM ip_categories WHERE category_code = 'TRADEMARK'),
    (SELECT authority_id FROM authorities
     WHERE authority_abbreviation = 'USPTO'
     AND jurisdiction_id = (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'US')),
    'US-TM-001',
    'Search Existing Trademarks',
    'Search existing trademark records for potentially conflicting marks.',
    'PROCEDURE',
    'MANDATORY',
    'HIGH'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'US'),
    (SELECT category_id FROM ip_categories WHERE category_code = 'TRADEMARK'),
    (SELECT authority_id FROM authorities
     WHERE authority_abbreviation = 'USPTO'
     AND jurisdiction_id = (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'US')),
    'US-TM-002',
    'Identify Goods or Services',
    'Identify and accurately describe the goods or services associated with the mark.',
    'FILING',
    'MANDATORY',
    'HIGH'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'US'),
    (SELECT category_id FROM ip_categories WHERE category_code = 'TRADEMARK'),
    (SELECT authority_id FROM authorities
     WHERE authority_abbreviation = 'USPTO'
     AND jurisdiction_id = (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'US')),
    'US-TM-003',
    'Prepare Trademark Application',
    'Prepare the applicable trademark application and filing information.',
    'FILING',
    'MANDATORY',
    'HIGH'
);


-- ============================================================
-- EUROPE REQUIREMENTS
-- ============================================================

INSERT INTO requirements
(
    jurisdiction_id,
    category_id,
    authority_id,
    requirement_code,
    requirement_name,
    description,
    requirement_type,
    applicability,
    priority
)
VALUES

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'EU'),
    (SELECT category_id FROM ip_categories WHERE category_code = 'COPYRIGHT'),
    NULL,
    'EU-CR-001',
    'Identify Protected Computer Program',
    'Determine whether the software qualifies for copyright protection as a computer program under the applicable EU framework.',
    'ELIGIBILITY',
    'MANDATORY',
    'HIGH'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'EU'),
    (SELECT category_id FROM ip_categories WHERE category_code = 'COPYRIGHT'),
    NULL,
    'EU-CR-002',
    'Check Originality',
    'Determine whether the computer program is original in the sense required for copyright protection.',
    'ELIGIBILITY',
    'MANDATORY',
    'HIGH'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'EU'),
    (SELECT category_id FROM ip_categories WHERE category_code = 'COPYRIGHT'),
    NULL,
    'EU-CR-003',
    'Identify Author or Rights Holder',
    'Record the author or applicable rights holder information according to the relevant national framework.',
    'OWNERSHIP',
    'MANDATORY',
    'HIGH'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'EU'),
    (SELECT category_id FROM ip_categories WHERE category_code = 'PATENT'),
    (SELECT authority_id FROM authorities
     WHERE authority_abbreviation = 'EPO'
     AND jurisdiction_id = (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'EU')),
    'EU-PT-001',
    'Check Technical Character',
    'Determine whether the computer-implemented invention has technical character.',
    'ELIGIBILITY',
    'MANDATORY',
    'HIGH'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'EU'),
    (SELECT category_id FROM ip_categories WHERE category_code = 'PATENT'),
    (SELECT authority_id FROM authorities
     WHERE authority_abbreviation = 'EPO'
     AND jurisdiction_id = (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'EU')),
    'EU-PT-002',
    'Assess Further Technical Effect',
    'Determine whether the software produces a further technical effect beyond the normal interaction between software and computer hardware.',
    'ELIGIBILITY',
    'MANDATORY',
    'HIGH'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'EU'),
    (SELECT category_id FROM ip_categories WHERE category_code = 'PATENT'),
    (SELECT authority_id FROM authorities
     WHERE authority_abbreviation = 'EPO'
     AND jurisdiction_id = (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'EU')),
    'EU-PT-003',
    'Assess Novelty',
    'Determine whether the claimed invention is new under the applicable European patent framework.',
    'ELIGIBILITY',
    'MANDATORY',
    'HIGH'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'EU'),
    (SELECT category_id FROM ip_categories WHERE category_code = 'PATENT'),
    (SELECT authority_id FROM authorities
     WHERE authority_abbreviation = 'EPO'
     AND jurisdiction_id = (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'EU')),
    'EU-PT-004',
    'Assess Inventive Step',
    'Determine whether the claimed invention involves an inventive step.',
    'ELIGIBILITY',
    'MANDATORY',
    'HIGH'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'EU'),
    (SELECT category_id FROM ip_categories WHERE category_code = 'PATENT'),
    (SELECT authority_id FROM authorities
     WHERE authority_abbreviation = 'EPO'
     AND jurisdiction_id = (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'EU')),
    'EU-PT-005',
    'Assess Industrial Applicability',
    'Determine whether the invention is susceptible of industrial application.',
    'ELIGIBILITY',
    'MANDATORY',
    'HIGH'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'EU'),
    (SELECT category_id FROM ip_categories WHERE category_code = 'TRADEMARK'),
    (SELECT authority_id FROM authorities
     WHERE authority_abbreviation = 'EUIPO'
     AND jurisdiction_id = (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'EU')),
    'EU-TM-001',
    'Search Existing EU Trade Marks',
    'Search existing EU trade marks before filing to identify potential conflicts.',
    'PROCEDURE',
    'MANDATORY',
    'HIGH'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'EU'),
    (SELECT category_id FROM ip_categories WHERE category_code = 'TRADEMARK'),
    (SELECT authority_id FROM authorities
     WHERE authority_abbreviation = 'EUIPO'
     AND jurisdiction_id = (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'EU')),
    'EU-TM-002',
    'Identify Goods and Services',
    'Identify the goods and services for which protection is required using the applicable classification system.',
    'FILING',
    'MANDATORY',
    'HIGH'
),

(
    (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'EU'),
    (SELECT category_id FROM ip_categories WHERE category_code = 'TRADEMARK'),
    (SELECT authority_id FROM authorities
     WHERE authority_abbreviation = 'EUIPO'
     AND jurisdiction_id = (SELECT jurisdiction_id FROM jurisdictions WHERE jurisdiction_code = 'EU')),
    'EU-TM-003',
    'Prepare EU Trade Mark Application',
    'Prepare the required information and application for EU trade mark protection.',
    'FILING',
    'MANDATORY',
    'HIGH'
);


-- ============================================================
-- Requirement to source relationships
-- ============================================================

-- India copyright

INSERT INTO requirement_sources (requirement_id, source_id)
SELECT r.requirement_id, s.source_id
FROM requirements r
JOIN sources s
WHERE r.requirement_code IN
(
    'IN-CR-001',
    'IN-CR-002',
    'IN-CR-003',
    'IN-CR-004',
    'IN-CR-005'
)
AND s.source_title = 'Copyright Registration Online Filing Instructions';


-- India patent

INSERT INTO requirement_sources (requirement_id, source_id)
SELECT r.requirement_id, s.source_id
FROM requirements r
JOIN sources s
WHERE r.requirement_code IN
(
    'IN-PT-001',
    'IN-PT-002',
    'IN-PT-003'
)
AND s.source_title IN
(
    'Patent Resources and Guidelines',
    'Patents Act 1970 - Section 3'
);


-- India trademark

INSERT INTO requirement_sources (requirement_id, source_id)
SELECT r.requirement_id, s.source_id
FROM requirements r
JOIN sources s
WHERE r.requirement_code IN
(
    'IN-TM-001',
    'IN-TM-002',
    'IN-TM-003'
)
AND s.source_title = 'Trademark Filing Process';


-- USA copyright

INSERT INTO requirement_sources (requirement_id, source_id)
SELECT r.requirement_id, s.source_id
FROM requirements r
JOIN sources s
WHERE r.requirement_code IN
(
    'US-CR-001',
    'US-CR-002',
    'US-CR-003',
    'US-CR-004'
)
AND s.source_title IN
(
    'Circular 61 - Copyright Registration of Computer Programs',
    'Computer Programs'
);


-- USA patent

INSERT INTO requirement_sources (requirement_id, source_id)
SELECT r.requirement_id, s.source_id
FROM requirements r
JOIN sources s
WHERE r.requirement_code IN
(
    'US-PT-001',
    'US-PT-002',
    'US-PT-003',
    'US-PT-004'
)
AND s.source_title IN
(
    'Patent Essentials',
    'How to Apply for a Patent'
);


-- USA trademark

INSERT INTO requirement_sources (requirement_id, source_id)
SELECT r.requirement_id, s.source_id
FROM requirements r
JOIN sources s
WHERE r.requirement_code IN
(
    'US-TM-001',
    'US-TM-002',
    'US-TM-003'
)
AND s.source_title = 'Trademark Basics';


-- Europe copyright

INSERT INTO requirement_sources (requirement_id, source_id)
SELECT r.requirement_id, s.source_id
FROM requirements r
JOIN sources s
WHERE r.requirement_code IN
(
    'EU-CR-001',
    'EU-CR-002',
    'EU-CR-003'
)
AND s.source_title = 'Directive 2009/24/EC on the Legal Protection of Computer Programs';


-- Europe patent

INSERT INTO requirement_sources (requirement_id, source_id)
SELECT r.requirement_id, s.source_id
FROM requirements r
JOIN sources s
WHERE r.requirement_code IN
(
    'EU-PT-001',
    'EU-PT-002',
    'EU-PT-003',
    'EU-PT-004',
    'EU-PT-005'
)
AND s.source_title IN
(
    'Patentability of Digital Inventions',
    'EPC Guidelines - Computer-Implemented Inventions',
    'EPC Guidelines - Programs for Computers'
);


-- Europe trademark

INSERT INTO requirement_sources (requirement_id, source_id)
SELECT r.requirement_id, s.source_id
FROM requirements r
JOIN sources s
WHERE r.requirement_code IN
(
    'EU-TM-001',
    'EU-TM-002',
    'EU-TM-003'
)
AND s.source_title = 'European Union Intellectual Property Office';


-- ============================================================
-- Requirement-document relationships
-- ============================================================

INSERT INTO requirement_documents
(
    requirement_id,
    document_type_id,
    is_mandatory,
    description
)
SELECT
    r.requirement_id,
    d.document_type_id,
    TRUE,
    'Software source code or applicable source-code material.'
FROM requirements r
JOIN document_types d
WHERE r.requirement_code = 'IN-CR-004'
AND d.document_code = 'SOURCE_CODE';


INSERT INTO requirement_documents
(
    requirement_id,
    document_type_id,
    is_mandatory,
    description
)
SELECT
    r.requirement_id,
    d.document_type_id,
    TRUE,
    'Software description or related work information.'
FROM requirements r
JOIN document_types d
WHERE r.requirement_code IN
(
    'IN-CR-002',
    'IN-CR-003'
)
AND d.document_code = 'SOFTWARE_DESCRIPTION';


INSERT INTO requirement_documents
(
    requirement_id,
    document_type_id,
    is_mandatory,
    description
)
SELECT
    r.requirement_id,
    d.document_type_id,
    TRUE,
    'Ownership documentation where required.'
FROM requirements r
JOIN document_types d
WHERE r.requirement_code IN
(
    'US-CR-004',
    'EU-CR-003'
)
AND d.document_code = 'OWNERSHIP_PROOF';


-- ============================================================
-- Verification queries
-- ============================================================

SELECT
    r.requirement_code,
    j.jurisdiction_name,
    c.category_name,
    r.requirement_name,
    r.applicability,
    r.priority
FROM requirements r
JOIN jurisdictions j
    ON r.jurisdiction_id = j.jurisdiction_id
JOIN ip_categories c
    ON r.category_id = c.category_id
ORDER BY
    j.jurisdiction_name,
    c.category_name,
    r.requirement_code;


SELECT
    r.requirement_code,
    r.requirement_name,
    s.source_title,
    s.source_url
FROM requirement_sources rs
JOIN requirements r
    ON rs.requirement_id = r.requirement_id
JOIN sources s
    ON rs.source_id = s.source_id
ORDER BY
    r.requirement_code;
```

