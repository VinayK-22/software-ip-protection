from models.application_region import ApplicationRegion


def create_application_region(db, application_region_data):
    application_region = ApplicationRegion(
        application_id=application_region_data.application_id,
        region_id=application_region_data.region_id
    )

    db.add(application_region)
    db.commit()
    db.refresh(application_region)

    return application_region


def get_application_regions(db):
    return db.query(ApplicationRegion).all()


def get_application_regions_by_application(
    db,
    application_id
):
    return db.query(ApplicationRegion).filter(
        ApplicationRegion.application_id == application_id
    ).all()