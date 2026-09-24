import "./App.css";
import { BrowserRouter, Routes, Route } from "react-router-dom";

import Sidebar from "./components/Sidebar";
import Header from "./components/Header";

import Dashboard from "./pages/Dashboard";
import Applications from "./pages/Applications";
import Requirements from "./pages/Requirements";
import Assessments from "./pages/Assessments";
import GapAnalysis from "./pages/GapAnalysis";
import RiskAnalysis from "./pages/RiskAnalysis";
import Evidence from "./pages/Evidence";

function App() {
  return (
    <BrowserRouter>
      <div className="app">
        <Sidebar />

        <div className="content-area">
          <Header />

          <main className="main-content">
            <Routes>
              <Route path="/" element={<Dashboard />} />
              <Route path="/applications" element={<Applications />} />
              <Route path="/requirements" element={<Requirements />} />
              <Route path="/assessments" element={<Assessments />} />
              <Route path="/gap-analysis" element={<GapAnalysis />}/>
              <Route path="/risk-analysis" element={<RiskAnalysis />}/>
              <Route path="/evidence" element={<Evidence />}/>
            </Routes>
          </main>
        </div>
      </div>
    </BrowserRouter>
  );
}

export default App;