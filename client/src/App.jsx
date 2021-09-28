import React, { Fragment, useState } from 'react';
import Home from "./components/Home.jsx";
import AddShortUrl from './components/AddShortUrl.jsx';
import Navigation from './components/Navigation.jsx';
import ErrorBoundary from './components/ErrorBoundary.jsx';
import { Router } from "@reach/router";

const App = () => {
  const [refreshAddPath, setRefreshAddPath] = useState(true);

  return (<Fragment>
    <ErrorBoundary>
        <Navigation resetAddPath={setRefreshAddPath}/>

        <Router>
          { refreshAddPath && <AddShortUrl path="/short_urls" /> }
          <Home path="/" />
        </Router>
    </ErrorBoundary>
  </Fragment>);
};

export default App;