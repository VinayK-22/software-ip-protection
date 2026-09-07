-- ============================================================
-- PRUTVYP1
-- Software Intellectual Property Protection System
-- IP Requirements Seed Data - SQLite
-- ============================================================

PRAGMA foreign_keys = ON;


-- ============================================================
-- 1. REGIONS
-- ============================================================

INSERT OR IGNORE INTO regions
    (region_name, country_code)
VALUES
    ('India', 'IN'),
    ('USA', 'US'),
    ('Europe', 'EU');


-- ============================================================
-- 2. IP TYPES
-- ============================================================

INSERT OR IGNORE INTO ip_types
    (ip_type_name, description)
VALUES
    (
        'Copyright',
        'Protection for original software code and other copyrightable expression.'
    ),
    (
        'Patent',
        'Protection for eligible inventions that satisfy the applicable patentability requirements.'
    ),
    (
        'Trademark',
        'Protection for names, logos, symbols, or other marks identifying goods or services.'
    ),
    (
        'Trade Secret',
        'Protection based on maintaining qualifying confidential information through appropriate secrecy measures.'
    );


-- ============================================================
-- 3. INDIA - COPYRIGHT
-- ============================================================

INSERT INTO ip_requirements
(
    ip_type_id,
    region_id,
    requirement_title,
    requirement_description,
    action_required,
    mandatory,
    source_name,
    source_url
)
SELECT
    i.ip_type_id,
    r.region_id,
    'Original software expression',
    'The software should contain original copyrightable expression. Indian copyright law treats computer programmes as literary works.',
    'Document authorship and ownership of the original source code and other copyrightable software materials.',
    1,
    'IP India - Basics of Copyright',
    'https://ipindia.gov.in/basics-of-copyright'
FROM ip_types i, regions r
WHERE i.ip_type_name = 'Copyright'
  AND r.region_name = 'India';


INSERT INTO ip_requirements
(
    ip_type_id,
    region_id,
    requirement_title,
    requirement_description,
    action_required,
    mandatory,
    source_name,
    source_url
)
SELECT
    i.ip_type_id,
    r.region_id,
    'Software copyright registration',
    'Copyright exists automatically for qualifying original expression, while registration can provide evidence of the claim.',
    'Decide whether to register the software copyright and prepare the required application information.',
    0,
    'IP India - Filing Process',
    'https://ipindia.gov.in/pages/copyright/learn/filing-process-step-by-step'
FROM ip_types i, regions r
WHERE i.ip_type_name = 'Copyright'
  AND r.region_name = 'India';


INSERT INTO ip_requirements
(
    ip_type_id,
    region_id,
    requirement_title,
    requirement_description,
    action_required,
    mandatory,
    source_name,
    source_url
)
SELECT
    i.ip_type_id,
    r.region_id,
    'Source code documentation',
    'IP India states that a software copyright application requires source-code material according to the applicable filing requirements.',
    'Prepare the required source-code extract or complete source code, depending on the applicable length and filing requirements.',
    1,
    'IP India - Filing Process',
    'https://ipindia.gov.in/pages/copyright/learn/filing-process-step-by-step'
FROM ip_types i, regions r
WHERE i.ip_type_name = 'Copyright'
  AND r.region_name = 'India';


-- ============================================================
-- 4. INDIA - PATENT
-- ============================================================

INSERT INTO ip_requirements
(
    ip_type_id,
    region_id,
    requirement_title,
    requirement_description,
    action_required,
    mandatory,
    source_name,
    source_url
)
SELECT
    i.ip_type_id,
    r.region_id,
    'Novelty',
    'A patentable invention must be new and not already anticipated by prior disclosure or prior art.',
    'Perform a prior-art and patent search before filing and document relevant findings.',
    1,
    'IP India - Basics of Patents',
    'https://ipindia.gov.in/pages/patents/learn/basics-of-patents'
FROM ip_types i, regions r
WHERE i.ip_type_name = 'Patent'
  AND r.region_name = 'India';


