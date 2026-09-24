import { useEffect, useState } from "react";

function GapAnalysis() {
  const [gaps, setGaps] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  useEffect(() => {
    fetch("http://127.0.0.1:8000/gap-analysis/1")
      .then((response) => {
        if (!response.ok) {
          throw new Error("Failed to fetch gap analysis");
        }

        return response.json();
      })
      .then((data) => {
        setGaps(data);
        setLoading(false);
      })
      .catch(() => {
        setError("Unable to load gap analysis.");
        setLoading(false);
      });
  }, []);

  const totalGaps = gaps.length;

  const mandatoryGaps = gaps.filter(
    (gap) => gap.mandatory
  ).length;

  const pendingGaps = gaps.filter(
    (gap) => gap.status === "pending"
  ).length;

  return (
    <div className="page">
      <div className="page-header">
        <div>
          <h1>Gap Analysis</h1>
          <p>
            Identify IP requirements that are not currently compliant.
          </p>
        </div>
      </div>

      {loading && <p>Loading gap analysis...</p>}

      {error && <p>{error}</p>}

      {!loading && !error && (
        <>
          <div className="gap-summary">
            <div className="gap-summary-card">
              <span>Total Gaps</span>
              <strong>{totalGaps}</strong>
              <p>Requirements requiring attention</p>
            </div>

            <div className="gap-summary-card">
              <span>Mandatory Gaps</span>
              <strong>{mandatoryGaps}</strong>
              <p>Mandatory requirements not met</p>
            </div>

            <div className="gap-summary-card">
              <span>Pending</span>
              <strong>{pendingGaps}</strong>
              <p>Requirements still pending</p>
            </div>
          </div>

          <div className="gap-section">
            <h2>Compliance Gaps</h2>

            {gaps.length === 0 ? (
              <div className="empty-state">
                No compliance gaps found.
              </div>
            ) : (
              <div className="gap-table">
                <div className="gap-header">
                  <span>ID</span>
                  <span>Requirement</span>
                  <span>Status</span>
                  <span>Action Required</span>
                  <span>Mandatory</span>
                  <span>Source</span>
                </div>

                {gaps.map((gap) => (
                  <div
                    className="gap-row"
                    key={gap.requirement_id}
                  >
                    <span>{gap.requirement_id}</span>

                    <span>
                      <strong>
                        {gap.requirement_title}
                      </strong>

                      {gap.notes && (
                        <small>{gap.notes}</small>
                      )}
                    </span>

                    <span>
                      <span className="status-pending">
                        {gap.status === "pending"
                          ? "Pending"
                          : gap.status}
                      </span>
                    </span>

                    <span>
                      {gap.action_required}
                    </span>

                    <span>
                      {gap.mandatory ? "Yes" : "No"}
                    </span>

                    <span>
                      {gap.source_url ? (
                        <a
                          href={gap.source_url}
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
        </>
      )}
    </div>
  );
}

export default GapAnalysis;