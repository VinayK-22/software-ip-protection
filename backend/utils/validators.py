def validate_required_string(value, field_name):
    """
    Validate that a required string is not empty.
    """
    if not value or not value.strip():
        raise ValueError(f"{field_name} is required")

    return value.strip()


def validate_positive_id(value, field_name):
    """
    Validate that an ID is a positive integer.
    """
    if not isinstance(value, int) or value <= 0:
        raise ValueError(f"{field_name} must be a positive integer")

    return value