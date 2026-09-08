from models.requirement import Requirement


def create_requirement(db, requirement_data):
    """
    Create a new IP protection requirement.
    """
    requirement = Requirement(
        title=requirement_data.title,
        description=requirement_data.description,
        region_id=requirement_data.region_id,
        ip_type_id=requirement_data.ip_type_id,
        priority=requirement_data.priority
    )

    db.add(requirement)
    db.commit()
    db.refresh(requirement)

    return requirement


def get_requirement(db, requirement_id):
    """
    Get a requirement by its ID.
    """
    return db.query(Requirement).filter(
        Requirement.id == requirement_id
    ).first()


def get_requirements(db):
    """
    Get all IP protection requirements.
    """
    return db.query(Requirement).all()


def get_requirements_by_region(db, region_id):
    """
    Get requirements for a specific region.
    """
    return db.query(Requirement).filter(
        Requirement.region_id == region_id
    ).all()


def get_requirements_by_ip_type(db, ip_type_id):
    """
    Get requirements for a specific IP type.
    """
    return db.query(Requirement).filter(
        Requirement.ip_type_id == ip_type_id
    ).all()