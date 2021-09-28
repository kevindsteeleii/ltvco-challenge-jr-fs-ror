import React, { Fragment } from 'react';
import Home from "./components/Home.jsx";
import AddShortUrl from './components/AddShortUrl.jsx';
import Navigation from './components/Navigation.jsx';
import ErrorBoundary from './components/ErrorBoundary.jsx';
import { Router } from "@reach/router";
import './styles/styles.css';

const App = () => {
  return (<Fragment>
    <ErrorBoundary>
        <Navigation/>

        <Router>
          <AddShortUrl path="/short_urls" />
          <Home path="/" />
        </Router>
    </ErrorBoundary>
  </Fragment>);
};

export default App;