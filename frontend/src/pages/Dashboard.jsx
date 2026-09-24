import { useEffect, useState } from "react";

function Dashboard() {
  const [requirements, setRequirements] = useState([]);
  const [assessments, setAssessments] = useState([]);
  const [riskData, setRiskData] = useState(null);

  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  useEffect(() => {
    Promise.all([
      fetch("http://127.0.0.1:8000/requirements/"),
      fetch("http://127.0.0.1:8000/assessment/"),
      fetch("http://127.0.0.1:8000/risk-analysis/1"),
    ])
      .then(async (responses) => {
        for (const response of responses) {
          if (!response.ok) {
            throw new Error("Failed to fetch dashboard data");
          }
        }

        const requirementsData = await responses[0].json();
        const assessmentsData = await responses[1].json();
        const riskDataResponse = await responses[2].json();

        return {
          requirementsData,
          assessmentsData,
          riskDataResponse,
        };
      })
      .then((data) => {
        setRequirements(data.requirementsData);
        setAssessments(data.assessmentsData);
        setRiskData(data.riskDataResponse);
        setLoading(false);
      })
      .catch(() => {
        setError("Unable to load dashboard data.");
        setLoading(false);
      });
  }, []);

  const completedRequirements = assessments.filter(
    (assessment) =>
      assessment.is_compliant === true
  ).length;

  return (
    <div className="dashboard">
      <div className="dashboard-header">
        <div>
          <h1>Dashboard</h1>
          <p>
            Overview of your software IP protection status.
          </p>
        </div>
      </div>

      {loading && <p>Loading dashboard...</p>}

      {error && <p>{error}</p>}

      {!loading && !error && (
        <div className="dashboard-cards">
          <div className="dashboard-card">
            <h3>Applications</h3>
            <strong>1</strong>
            <p>Total software applications</p>
          </div>

          <div className="dashboard-card">
            <h3>Requirements</h3>
            <strong>{requirements.length}</strong>
            <p>Active IP requirements</p>
          </div>

          <div className="dashboard-card">
            <h3>Completed</h3>
            <strong>{completedRequirements}</strong>
            <p>Compliant requirements</p>
          </div>

          <div className="dashboard-card">
            <h3>Risks</h3>
            <strong>
              {riskData ? riskData.total_risks : 0}
            </strong>
            <p>Requirements requiring action</p>
          </div>
        </div>
      )}
    </div>
  );
}

export default Dashboard;