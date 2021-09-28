import React from 'react';
import { Link } from "@reach/router";

export default function Navigation() {
  return (
    <nav>
      <Link to="/">Home</Link>
      <Link to="/short_urls">Add Short Url</Link> 
    </nav>
  )
}
