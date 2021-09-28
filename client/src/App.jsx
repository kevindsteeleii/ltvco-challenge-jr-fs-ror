import React, { Fragment } from 'react';
import ErrorBoundary from './components/ErrorBoundary.jsx';
import Navigation from './components/Navigation.jsx';

const App = () => {
  return (<Fragment>
    <ErrorBoundary>
        <Navigation/>

    </ErrorBoundary>
  </Fragment>);
};

export default App;