INSERT INTO ip_requirements
(
    ip_type_id,
    region_id,
    requirement_title,
    requirement_description,
    action_required,
    mandatory,
    source_name,
    source_url
)
SELECT
    i.ip_type_id,
    r.region_id,
    'Inventive step',
    'The invention must involve an inventive step and must not be obvious to a person skilled in the relevant field.',
    'Document the technical advance or non-obvious contribution of the invention.',
    1,
    'IP India - Basics of Patents',
    'https://ipindia.gov.in/pages/patents/learn/basics-of-patents'
FROM ip_types i, regions r
WHERE i.ip_type_name = 'Patent'
  AND r.region_name = 'India';


INSERT INTO ip_requirements
(
    ip_type_id,
    region_id,
    requirement_title,
    requirement_description,
    action_required,
    mandatory,
    source_name,
    source_url
)
SELECT
    i.ip_type_id,
    r.region_id,
    'Industrial applicability',
    'The invention must be capable of being made or used in an industry.',
    'Describe the practical industrial application of the invention.',
    1,
    'IP India - Basics of Patents',
    'https://ipindia.gov.in/pages/patents/learn/basics-of-patents'
FROM ip_types i, regions r
WHERE i.ip_type_name = 'Patent'
  AND r.region_name = 'India';


INSERT INTO ip_requirements
(
    ip_type_id,
    region_id,
    requirement_title,
    requirement_description,
    action_required,
    mandatory,
    source_name,
    source_url
)
SELECT
    i.ip_type_id,
    r.region_id,
    'Check excluded subject matter',
    'The invention must not fall within subject matter excluded from patentability under the applicable provisions of Indian patent law.',
    'Review the invention against the applicable exclusions before proceeding with a patent filing.',
    1,
    'IP India - Patents Act, Section 3',
    'https://ipindia.gov.in/acts/patent-act-1970/section-3'
FROM ip_types i, regions r
WHERE i.ip_type_name = 'Patent'
  AND r.region_name = 'India';


-- ============================================================
-- 5. INDIA - TRADEMARK
-- ============================================================

INSERT INTO ip_requirements
(
    ip_type_id,
    region_id,
    requirement_title,
    requirement_description,
    action_required,
    mandatory,
    source_name,
    source_url
)
SELECT
    i.ip_type_id,
    r.region_id,
    'Identify the trademark',
    'Identify the name, logo, symbol, or other mark that will distinguish the software-related goods or services.',
    'Define the exact trademark representation that will be used commercially.',
    1,
    'IP India - Basics of Trademarks',
    'https://ipindia.gov.in/basics-of-trademarks'
FROM ip_types i, regions r
WHERE i.ip_type_name = 'Trademark'
  AND r.region_name = 'India';


INSERT INTO ip_requirements
(
    ip_type_id,
    region_id,
    requirement_title,
    requirement_description,
    action_required,
    mandatory,
    source_name,
    source_url
)
SELECT
    i.ip_type_id,
    r.region_id,
    'Search existing trademarks',
    'Existing trademarks should be searched to identify potentially conflicting marks.',
    'Search the Indian trademark database for identical or similar marks before filing.',
    1,
    'IP India - Search Existing Trademarks',
    'https://ipindia.gov.in/trade-marks-before-you-apply-search-existing-trademarks'
FROM ip_types i, regions r
WHERE i.ip_type_name = 'Trademark'
  AND r.region_name = 'India';


INSERT INTO ip_requirements
(
    ip_type_id,
    region_id,
    requirement_title,
    requirement_description,
    action_required,
    mandatory,
    source_name,
    source_url
)
SELECT
    i.ip_type_id,
    r.region_id,
    'Select goods or services classes',
    'Indian trademarks are registered for specified goods or services using the Nice Classification system.',
    'Identify the correct Nice Classification class or classes for the software business.',
    1,
    'IP India - Basics of Trademarks',
    'https://ipindia.gov.in/basics-of-trademarks'
FROM ip_types i, regions r
WHERE i.ip_type_name = 'Trademark'
  AND r.region_name = 'India';


-- ============================================================
-- 6. INDIA - TRADE SECRET
-- ============================================================

