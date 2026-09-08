from models.application import Application


def create_application(db, application_data):
    """
    Create a new software application.
    """
    application = Application(
        name=application_data.name,
        description=application_data.description,
        owner_id=application_data.owner_id,
        status=application_data.status
    )

    db.add(application)
    db.commit()
    db.refresh(application)

    return application


def get_application(db, application_id):
    """
    Get an application by its ID.
    """
    return db.query(Application).filter(
        Application.id == application_id
    ).first()


def get_applications(db):
    """
    Get all applications.
    """
    return db.query(Application).all()