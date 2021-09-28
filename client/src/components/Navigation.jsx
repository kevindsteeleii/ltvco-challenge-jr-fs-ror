import React from 'react';
import { Link } from "@reach/router";

export default function Navigation() {
  return (
    <nav>
      <Link to="/">Home</Link>
      <span>&nbsp;&nbsp;&nbsp;</span>
      <Link to="/short_urls">Add Short Url</Link> 
    </nav>
  )
}
