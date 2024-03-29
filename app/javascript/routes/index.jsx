import React from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Home from "../components/Home";
import Profile from "../components/Profile";
import Layout from "../components/Layout";
import Messages from "../components/Messages";
import Group from "../components/Group";

export default (
  <Router>
    <Routes>
      <Route element={<Layout />}>
        <Route path="/" element={<Home />} />
        <Route path="/profile" element={<Profile />} />
      </Route>
      <Route path="/groups/:id" element={<Group />} />
      <Route path="/groups/:id/messages" element={<Messages />} />
    </Routes>
  </Router>
);
