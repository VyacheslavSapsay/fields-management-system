$(document).ready(function () {
  if ($(".fields-index").length > 0) {
    const map = L.map("map").setView([50.4501, 30.5234], 13);

    L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
      attribution: "&copy; OpenStreetMap contributors",
    }).addTo(map);

    document.querySelectorAll("tr").forEach((row) => {
      const geojsonCell = row.querySelector(".item-geojson");
      const linkCell = row.querySelector(".item-link");

      if (geojsonCell && linkCell) {
        const geojson = JSON.parse(geojsonCell.textContent);
        const linkHTML = linkCell.innerHTML;
        const layer = L.geoJSON(geojson).addTo(map);

        layer.bindPopup(linkHTML);
      }
    });
  }

  if ($(".edit-field").length > 0) {
    var map = L.map("map").setView([51.505, -0.09], 13);
    L.tileLayer("http://{s}.tile.osm.org/{z}/{x}/{y}.png", {
      attribution:
        '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors',
    }).addTo(map);

    var allLayers = [];

    var shapeField = document.getElementById("shape-field").value;
    var savedPolygonData = shapeField ? JSON.parse(shapeField) : null;

    if (savedPolygonData) {
      var geoJsonLayer = L.geoJSON(savedPolygonData);

      geoJsonLayer.eachLayer(function (layer) {
        allLayers.push(layer);
        layer.addTo(map);

        layer.pm.enable({ allowSelfIntersection: false });

        layer.on("pm:edit", function (e) {
          updateShapeField();
        });
      });

      var bounds = geoJsonLayer.getBounds();
      map.fitBounds(bounds);
    }

    function updateShapeField() {
      var geoJsonFeatures = allLayers.map(function (layer) {
        return layer.toGeoJSON();
      });

      var updatedGeoJSON = {
        type: "FeatureCollection",
        features: geoJsonFeatures,
      };

      var updatedJsonString = JSON.stringify(updatedGeoJSON);
      document.getElementById("shape-field").value = updatedJsonString;
    }

    map.on("pm:create", function (e) {
      var layer = e.layer;
      allLayers.push(layer);
      layer.addTo(map);
      updateShapeField();

      layer.pm.enable({ allowSelfIntersection: false });

      layer.on("pm:edit", function (e) {
        updateShapeField();
      });
    });

    map.on("pm:edit", function (e) {
      updateShapeField();
    });

    map.on("pm:remove", function (e) {
      allLayers = allLayers.filter(function (layer) {
        return layer._leaflet_id !== e.layer._leaflet_id;
      });
      updateShapeField();
    });

    map.on("pm:dragend", function (e) {
      updateShapeField();
    });

    map.on("pm:cut", function (e) {
      updateShapeField();
    });

    map.pm.addControls({
      position: "topleft",
      drawMarker: false,
      drawPolyline: false,
      drawRectangle: false,
      drawCircle: false,
      drawCircleMarker: false,
      drawText: false,
      drawPolygon: true,
      cutPolygon: false,
      rotateMode: false,
      editMode: true,
      removalMode: true,
      dragMode: true,
    });
  }
});