INSERT INTO ip_requirements
(
    ip_type_id,
    region_id,
    requirement_title,
    requirement_description,
    action_required,
    mandatory,
    source_name,
    source_url
)
SELECT
    i.ip_type_id,
    r.region_id,
    'Identify confidential information',
    'Identify software-related information whose commercial value depends on it remaining confidential.',
    'Create an internal inventory of confidential source code, algorithms, models, credentials, designs, processes, or business information.',
    1,
    'IP India - IPR Resources',
    'https://ipindia.gov.in/resource-links/acts-rules-ipr-links'
FROM ip_types i, regions r
WHERE i.ip_type_name = 'Trade Secret'
  AND r.region_name = 'India';


INSERT INTO ip_requirements
(
    ip_type_id,
    region_id,
    requirement_title,
    requirement_description,
    action_required,
    mandatory,
    source_name,
    source_url
)
SELECT
    i.ip_type_id,
    r.region_id,
    'Implement confidentiality controls',
    'Trade-secret protection depends on maintaining confidentiality through appropriate measures.',
    'Use access controls, confidentiality agreements, restricted repositories, need-to-know access, and appropriate internal security procedures.',
    1,
    'IP India - IPR Resources',
    'https://ipindia.gov.in/resource-links/acts-rules-ipr-links'
FROM ip_types i, regions r
WHERE i.ip_type_name = 'Trade Secret'
  AND r.region_name = 'India';


-- ============================================================
-- 7. USA - COPYRIGHT
-- ============================================================

INSERT INTO ip_requirements
(
    ip_type_id,
    region_id,
    requirement_title,
    requirement_description,
    action_required,
    mandatory,
    source_name,
    source_url
)
SELECT
    i.ip_type_id,
    r.region_id,
    'Copyrightable software expression',
    'Copyright protection can cover copyrightable expression embodied in a computer program, but not ideas, program logic, algorithms, systems, methods, or concepts as such.',
    'Identify and document the original copyrightable expression contained in the software.',
    1,
    'U.S. Copyright Office - Computer Programs',
    'https://www.copyright.gov/register/tx-programs.html'
FROM ip_types i, regions r
WHERE i.ip_type_name = 'Copyright'
  AND r.region_name = 'USA';


INSERT INTO ip_requirements
(
    ip_type_id,
    region_id,
    requirement_title,
    requirement_description,
    action_required,
    mandatory,
    source_name,
    source_url
)
SELECT
    i.ip_type_id,
    r.region_id,
    'Copyright registration',
    'Registration is available for computer programs through the U.S. Copyright Office.',
    'Determine whether registration is appropriate and prepare the applicable registration submission.',
    0,
    'U.S. Copyright Office - Registration',
    'https://www.copyright.gov/registration/'
FROM ip_types i, regions r
WHERE i.ip_type_name = 'Copyright'
  AND r.region_name = 'USA';


INSERT INTO ip_requirements
(
    ip_type_id,
    region_id,
    requirement_title,
    requirement_description,
    action_required,
    mandatory,
    source_name,
    source_url
)
SELECT
    i.ip_type_id,
    r.region_id,
    'Identify source code material',
    'The U.S. Copyright Office specifies deposit requirements for computer programs, including identifying portions of source code.',
    'Prepare the applicable source-code deposit material according to the current Copyright Office requirements.',
    1,
    'U.S. Copyright Office - Circular 61',
    'https://www.copyright.gov/circs/circ61.pdf'
FROM ip_types i, regions r
WHERE i.ip_type_name = 'Copyright'
  AND r.region_name = 'USA';


-- ============================================================
-- 8. USA - PATENT
-- ============================================================

INSERT INTO ip_requirements
(
    ip_type_id,
    region_id,
    requirement_title,
    requirement_description,
    action_required,
    mandatory,
    source_name,
    source_url
)
SELECT
    i.ip_type_id,
    r.region_id,
    'Identify patentable invention',
    'Determine whether the software-related invention falls within subject matter eligible for patent protection.',
    'Describe the underlying invention and identify the technical features that may support patent protection.',
    1,
    'USPTO - Patent Basics',
    'https://www.uspto.gov/patents/basics'
FROM ip_types i, regions r
WHERE i.ip_type_name = 'Patent'
  AND r.region_name = 'USA';


