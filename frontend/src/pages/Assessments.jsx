import { useEffect, useState } from "react";

function Assessments() {
  const [assessments, setAssessments] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  useEffect(() => {
    fetch("http://127.0.0.1:8000/assessment/")
      .then((response) => {
        if (!response.ok) {
          throw new Error("Failed to fetch assessments");
        }

        return response.json();
      })
      .then((data) => {
        setAssessments(data);
        setLoading(false);
      })
      .catch(() => {
        setError("Unable to load assessments.");
        setLoading(false);
      });
  }, []);

  return (
    <div className="page">
      <div className="page-header">
        <div>
          <h1>Assessments</h1>
          <p>
            Review the compliance status of software IP requirements.
          </p>
        </div>
      </div>

      {loading && <p>Loading assessments...</p>}

      {error && <p>{error}</p>}

      {!loading && !error && (
        <div className="assessment-table">
          <div className="assessment-header">
            <span>ID</span>
            <span>Application</span>
            <span>Requirement</span>
            <span>Status</span>
            <span>Compliance</span>
          </div>

          {assessments.length === 0 ? (
            <div className="empty-state">
              No assessments found.
            </div>
          ) : (
            assessments.map((assessment) => (
              <div
                className="assessment-row"
                key={assessment.id}
              >
                <span>{assessment.id}</span>

                <span>
                  Application #{assessment.application_id}
                </span>

                <span>
                  Requirement #{assessment.requirement_id}
                </span>

                <span>
                  <span
                    className={
                      assessment.status === "complete"
                        ? "status-complete"
                        : "status-pending"
                    }
                  >
                    {assessment.status === "complete"
                      ? "Complete"
                      : "Pending"}
                  </span>
                </span>

                <span>
                  {assessment.is_compliant
                    ? "Compliant"
                    : "Not Compliant"}
                </span>
              </div>
            ))
          )}
        </div>
      )}
    </div>
  );
}

export default Assessments;