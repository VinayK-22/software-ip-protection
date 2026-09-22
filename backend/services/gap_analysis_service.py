from models.assessment import Assessment
from models.requirement import Requirement


def get_gap_analysis(db, application_id):
    """
    Get gap analysis for an application.
    """

    results = (
        db.query(
            Assessment,
            Requirement
        )
        .join(
            Requirement,
            Assessment.requirement_id == Requirement.requirement_id
        )
        .filter(
            Assessment.application_id == application_id
        )
        .all()
    )

    gaps = []

    for assessment, requirement in results:

        if not assessment.is_compliant:

            gaps.append({
                "requirement_id": requirement.requirement_id,
                "requirement_title": requirement.requirement_title,
                "status": assessment.status,
                "action_required": requirement.action_required,
                "mandatory": requirement.mandatory,
                "source_name": requirement.source_name,
                "source_url": requirement.source_url,
                "notes": assessment.notes
            })

    return gaps