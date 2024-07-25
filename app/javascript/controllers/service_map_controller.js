import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

// Connects to data-controller="service-map"
export default class extends Controller {
  static values = {
    apiKey: String,
    veterinaryLocation: Array,
    userLocation: Array
  };

  connect() {
    console.log(this.veterinaryLocationValue, this.userLocationValue)
    mapboxgl.accessToken = this.apiKeyValue;

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v12",
      zoom: 12
    });

    this.#addMarkersToMap();
    this.map.addControl(
      new MapboxGeocoder({ accessToken: mapboxgl.accessToken, mapboxgl: mapboxgl })
    );
  }

  #calculateMapCenter() {
    if (!this.veterinaryLocationValue || !this.userLocationValue) {
      return [0, 0]; // Fallback to [0,0] if no locations are available
    }

    const avgLat = (this.veterinaryLocationValue.lat + this.userLocationValue.lat) / 2;
    const avgLng = (this.veterinaryLocationValue.lng + this.userLocationValue.lng) / 2;

    return [avgLng, avgLat];
  }

  #addMarkersToMap() {
    if (this.veterinaryLocationValue) {
      const veterinaryPopup = new mapboxgl.Popup().setHTML(this.veterinaryLocationValue.infoWindowHtml);

      new mapboxgl.Marker({ color: "red" })
        .setLngLat([this.veterinaryLocationValue.lng, this.veterinaryLocationValue.lat])
        .setPopup(veterinaryPopup)
        .addTo(this.map);
    }

    if (this.userLocationValue) {
      const userPopup = new mapboxgl.Popup().setHTML(this.userLocationValue.infoWindowHtml);

      new mapboxgl.Marker({ color: "blue" })
        .setLngLat([this.userLocationValue.lng, this.userLocationValue.lat])
        .setPopup(userPopup)
        .addTo(this.map);
    }
  }
}
