import { useEffect, useState } from "react";

function RiskAnalysis() {
  const [riskData, setRiskData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  useEffect(() => {
    fetch("http://127.0.0.1:8000/risk-analysis/1")
      .then((response) => {
        if (!response.ok) {
          throw new Error("Failed to fetch risk analysis");
        }

        return response.json();
      })
      .then((data) => {
        setRiskData(data);
        setLoading(false);
      })
      .catch(() => {
        setError("Unable to load risk analysis.");
        setLoading(false);
      });
  }, []);

  return (
    <div className="page">
      <div className="page-header">
        <div>
          <h1>Risk Analysis</h1>
          <p>
            Review risks identified from software IP compliance gaps.
          </p>
        </div>
      </div>

      {loading && <p>Loading risk analysis...</p>}

      {error && <p>{error}</p>}

      {!loading && !error && riskData && (
        <>
          <div className="risk-summary">
            <div className="risk-card">
              <span>Total Risks</span>
              <strong>{riskData.total_risks}</strong>
              <p>Identified compliance risks</p>
            </div>

            <div className="risk-card">
              <span>High Risk</span>
              <strong>{riskData.high_risk}</strong>
              <p>Mandatory requirements</p>
            </div>

            <div className="risk-card">
              <span>Medium Risk</span>
              <strong>{riskData.medium_risk}</strong>
              <p>Non-mandatory requirements</p>
            </div>

            <div className="risk-card">
              <span>Low Risk</span>
              <strong>{riskData.low_risk}</strong>
              <p>Lower priority risks</p>
            </div>
          </div>

          <div className="risk-section">
            <h2>Identified Risks</h2>

            {riskData.risks.length === 0 ? (
              <div className="empty-state">
                No risks found.
              </div>
            ) : (
              <div className="risk-list">
                {riskData.risks.map((risk) => (
                  <div
                    className="risk-item"
                    key={risk.requirement_id}
                  >
                    <div className="risk-item-header">
                      <div>
                        <h3>{risk.requirement_title}</h3>
                        <span>
                          Requirement #{risk.requirement_id}
                        </span>
                      </div>

                      <span
                        className={`risk-badge risk-${risk.risk_level.toLowerCase()}`}
                      >
                        {risk.risk_level} Risk
                      </span>
                    </div>

                    <div className="risk-details">
                      <div>
                        <strong>Status</strong>
                        <p>{risk.status}</p>
                      </div>

                      <div>
                        <strong>Mandatory</strong>
                        <p>
                          {risk.mandatory ? "Yes" : "No"}
                        </p>
                      </div>

                      <div>
                        <strong>Action Required</strong>
                        <p>{risk.action_required}</p>
                      </div>
                    </div>

                    <div className="recommendation">
                      <strong>Recommendation</strong>
                      <p>{risk.recommendation}</p>
                    </div>

                    {risk.source_url && (
                      <a
                        href={risk.source_url}
                        target="_blank"
                        rel="noreferrer"
                      >
                        View Official Source
                      </a>
                    )}
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

export default RiskAnalysis;