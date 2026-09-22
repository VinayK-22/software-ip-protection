from models.assessment import Assessment
from models.requirement import Requirement


def get_risk_analysis(db, application_id):
    """
    Analyze risks for an application based on assessment gaps.
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

    risks = []

    for assessment, requirement in results:

        if assessment.is_compliant:
            continue

        if requirement.mandatory:
            risk_level = "High"
        else:
            risk_level = "Medium"

        risks.append({
            "requirement_id": requirement.requirement_id,
            "requirement_title": requirement.requirement_title,
            "risk_level": risk_level,
            "status": assessment.status,
            "action_required": requirement.action_required,
            "mandatory": requirement.mandatory,
            "recommendation": (
                f"Complete the requirement: "
                f"{requirement.requirement_title}"
            ),
            "source_name": requirement.source_name,
            "source_url": requirement.source_url,
            "notes": assessment.notes
        })

    high_risk = sum(
        1 for risk in risks
        if risk["risk_level"] == "High"
    )

    medium_risk = sum(
        1 for risk in risks
        if risk["risk_level"] == "Medium"
    )

    low_risk = sum(
        1 for risk in risks
        if risk["risk_level"] == "Low"
    )

    return {
        "application_id": application_id,
        "total_risks": len(risks),
        "high_risk": high_risk,
        "medium_risk": medium_risk,
        "low_risk": low_risk,
        "risks": risks
    }