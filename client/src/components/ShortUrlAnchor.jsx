import React from 'react'

const ShortUrlAnchor = ({baseUrl, shortUrl, text}) => {
  const fullUrl = baseUrl + shortUrl;
  text = text || fullUrl;

  return (<a target="_blank" href={fullUrl}>{text}</a>);
}

ShortUrlAnchor.defaultProps = {
  text: ""
}

export default ShortUrlAnchor;