INSERT INTO ip_requirements
(
    ip_type_id,
    region_id,
    requirement_title,
    requirement_description,
    action_required,
    mandatory,
    source_name,
    source_url
)
SELECT
    i.ip_type_id,
    r.region_id,
    'Prior-art search',
    'Patent applicants should investigate existing patents and technical disclosures before filing.',
    'Perform a prior-art search and document potentially relevant patent and non-patent literature.',
    1,
    'USPTO - Patent Basics',
    'https://www.uspto.gov/patents/basics'
FROM ip_types i, regions r
WHERE i.ip_type_name = 'Patent'
  AND r.region_name = 'USA';


INSERT INTO ip_requirements
(
    ip_type_id,
    region_id,
    requirement_title,
    requirement_description,
    action_required,
    mandatory,
    source_name,
    source_url
)
SELECT
    i.ip_type_id,
    r.region_id,
    'Prepare patent application',
    'A patent application must contain the information and documentation required by the applicable U.S. patent process.',
    'Prepare the specification, claims, drawings where applicable, inventor information, and filing materials.',
    1,
    'USPTO - Patents',
    'https://www.uspto.gov/patents'
FROM ip_types i, regions r
WHERE i.ip_type_name = 'Patent'
  AND r.region_name = 'USA';


-- ============================================================
-- 9. USA - TRADEMARK
-- ============================================================

INSERT INTO ip_requirements
(
    ip_type_id,
    region_id,
    requirement_title,
    requirement_description,
    action_required,
    mandatory,
    source_name,
    source_url
)
SELECT
    i.ip_type_id,
    r.region_id,
    'Identify the trademark',
    'A trademark can identify the source of goods or services, including software-related offerings.',
    'Define the name, logo, symbol, or other mark that will identify the software goods or services.',
    1,
    'USPTO - Trademark Basics',
    'https://www.uspto.gov/trademarks/basics'
FROM ip_types i, regions r
WHERE i.ip_type_name = 'Trademark'
  AND r.region_name = 'USA';


INSERT INTO ip_requirements
(
    ip_type_id,
    region_id,
    requirement_title,
    requirement_description,
    action_required,
    mandatory,
    source_name,
    source_url
)
SELECT
    i.ip_type_id,
    r.region_id,
    'Search for conflicting marks',
    'A search for existing marks helps identify potential conflicts before filing.',
    'Search the USPTO trademark database for identical and similar marks.',
    1,
    'USPTO - Trademarks',
    'https://www.uspto.gov/trademarks'
FROM ip_types i, regions r
WHERE i.ip_type_name = 'Trademark'
  AND r.region_name = 'USA';


INSERT INTO ip_requirements
(
    ip_type_id,
    region_id,
    requirement_title,
    requirement_description,
    action_required,
    mandatory,
    source_name,
    source_url
)
SELECT
    i.ip_type_id,
    r.region_id,
    'Prepare goods and services description',
    'Trademark protection is tied to the goods and services identified in the application.',
    'Define the software-related goods and services accurately before filing.',
    1,
    'USPTO - Trademark Basics',
    'https://www.uspto.gov/trademarks/basics'
FROM ip_types i, regions r
WHERE i.ip_type_name = 'Trademark'
  AND r.region_name = 'USA';


-- ============================================================
-- 10. USA - TRADE SECRET
-- ============================================================

INSERT INTO ip_requirements
(
    ip_type_id,
    region_id,
    requirement_title,
    requirement_description,
    action_required,
    mandatory,
    source_name,
    source_url
)
SELECT
    i.ip_type_id,
    r.region_id,
    'Identify economically valuable secret information',
    'A trade secret must have actual or potential independent economic value because it is not generally known.',
    'Identify confidential software information that provides economic or competitive value because it is not generally known.',
    1,
    'USPTO - Trade Secret Policy',
    'https://www.uspto.gov/ip-policy/trade-secret-policy'
FROM ip_types i, regions r
WHERE i.ip_type_name = 'Trade Secret'
  AND r.region_name = 'USA';


INSERT INTO ip_requirements
(
    ip_type_id,
    region_id,
    requirement_title,
    requirement_description,
    action_required,
    mandatory,
    source_name,
    source_url
)
SELECT
    i.ip_type_id,
    r.region_id,
    'Maintain reasonable secrecy measures',
    'U.S. trade-secret protection requires reasonable efforts to maintain the information as secret.',
    'Implement access restrictions, confidentiality agreements, security controls, monitoring, and need-to-know procedures.',
    1,
    'USPTO - Trade Secret Policy',
    'https://www.uspto.gov/ip-policy/trade-secret-policy'
