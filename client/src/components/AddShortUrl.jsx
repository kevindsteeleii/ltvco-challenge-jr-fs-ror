import React, { useState, useEffect } from 'react';
import axios from 'axios';
import 'regenerator-runtime/runtime';
import ShortUrlAnchor from "./ShortUrlAnchor";

const URL_REGEXP = /[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/;
const BASE_URL = 'http://localhost:3000/';

export default function AddShortUrl() {
  const [isValid, setIsValid] = useState(null);
  const [shortUrl, setshortUrl] = useState(null);
  const [newUrl, setNewUrl] = useState("");
  const [loaded, setLoaded] = useState(false);

  const handleChangedUrl = (ev) => {
    setNewUrl(ev.target.value);
  }

  const handleFocus = (ev) => {
    ev.preventDefault();
    setIsValid(null);
  }

  const handleSubmit = (ev) => {
    ev.preventDefault();
    console.log(newUrl);
    
    setIsValid(valid => {

      const validUrl = URL_REGEXP.test(newUrl);
      if(!validUrl) {
        setNewUrl("");
      }

      return validUrl;
    });
  }

  useEffect(() => {
    if(isValid) {
      async function postUrl() {
        let response = await axios.post(BASE_URL + 'short_urls.json', { full_url: newUrl });
        setshortUrl(response.data.short_code)
      }

      postUrl();
      setLoaded(true)
    }
  }, [isValid]);

  return (<div id="short-url--container">
    { !isValid && !loaded &&
      <form onSubmit={handleSubmit} >
        <br/>
        <label htmlFor="text-url">Input Url to shorten here:</label><br/>
        <input type="text" name="text-url" value={newUrl} onFocus={handleFocus} onChange={handleChangedUrl} id="text-url"/>
        <input type="submit" value="Submit"/>
      </form>
    }

    { isValid === false && <p style={{ color: 'red' }}>Invalid URL entered. Please try again.</p> }
    { isValid && loaded && <ShortUrlAnchor baseUrl={BASE_URL} shortUrl={shortUrl}/> }
  </div>);
}
