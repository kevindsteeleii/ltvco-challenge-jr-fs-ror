import React from 'react';
import { Link } from "@reach/router";

export default function Navigation({resetAddPath}) {

  const handleAddPathClick = (ev) => {
    resetAddPath(false);

    setTimeout(() => {
      resetAddPath(true);
    }, 100);
  }

  return (
    <nav>
      <Link to="/">Home</Link>
      <span>&nbsp;&nbsp;&nbsp;</span>
      <Link onClick={handleAddPathClick} to="/short_urls">Add Short Url</Link> 
    </nav>
  )
}