FROM ip_types i, regions r
WHERE i.ip_type_name = 'Trade Secret'
  AND r.region_name = 'USA';


-- ============================================================
-- 11. EUROPE - COPYRIGHT
-- ============================================================

INSERT INTO ip_requirements
(
    ip_type_id,
    region_id,
    requirement_title,
    requirement_description,
    action_required,
    mandatory,
    source_name,
    source_url
)
SELECT
    i.ip_type_id,
    r.region_id,
    'Original software expression',
    'Copyright protection applies to original expression, including software, across the EU, subject to applicable national laws.',
    'Identify and document the original software expression and establish ownership/authorship records.',
    1,
    'EUIPO - Copyright Knowledge Centre',
    'https://www.euipo.europa.eu/en/copyright-knowledge-centre'
FROM ip_types i, regions r
WHERE i.ip_type_name = 'Copyright'
  AND r.region_name = 'Europe';


INSERT INTO ip_requirements
(
    ip_type_id,
    region_id,
    requirement_title,
    requirement_description,
    action_required,
    mandatory,
    source_name,
    source_url
)
SELECT
    i.ip_type_id,
    r.region_id,
    'Determine applicable national copyright framework',
    'There is no single unified EU copyright title; copyright protection operates under the national laws of EU Member States within the harmonised EU framework.',
    'Identify the EU Member State laws relevant to the software activity, ownership, distribution, or enforcement scenario.',
    1,
    'EUIPO - Copyright Knowledge Centre',
    'https://www.euipo.europa.eu/en/copyright-knowledge-centre'
FROM ip_types i, regions r
WHERE i.ip_type_name = 'Copyright'
  AND r.region_name = 'Europe';


-- ============================================================
-- 12. EUROPE - PATENT
-- ============================================================

INSERT INTO ip_requirements
(
    ip_type_id,
    region_id,
    requirement_title,
    requirement_description,
    action_required,
    mandatory,
    source_name,
    source_url
)
SELECT
    i.ip_type_id,
    r.region_id,
    'Novelty',
    'Under the European Patent Convention, an invention must be new and not previously made available to the public.',
    'Perform a prior-art search and assess whether the invention is new before filing.',
    1,
    'European Patent Office - Is it patentable?',
    'https://www.epo.org/en/new-to-patents/is-it-patentable'
FROM ip_types i, regions r
WHERE i.ip_type_name = 'Patent'
  AND r.region_name = 'Europe';


INSERT INTO ip_requirements
(
    ip_type_id,
    region_id,
    requirement_title,
    requirement_description,
    action_required,
    mandatory,
    source_name,
    source_url
)
SELECT
    i.ip_type_id,
    r.region_id,
    'Inventive step',
    'The invention must involve an inventive step and must not be obvious to a person skilled in the relevant technical field.',
    'Document the technical contribution and why the invention is not obvious based on the relevant prior art.',
    1,
    'European Patent Office - Is it patentable?',
    'https://www.epo.org/en/new-to-patents/is-it-patentable'
FROM ip_types i, regions r
WHERE i.ip_type_name = 'Patent'
  AND r.region_name = 'Europe';


INSERT INTO ip_requirements
(
    ip_type_id,
    region_id,
    requirement_title,
    requirement_description,
    action_required,
    mandatory,
    source_name,
    source_url
)
SELECT
    i.ip_type_id,
    r.region_id,
    'Industrial applicability',
    'An invention must be capable of industrial application under the European Patent Convention.',
    'Describe the practical technical application of the invention.',
    1,
    'European Patent Office - Is it patentable?',
    'https://www.epo.org/en/new-to-patents/is-it-patentable'
FROM ip_types i, regions r
WHERE i.ip_type_name = 'Patent'
  AND r.region_name = 'Europe';


