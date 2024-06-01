import { Controller } from "@hotwired/stimulus";
import React from "react";
import { createRoot } from "react-dom/client";
import App from "../components/App";
import Questions from "../components/Questions";
import Comments from "../components/Comments";
import Actions from "../components/Actions";
import Users from "../components/Users";
import Answers from "../components/Answers";

// Connects to data-controller="react"
export default class extends Controller {
  connect() {
    let app = document.getElementById("app");
    if (app?.id === "app") {
      return createRoot(app).render(<App />);
    }

    app = document.getElementById("questions");
    if (app?.id === "questions") {
      return createRoot(app).render(<Questions />);
    }

    app = document.getElementById("answers");
    if (app?.id === "answers") {
      return createRoot(app).render(<Answers />);
    }

    app = document.getElementById("users");
    if (app?.id === "users") {
      return createRoot(app).render(<Users />);
    }

    app = document.getElementById("actions");
    if (app?.id === "actions") {
      return createRoot(app).render(<Actions />);
    }

    app = document.getElementById("comments");
    if (app?.id === "comments") {
      return createRoot(app).render(<Comments />);
    }


  }
}
