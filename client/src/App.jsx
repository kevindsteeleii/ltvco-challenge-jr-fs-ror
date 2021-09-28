import React, { Fragment } from 'react';
import Home from "./components/Home.jsx";
import Navigation from './components/Navigation.jsx';
import ErrorBoundary from './components/ErrorBoundary.jsx';
import { Router } from "@reach/router";

const App = () => {
  return (<Fragment>
    <ErrorBoundary>
        <Navigation/>

        <Router>
          <Home path="/" />
        </Router>
    </ErrorBoundary>
  </Fragment>);
};

export default App;