INSERT INTO ip_requirements
(
    ip_type_id,
    region_id,
    requirement_title,
    requirement_description,
    action_required,
    mandatory,
    source_name,
    source_url
)
SELECT
    i.ip_type_id,
    r.region_id,
    'Technical character for software',
    'Computer programs claimed as such are excluded, but computer programs producing a further technical effect can qualify for patent protection.',
    'Identify and document the technical effect or technical contribution produced by the software implementation.',
    1,
    'European Patent Office - Programs for Computers',
    'https://www.epo.org/en/legal/guidelines-epc/2026/g_ii_3_6.html'
FROM ip_types i, regions r
WHERE i.ip_type_name = 'Patent'
  AND r.region_name = 'Europe';


-- ============================================================
-- 13. EUROPE - TRADEMARK
-- ============================================================

INSERT INTO ip_requirements
(
    ip_type_id,
    region_id,
    requirement_title,
    requirement_description,
    action_required,
    mandatory,
    source_name,
    source_url
)
SELECT
    i.ip_type_id,
    r.region_id,
    'Identify the EU trade mark',
    'An EU trade mark can distinguish goods or services from those of other businesses.',
    'Define the name, logo, symbol, or other sign that will identify the software goods or services.',
    1,
    'EUIPO - Trade Marks',
    'https://www.euipo.europa.eu/en/trade-marks'
FROM ip_types i, regions r
WHERE i.ip_type_name = 'Trademark'
  AND r.region_name = 'Europe';


INSERT INTO ip_requirements
(
    ip_type_id,
    region_id,
    requirement_title,
    requirement_description,
    action_required,
    mandatory,
    source_name,
    source_url
)
SELECT
    i.ip_type_id,
    r.region_id,
    'Search for existing trade marks',
    'EUIPO recommends checking whether the proposed mark is available and whether similar marks may conflict.',
    'Search existing EU trade marks before filing.',
    1,
    'EUIPO - Before Applying',
    'https://www.euipo.europa.eu/en/trade-marks/before-applying'
FROM ip_types i, regions r
WHERE i.ip_type_name = 'Trademark'
  AND r.region_name = 'Europe';


INSERT INTO ip_requirements
(
    ip_type_id,
    region_id,
    requirement_title,
    requirement_description,
    action_required,
    mandatory,
    source_name,
    source_url
)
SELECT
    i.ip_type_id,
    r.region_id,
    'Define goods and services',
    'An EU trade mark application must identify the goods and services for which protection is sought.',
    'Prepare the appropriate goods and services specification before submitting the application.',
    1,
    'EUIPO - How to Apply',
    'https://www.euipo.europa.eu/en/trade-marks/how-to-apply'
FROM ip_types i, regions r
WHERE i.ip_type_name = 'Trademark'
  AND r.region_name = 'Europe';


-- ============================================================
-- 14. EUROPE - TRADE SECRET
-- ============================================================

INSERT INTO ip_requirements
(
    ip_type_id,
    region_id,
    requirement_title,
    requirement_description,
    action_required,
    mandatory,
    source_name,
    source_url
)
SELECT
    i.ip_type_id,
    r.region_id,
    'Identify confidential business information',
    'Trade secrets can include confidential technical and commercial information that provides value because it is not generally known or readily accessible.',
    'Identify software-related confidential information that provides commercial or technical value.',
    1,
    'EUIPO - Trade Secrets',
    'https://www.euipo.europa.eu/news/trade-secrets-vital-intellectual-property-assets'
FROM ip_types i, regions r
WHERE i.ip_type_name = 'Trade Secret'
  AND r.region_name = 'Europe';


INSERT INTO ip_requirements
(
    ip_type_id,
    region_id,
    requirement_title,
    requirement_description,
    action_required,
    mandatory,
    source_name,
    source_url
)
SELECT
    i.ip_type_id,
    r.region_id,
    'Apply confidentiality measures',
    'Maintaining confidentiality is central to trade-secret protection.',
    'Implement appropriate confidentiality agreements, access restrictions, security controls, and internal procedures.',
    1,
    'EUIPO - Trade Secrets',
    'https://www.euipo.europa.eu/news/trade-secrets-vital-intellectual-property-assets'
FROM ip_types i, regions r
WHERE i.ip_type_name = 'Trade Secret'
  AND r.region_name = 'Europe';


-- ============================================================
-- END OF IP REQUIREMENTS
-- ============================================================
