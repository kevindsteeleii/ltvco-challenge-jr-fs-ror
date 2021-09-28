import React, { Component } from 'react'

export default class ErrorBoundary extends Component {
  constructor(props) {
    super(props);

    this.state = { hasError: false, errorInfo: null };
  }

  static getDerivedStateFromError(error) {
    return { hasError: true };
  }

  componentDidCatch(error, errorInfo) {
    console.error(error, errorInfo);
    this.setState({errorInfo});
  }

  render() {
    const {hasError,errorInfo} = this.state;
    if (hasError) {
      return <h1>Some error occurred... {JSON.stringify(errorInfo)}</h1>
    }

    return this.props.children;
  }
}
