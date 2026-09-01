# Software IP Protection — Data Sources

## 1. Purpose

This document records the official and authoritative sources used to collect and validate intellectual property (IP) protection requirements for the Software IP Protection project.

The project initially focuses on software and application IP protection across:

* India
* USA
* Europe

The sources are organized by jurisdiction and IP category.

---

# 2. India

## 2.1 Copyright

**Primary Authority:** Copyright Office, Government of India

**Official Website:**
https://copyright.gov.in/

**Online Copyright Registration:**
https://copyright.gov.in/UserRegistration/frmLoginPage.aspx

**Relevant Information:**

* Copyright registration procedure
* Form XIV
* Statement of Particulars
* Statement of Further Particulars
* Software registration requirements
* Source-code submission requirements
* Supporting documents
* Application processing information

---

## 2.2 Patents

**Primary Authority:** Office of the Controller General of Patents, Designs and Trade Marks (CGPDTM), Government of India

**Official Website:**
https://ipindia.gov.in/

**Patent Resources:**
https://ipindia.gov.in/resource/patents-resources-guidelines

**Relevant Information:**

* Patents Act
* Patent Rules
* Patent application requirements
* Patent examination
* Computer Related Inventions (CRI)
* Patentability requirements
* Section 3(k)
* Technical contribution and technical effect
* Patent examination guidelines

**Important Reference:**
Guidelines for Examination of Computer Related Inventions (CRIs) — 2025

---

## 2.3 Trademarks

**Primary Authority:** Office of the Controller General of Patents, Designs and Trade Marks (CGPDTM)

**Official Website:**
https://ipindia.gov.in/

**Relevant Information:**

* Trademark registration
* Trademark search
* Applicant information
* Classification of goods and services
* Trademark application
* Examination
* Opposition
* Registration

---

## 2.4 Designs

**Primary Authority:** Office of the Controller General of Patents, Designs and Trade Marks (CGPDTM)

**Official Website:**
https://ipindia.gov.in/

**Relevant Information:**

* Design protection
* Design registration
* Design application requirements
* Eligibility and scope of design protection

Design protection will be treated as a conditional category because not every software/application project will have a registrable industrial design component.

---

## 2.5 Ownership and Assignment

**Primary Sources:**

* Copyright Office, Government of India
* IP India
* Applicable Indian IP legislation and rules

**Relevant Information:**

* Author/creator
* Copyright owner
* Assignment
* Employment/contractual ownership
* Licensing
* Ownership documentation

---

# 3. USA

## 3.1 Copyright

**Primary Authority:** U.S. Copyright Office

**Official Website:**
https://www.copyright.gov/

**Copyright Registration:**
https://www.copyright.gov/registration/

**Circular 61 — Copyright Registration of Computer Programs:**
https://www.copyright.gov/circs/circ61.pdf

**Relevant Information:**

* Computer program copyright
* Copyright registration
* Application requirements
* Deposit requirements
* Source-code requirements
* Object-code considerations
* Computer screen displays
* User manuals and documentation
* Trade-secret portions of source code

---

## 3.2 Patents

**Primary Authority:** United States Patent and Trademark Office (USPTO)

**Official Website:**
https://www.uspto.gov/

**Relevant Information:**

* Patent eligibility
* Computer-implemented inventions
* Utility
* Novelty
* Non-obviousness
* Written description
* Enablement
* Definiteness
* Patent application requirements

---

## 3.3 Trademarks

**Primary Authority:** United States Patent and Trademark Office (USPTO)

**Official Website:**
https://www.uspto.gov/trademarks

**Relevant Information:**

* Trademark search
* Trademark application
* Applicant information
* Goods/services classification
* Examination
* Office actions
* Opposition
* Registration

---

## 3.4 Ownership and Assignment

**Primary Sources:**

* U.S. Copyright Office
* USPTO

**Relevant Information:**

* Author
* Copyright claimant
* Ownership transfer
* Assignment
* Licensing
* Employer/company ownership
* Supporting ownership documentation

---

# 4. Europe

## 4.1 Copyright

**Primary Sources:**

* European Commission
* EUR-Lex
* European Union intellectual property framework

