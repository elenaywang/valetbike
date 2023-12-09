//Fetches station data via AJAX (refer to https://www.rubyguides.com/2019/03/rails-ajax/)'

   
    mapboxgl.accessToken = 'pk.eyJ1IjoieWxvbzEyMyIsImEiOiJjbG9sdDJxYjAwdHR2Mmxxb2FsaG9nN2lvIn0.OZGWalV5uPOOaCrC7TwbWg';

    const map = new mapboxgl.Map({
      container: 'map', // container ID
      style: 'mapbox://styles/mapbox/streets-v12', // style URL
      center: [-72.64, 42.325], // starting position [lng, lat]
      zoom: 11.5 // starting zoom
    });


  //initliazes map via mapbox token
    function init_mapmarkers(station) {
        new mapboxgl.Marker({color: 'orange'})
            .setLngLat([station.longitude, station.latitude])
            .setPopup(
                new mapboxgl.Popup({ offset: 25})
                    .setHTML("<h3>" + station.name + "</h3><p> Docked Bike Count: " + station.docked_bikes_count + "</p>")
            )
     .addTo(map);
    
    }

    function loadStations(){
        fetch('/home/map', {
            headers: {
            'Accept': 'application/json',
        },
    })
        .then(response => response.json())
        .then(data => {
            data.forEach(init_mapmarkers);
        })
        .catch(error => console.error('Error fetch station data:', error));
    }

    document.addEventListener('DOMContentLoaded',loadStations);

