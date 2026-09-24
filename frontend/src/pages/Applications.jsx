import { useEffect, useState } from "react";

function Applications() {
  const [applications, setApplications] = useState([]);
  const [regions, setRegions] = useState([]);
  const [ipTypes, setIpTypes] = useState([]);

  const [selectedRegions, setSelectedRegions] = useState([]);
  const [selectedIpTypes, setSelectedIpTypes] = useState([]);

  const [showForm, setShowForm] = useState(false);

  const [applicationName, setApplicationName] = useState("");
  const [description, setDescription] = useState("");

  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);

  const [error, setError] = useState("");
  const [success, setSuccess] = useState("");

  useEffect(() => {
    fetchApplications();
    fetchRegions();
    fetchIpTypes();
  }, []);

  const fetchApplications = async () => {
    try {
      const response = await fetch(
        "http://127.0.0.1:8000/applications/"
      );

      if (!response.ok) {
        throw new Error("Failed to fetch applications");
      }

      const data = await response.json();

      setApplications(data);
    } catch (error) {
      console.error("Applications error:", error);
      setError("Unable to load applications.");
    } finally {
      setLoading(false);
    }
  };

  const fetchRegions = async () => {
    try {
      const response = await fetch(
        "http://127.0.0.1:8000/regions/"
      );

      if (!response.ok) {
        throw new Error("Failed to fetch regions");
      }

      const data = await response.json();

      setRegions(data);

      console.log("Regions:", data);
    } catch (error) {
      console.error("Regions error:", error);
      setError("Unable to load regions.");
    }
  };

  const fetchIpTypes = async () => {
    try {
      const response = await fetch(
        "http://127.0.0.1:8000/ip-types/"
      );

      if (!response.ok) {
        throw new Error("Failed to fetch IP types");
      }

      const data = await response.json();

      setIpTypes(data);

      console.log("IP Types:", data);
    } catch (error) {
      console.error("IP Types error:", error);
      setError("Unable to load IP protection types.");
    }
  };

  const handleRegionChange = (regionId) => {
    setSelectedRegions((currentRegions) => {
      if (currentRegions.includes(regionId)) {
        return currentRegions.filter(
          (id) => id !== regionId
        );
      }

      return [...currentRegions, regionId];
    });
  };

  const handleIpTypeChange = (ipTypeId) => {
    setSelectedIpTypes((currentIpTypes) => {
      if (currentIpTypes.includes(ipTypeId)) {
        return currentIpTypes.filter(
          (id) => id !== ipTypeId
        );
      }

      return [...currentIpTypes, ipTypeId];
    });
  };

  const handleCreateApplication = async (event) => {
    event.preventDefault();

    setError("");
    setSuccess("");

    if (!applicationName.trim()) {
      setError("Application name is required.");
      return;
    }

    if (selectedRegions.length === 0) {
      setError("Please select at least one region.");
      return;
    }

    if (selectedIpTypes.length === 0) {
      setError(
        "Please select at least one IP protection type."
      );
      return;
    }

    setSaving(true);

    try {
      const applicationResponse = await fetch(
        "http://127.0.0.1:8000/applications/",
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            user_id: 1,
            application_name: applicationName.trim(),
            description: description.trim(),
          }),
        }
      );

      if (!applicationResponse.ok) {
        const errorData =
          await applicationResponse.json();

        throw new Error(
          errorData.detail ||
            "Failed to create application."
        );
      }

      const applicationData =
        await applicationResponse.json();

      const applicationId =
        applicationData.application_id;

      /*
       * Save selected regions
       */

      for (const regionId of selectedRegions) {
        const regionResponse = await fetch(
          "http://127.0.0.1:8000/application-regions/",
          {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
            },
            body: JSON.stringify({
              application_id: applicationId,
              region_id: regionId,
            }),
          }
        );

        if (!regionResponse.ok) {
          const errorData =
            await regionResponse.json();

          throw new Error(
            errorData.detail ||
              "Failed to save application region."
          );
        }
      }

      /*
       * Save selected IP protection types
       */

      for (const ipTypeId of selectedIpTypes) {
        const ipTypeResponse = await fetch(
          "http://127.0.0.1:8000/application-ip-types/",
          {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
            },
            body: JSON.stringify({
              application_id: applicationId,
              ip_type_id: ipTypeId,
            }),
          }
        );

        if (!ipTypeResponse.ok) {
          const errorData =
            await ipTypeResponse.json();

          throw new Error(
            errorData.detail ||
              "Failed to save application IP protection type."
          );
        }
      }

      setApplicationName("");
      setDescription("");
      setSelectedRegions([]);
      setSelectedIpTypes([]);

      setShowForm(false);

      setSuccess(
        "Application created successfully."
      );

      fetchApplications();

    } catch (error) {
      console.error(
        "Create application error:",
        error
      );

      setError(
        error.message ||
          "Unable to create application."
      );
    } finally {
      setSaving(false);
    }
  };

  return (
    <div className="page">

      {/* PAGE HEADER */}

      <div className="page-header">

        <div>
          <h1>Applications</h1>

          <p>
            Manage software applications registered
            for IP assessment.
          </p>
        </div>

        <button
          className="primary-button"
          onClick={() => {
            setShowForm(true);
            setError("");
            setSuccess("");
          }}
        >
          + New Application
        </button>

      </div>

      {/* SUCCESS MESSAGE */}

      {success && (
        <p className="success-message">
          {success}
        </p>
      )}

      {/* ERROR MESSAGE */}

      {error && (
        <p className="error-message">
          {error}
        </p>
      )}

      {/* NEW APPLICATION FORM */}

      {showForm && (

        <div className="application-form-card">

          <div className="form-header">

            <div>
              <h2>New Application</h2>

              <p>
                Enter the software details and select
                the regions and IP protections to assess.
              </p>
            </div>

          </div>

          <form onSubmit={handleCreateApplication}>

            {/* APPLICATION INFORMATION */}

            <div className="form-section">

              <div className="form-section-title">

                <h3>
                  Application Information
                </h3>

                <p>
                  Basic information about the software.
                </p>

              </div>

              <div className="form-group">

                <label htmlFor="applicationName">
                  Application Name
                </label>

                <input
                  id="applicationName"
                  type="text"
                  value={applicationName}
                  onChange={(event) =>
                    setApplicationName(
                      event.target.value
                    )
                  }
                  placeholder="e.g. AI Healthcare Platform"
                />

              </div>

              <div className="form-group">

                <label htmlFor="description">
                  Description
                </label>

                <textarea
                  id="description"
                  value={description}
                  onChange={(event) =>
                    setDescription(
                      event.target.value
                    )
                  }
                  placeholder="Describe the purpose and functionality of the software"
                  rows="4"
                />

              </div>

            </div>

            {/* PROTECTION REGIONS */}

            <div className="form-section">

              <div className="form-section-title">

                <h3>
                  Protection Regions
                </h3>

                <p>
                  Select the regions where the software
                  requires IP protection assessment.
                </p>

              </div>

              <div className="region-selection">

                {regions.length === 0 ? (

                  <p>
                    No regions available.
                  </p>

                ) : (

                  regions.map((region) => (

                    <label
                      key={region.region_id}
                      className={
                        selectedRegions.includes(
                          region.region_id
                        )
                          ? "region-option selected"
                          : "region-option"
                      }
                    >

                      <input
                        type="checkbox"
                        checked={selectedRegions.includes(
                          region.region_id
                        )}
                        onChange={() =>
                          handleRegionChange(
                            region.region_id
                          )
                        }
                      />

                      <div>

                        <strong>
                          {region.region_name}
                        </strong>

                        <span>
                          {region.country_code}
                        </span>

                      </div>

                    </label>

                  ))

                )}

              </div>

            </div>

            {/* IP PROTECTION TYPES */}

            <div className="form-section">

              <div className="form-section-title">

                <h3>
                  IP Protection Types
                </h3>

                <p>
                  Select the types of intellectual
                  property protection to assess.
                </p>

              </div>

              <div className="ip-type-selection">

                {ipTypes.length === 0 ? (

                  <p>
                    No IP protection types available.
                  </p>

                ) : (

                  ipTypes.map((ipType) => (

                    <label
                      key={ipType.ip_type_id}
                      className={
                        selectedIpTypes.includes(
                          ipType.ip_type_id
                        )
                          ? "ip-type-option selected"
                          : "ip-type-option"
                      }
                    >

                      <input
                        type="checkbox"
                        checked={selectedIpTypes.includes(
                          ipType.ip_type_id
                        )}
                        onChange={() =>
                          handleIpTypeChange(
                            ipType.ip_type_id
                          )
                        }
                      />

                      <div className="ip-type-content">

                        <strong>
                          {ipType.ip_type_name}
                        </strong>

                        <span>
                          {ipType.description}
                        </span>

                      </div>

                    </label>

                  ))

                )}

              </div>

            </div>

            {/* FORM ACTIONS */}

            <div className="form-actions">

              <button
                type="button"
                className="secondary-button"
                onClick={() => {
                  setShowForm(false);
                  setError("");
                  setSelectedRegions([]);
                  setSelectedIpTypes([]);
                }}
              >
                Cancel
              </button>

              <button
                type="submit"
                className="primary-button"
                disabled={saving}
              >
                {saving
                  ? "Creating..."
                  : "Create Application"}
              </button>

            </div>

          </form>

        </div>

      )}

      {/* APPLICATION LIST */}

      {loading && (
        <p>Loading applications...</p>
      )}

      {!loading && !error && (

        <div className="application-table">

          <div className="table-header">

            <span>
              Application
            </span>

            <span>
              Description
            </span>

            <span>
              Status
            </span>

            <span>
              Action
            </span>

          </div>

          {applications.length === 0 ? (

            <div className="empty-state">
              No applications found.
            </div>

          ) : (

            applications.map((application) => (

              <div
                className="table-row"
                key={application.application_id}
              >

                <span>
                  <strong>
                    {application.application_name}
                  </strong>
                </span>

                <span>
                  {application.description || "—"}
                </span>

                <span>
                  <span className="status-badge">
                    {application.status}
                  </span>
                </span>

                <button className="view-button">
                  View
                </button>

              </div>

            ))

          )}

        </div>

      )}

    </div>
  );
}

export default Applications;