**Official EU Legal Database:**
https://eur-lex.europa.eu/

**Relevant Information:**

* Copyright protection
* Software protection
* Computer programs
* Copyright ownership
* Licensing
* EU copyright framework

Software copyright protection in Europe is primarily governed through the EU legal framework and national implementation of relevant EU legislation.

---

## 4.2 Patents

**Primary Authority:** European Patent Office (EPO)

**Official Website:**
https://www.epo.org/

**EPC Guidelines:**
https://www.epo.org/en/legal/guidelines-epc

**Digital Inventions / Software Patentability:**
https://www.epo.org/en/news-events/in-focus/digital-innovations/patentability-digital-inventions

**Relevant Information:**

* European Patent Convention
* Patentability
* Novelty
* Inventive step
* Industrial applicability
* Computer-implemented inventions
* Technical character
* Technical effect
* Patent examination

---

## 4.3 Trademarks

**Primary Authority:** European Union Intellectual Property Office (EUIPO)

**Official Website:**
https://www.euipo.europa.eu/

**Relevant Information:**

* EU trademark
* Trademark search
* Application
* Classification
* Examination
* Opposition
* Registration
* EU trademark ownership

---

## 4.4 Ownership and Licensing

**Primary Sources:**

* EUIPO
* European Commission
* EUR-Lex
* European Patent Office where applicable

**Relevant Information:**

* Ownership
* Assignment
* Licensing
* Transfer of rights
* Author/creator information
* Company ownership
* Contractual arrangements

---

# 5. Source Classification

The Software IP Protection project prioritizes sources in the following order.

### Level 1 — Primary Official Sources

Government departments, statutory authorities and official IP offices.

Examples:

* Copyright Office, Government of India
* IP India
* U.S. Copyright Office
* USPTO
* European Patent Office
* EUIPO
* EUR-Lex

### Level 2 — Official Laws, Rules and Regulations

Applicable legislation, regulations, rules and official legal publications.

### Level 3 — Official Guidelines and Manuals

Official examination guidelines, registration instructions, manuals and procedural documents.

### Level 4 — Secondary Sources

Secondary sources may be used for research or clarification, but primary official sources should be preferred when recording actual IP requirements.

---

# 6. Data Validation

Each requirement added to `database/ip_requirements.sql` should, where possible, contain:

* Jurisdiction
* IP category
* Requirement name
* Requirement description
* Requirement type
* Applicability
* Document requirement
* Authority
* Source title
* Source URL
* Date reviewed
* Notes

### Example

```text
Jurisdiction: India
Category: Copyright
Requirement Code: IN-CR-001
Requirement: Software copyright registration information
Authority: Copyright Office, Government of India
Source: Official Copyright Office
Status: Verified
```

---

# 7. Jurisdiction Structure

The Software IP Protection project uses a common data model rather than separate databases for each jurisdiction.

```text
Software IP Protection
│
├── India
│   ├── Copyright
│   ├── Patent
│   ├── Trademark
│   ├── Design
│   ├── Trade Secret
│   └── Ownership
│
├── USA
│   ├── Copyright
│   ├── Patent
│   ├── Trademark
│   ├── Trade Secret
│   └── Ownership
│
└── Europe
    ├── Copyright
    ├── Patent
    ├── Trademark
    ├── Trade Secret
    └── Ownership
```

All requirements will eventually be stored in the common `database/ip_requirements.sql` dataset and distinguished by jurisdiction and IP category.

---

# 8. Source Maintenance

IP laws, rules, guidelines and procedures may change over time.

Therefore, the Software IP Protection project should periodically review its sources and update the corresponding database records when:

* A law changes
* A rule changes
* An official guideline is replaced
* A registration procedure changes
* An official authority changes its process
* A source URL changes
* A new official guideline is published

The `ip_requirements.sql` dataset should be treated as a maintained knowledge base rather than a permanently static dataset.

---

# 9. Disclaimer

The Software IP Protection project is intended as a software/application IP-protection information and requirement-management system.

The information stored in this project is intended for informational and system-development purposes and should not be treated as legal advice.

Users should consult a qualified IP professional or the relevant official authority for legal decisions and jurisdiction-specific advice.

