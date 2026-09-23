from datetime import datetime

from models.evidence import Evidence


def create_evidence(db, evidence_data):
    """
    Create a new evidence record.
    """

    evidence = Evidence(
        application_id=evidence_data.application_id,
        requirement_id=evidence_data.requirement_id,
        file_name=evidence_data.file_name,
        file_path=evidence_data.file_path,
        document_type=evidence_data.document_type,
        description=evidence_data.description,
        uploaded_at=datetime.utcnow().isoformat()
    )

    db.add(evidence)
    db.commit()
    db.refresh(evidence)

    return evidence


def get_evidence(db, evidence_id):
    """
    Get evidence by ID.
    """

    return db.query(Evidence).filter(
        Evidence.evidence_id == evidence_id
    ).first()


def get_all_evidence(db):
    """
    Get all evidence records.
    """

    return db.query(Evidence).all()


def get_application_evidence(db, application_id):
    """
    Get all evidence records for an application.
    """

    return db.query(Evidence).filter(
        Evidence.application_id == application_id
    ).all()


def delete_evidence(db, evidence_id):
    """
    Delete an evidence record.
    """

    evidence = db.query(Evidence).filter(
        Evidence.evidence_id == evidence_id
    ).first()

    if not evidence:
        return None

    db.delete(evidence)
    db.commit()

    return evidence