Google API project key: AIzaSyDKBnu8JwKe6sSLCuT6RK5PiCGUQbmbm_Q

**geocode API call (to get lat/long of location by address):**

response = HTTParty.get('https://maps.googleapis.com/maps/api/geocode/json?address=350+19th+street,+Brooklyn,+NY&key=AIzaSyDKBnu8JwKe6sSLCuT6RK5PiCGUQbmbm_Q')

latitude = response["results"][0]["geometry"]["location"]["lat"] 

longitude = response["results"][0]["geometry"]["location"]["lng"] 

**places API call (to get list of nearby bars by lat/long):**

bars = HTTParty.get('https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{lat},{long}&radius=#{radius_in_meters}&types=bar&key=AIzaSyDKBnu8JwKe6sSLCuT6RK5PiCGUQbmbm_Q')

results = bars["results"]                      
addresses => results[index]["vicinity"]
names => results[index]["name"] 

place_ids => results[index]["place_id"]

price_level => results[index]["price_level"]

rating => results[index]["rating"]

photo ref => results[index]["photos"][0]["photo_reference"]

results.take(number_of_stops)
  
**places API details call (to get website and additional details):**

response = HTTParty.get('https://maps.googleapis.com/maps/api/place/details/json?placeid=#{place_id}&key=AIzaSyDKBnu8JwKe6sSLCuT6RK5PiCGUQbmbm_Q')

**render beautiful pictures**

<img src='https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=#{photo_reference}&key=AIzaSyDKBnu8JwKe6sSLCuT6RK5PiCGUQbmbm_Q'>

**sweet maps!**

<iframe
  width="600"
  height="450"
  frameborder="0" style="border:0"
  src="https://www.google.com/maps/embed/v1/place?key=AIzaSyDKBnu8JwKe6sSLCuT6RK5PiCGUQbmbm_Q
    &origin=#{origin}&destination=#{destination}">
</iframe>
