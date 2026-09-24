import { useEffect, useState } from "react";

function Requirements() {
  const [requirements, setRequirements] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  useEffect(() => {
    fetch("http://127.0.0.1:8000/requirements/")
      .then((response) => {
        if (!response.ok) {
          throw new Error("Failed to fetch requirements");
        }

        return response.json();
      })
      .then((data) => {
        setRequirements(data);
        setLoading(false);
      })
      .catch(() => {
        setError("Unable to load requirements.");
        setLoading(false);
      });
  }, []);

  return (
    <div className="page">
      <div className="page-header">
        <div>
          <h1>Requirements</h1>
          <p>
            IP protection requirements for different regions and IP types.
          </p>
        </div>
      </div>

      {loading && <p>Loading requirements...</p>}

      {error && <p>{error}</p>}

      {!loading && !error && (
        <div className="requirements-table">
          <div className="requirements-header">
            <span>ID</span>
            <span>Requirement</span>
            <span>Action Required</span>
            <span>Mandatory</span>
            <span>Source</span>
          </div>

          {requirements.map((requirement) => (
            <div
              className="requirements-row"
              key={requirement.requirement_id}
            >
              <span>{requirement.requirement_id}</span>

              <span>
                <strong>{requirement.requirement_title}</strong>
                <small>
                  {requirement.requirement_description}
                </small>
              </span>

              <span>{requirement.action_required}</span>

              <span>
                {requirement.mandatory ? "Yes" : "No"}
              </span>

              <span>
                {requirement.source_url ? (
                  <a
                    href={requirement.source_url}
                    target="_blank"
                    rel="noreferrer"
                  >
                    View Source
                  </a>
                ) : (
                  "—"
                )}
              </span>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}

export default Requirements;