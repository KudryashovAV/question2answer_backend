import React, { useState } from "react";

function App() {
  const [count, setCount] = useState(0);
  return (
    <div >
      <p className="text-3xl font-bold underline">You clickewwd {count} tiwwmes!!!</p>
      <button onClick={() => setCount(count + 1)}>Click me</button>
    </div>
  );
}

export default App;
