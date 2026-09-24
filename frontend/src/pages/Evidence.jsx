import { useEffect, useState } from "react";

function Evidence() {
  const [evidence, setEvidence] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  const fetchEvidence = () => {
    fetch("http://127.0.0.1:8000/evidence/")
      .then((response) => {
        if (!response.ok) {
          throw new Error("Failed to fetch evidence");
        }

        return response.json();
      })
      .then((data) => {
        setEvidence(data);
        setLoading(false);
      })
      .catch(() => {
        setError("Unable to load evidence.");
        setLoading(false);
      });
  };

  useEffect(() => {
    fetchEvidence();
  }, []);

  return (
    <div className="page">
      <div className="page-header">
        <div>
          <h1>Evidence</h1>
          <p>
            Manage documents uploaded as evidence for IP requirements.
          </p>
        </div>

        <button className="primary-button">
          + Upload Evidence
        </button>
      </div>

      {loading && <p>Loading evidence...</p>}

      {error && <p>{error}</p>}

      {!loading && !error && (
        <div className="evidence-table">
          <div className="evidence-header">
            <span>ID</span>
            <span>File</span>
            <span>Application</span>
            <span>Requirement</span>
            <span>Document Type</span>
            <span>Action</span>
          </div>

          {evidence.length === 0 ? (
            <div className="empty-state">
              No evidence documents found.
            </div>
          ) : (
            evidence.map((item) => (
              <div
                className="evidence-row"
                key={item.evidence_id}
              >
                <span>{item.evidence_id}</span>

                <span>
                  <strong>{item.file_name}</strong>

                  {item.description && (
                    <small>{item.description}</small>
                  )}
                </span>

                <span>
                  Application #{item.application_id}
                </span>

                <span>
                  {item.requirement_id
                    ? `Requirement #${item.requirement_id}`
                    : "—"}
                </span>

                <span>
                  {item.document_type || "—"}
                </span>

                <span>
                  <a
                    className="view-button"
                    href={`http://127.0.0.1:8000/evidence/${item.evidence_id}/download`}
                    target="_blank"
                    rel="noreferrer"
                  >
                    Download
                  </a>
                </span>
              </div>
            ))
          )}
        </div>
      )}
    </div>
  );
}

export default Evidence;