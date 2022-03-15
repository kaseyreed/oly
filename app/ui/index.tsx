import React from 'react';

function App() {
  let myLocation: string = window.location.href;
  return <div>Hello Quilt from {myLocation}</div>;
}

export default App;
