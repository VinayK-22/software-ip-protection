import { NavLink } from "react-router-dom";

function Sidebar() {
  return (
    <aside className="sidebar">
      <div className="sidebar-logo">
        <h2>Software IP</h2>
        <span>Protection</span>
      </div>

      <nav className="sidebar-menu">
        <NavLink to="/">Dashboard</NavLink>

        <NavLink to="/applications">
          Applications
        </NavLink>

        <NavLink to="/requirements">
          Requirements
        </NavLink>

        <NavLink to="/assessments">
          Assessments
        </NavLink>

        <NavLink to="/gap-analysis">
          Gap Analysis
        </NavLink>

        <NavLink to="/risk-analysis">
          Risk Analysis
        </NavLink>

        <NavLink to="/evidence">
          Evidence
        </NavLink>
      </nav>
    </aside>
  );
}

export default Sidebar;