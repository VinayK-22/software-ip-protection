from models.assessment import Assessment


def create_assessment(db, assessment_data):
    """
    Create a new IP protection assessment.
    """
    assessment = Assessment(
        application_id=assessment_data.application_id,
        requirement_id=assessment_data.requirement_id,
        status=assessment_data.status,
        is_compliant=assessment_data.is_compliant,
        notes=assessment_data.notes
    )

    db.add(assessment)
    db.commit()
    db.refresh(assessment)

    return assessment


def get_assessment(db, assessment_id):
    """
    Get an assessment by its ID.
    """
    return db.query(Assessment).filter(
        Assessment.id == assessment_id
    ).first()


def get_assessments(db):
    """
    Get all assessments.
    """
    return db.query(Assessment).all()


def update_assessment(
    db,
    assessment_id,
    status,
    is_compliant,
    notes
):
    """
    Update an existing IP protection assessment.
    """
    assessment = db.query(Assessment).filter(
        Assessment.id == assessment_id
    ).first()

    if not assessment:
        return None

    assessment.status = status
    assessment.is_compliant = is_compliant
    assessment.notes = notes

    db.commit()
    db.refresh(assessment)

    return assessment