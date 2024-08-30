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
});
