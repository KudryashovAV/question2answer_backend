import React from "react"
import ReactDom from "react-dom/client"

const Home = () => {
  return(
    <div>
      111 Home 232
    </div>
  )
}

const root = ReactDom.createRoot(document.getElementById("home-component"));
root.render(<Home />)
