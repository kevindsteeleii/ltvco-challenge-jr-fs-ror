import React, {useState, useEffect} from 'react';
import axios from 'axios';
import ShortUrlAnchor from "./ShortUrlAnchor";

const BASE_URL = 'http://localhost:3000/';

export default function Home() {
  const [shortUrls, setShortUrls] = useState([]);

  useEffect(() => {
    axios.get(BASE_URL)
      .then(response => response.data)
      .then(data => {
        setShortUrls(data.urls);
      })
      .catch(err => console.error(err))
  }, [])

  return (
    <div>
      <br/>
      { shortUrls.length > 0 && 
        shortUrls.map((shortUrl, idx) => <li style={{listStyle: "none"}} key={idx}><ShortUrlAnchor baseUrl={BASE_URL} shortUrl={shortUrl}/></li>) 
      }
    </div>
  )
}