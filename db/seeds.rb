

User.create({f_name: "Gretchen", l_name: "Ziegler", email: "gretchenziegler@gmail.com", password: "password"})

Trip.create({user_id: 1, user_rating: nil, completed: false, time_created: Time.now, name: "Gretchen's Neighborhood Crawl", map_url: "https://www.google.com/maps/embed/v1/directions?key=AIzaSyDKBnu8JwKe6sSLCuT6RK5PiCGUQbmbm_Q
    &origin=703+5th+Avenue,+Brooklyn,+NY&destination=686+6th+Avenue,+Brooklyn,+NY&waypoints=708+5th+Avenue,+Brooklyn,+NY|689+6th+Avenue,+Brooklyn,+NY"})

Bar.create({place_id: "ChIJ16lCOeZawokRwBzsO40q1yI", name: "Sea Witch", address: "703 5th Avenue, Brooklyn", website: "http://seawitchnyc.com/", pic_url: 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=CnRpAAAAPLoJyRR31DniGTQqUrDzzJ3kdygilITnbggGTTTiga21d1OqHqBPH_6Dwm3CM7dplEkDJyN2UFNRcwC9yLXXrBQNESbfGSGbXpGUyhm2TtL17GOCuo27Y1qeeK4Kqvc9oEjJoZUM2mDgJfB4rtGkYRIQTiIbeK3NejMxkR_IdJmCSxoUS7yjse71JtyjYa1aCHtFHyLKhm0&key=AIzaSyDKBnu8JwKe6sSLCuT6RK5PiCGUQbmbm_Q', rating: 4.5, price_level: 1})
Bar.create({place_id: "ChIJHcwGL-ZawokRkjTUBtpUnPI", name: "Mary's Bar", address: "708 5th Avenue, Brooklyn", website: "http://www.marysbarbrooklyn.com/", pic_url: 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=CnRnAAAApTtKxul_nTUYkgANynYCTMMVuSX9en-tpU0r71mBaBCNf8kPZuxfjRmSaM_gVIZXZw69gVeSntp6SKCY96Z5kfMJHvKouL16zMDncZ0GFZ8EvbhL2WO3yQEa5Azd6voTwKSb2yfRPyehB9fAgVH0TBIQKtgKh12TtzqUKZxjqDeDaRoUYJ1jkI9QowKJyjJXIzwfeG2Xdkk&key=AIzaSyDKBnu8JwKe6sSLCuT6RK5PiCGUQbmbm_Q', rating: 4.5, price_level: 1})
Bar.create({place_id: "ChIJUSzk6eZawokRsfoiHWtob_M", name: "Brooklyn Pub", address: "689 6th Avenue, Brooklyn", website: "http://www.brooklynpub.com/", pic_url:'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=CnRoAAAA2OQ2X6Push1NvCXSNsLCKskdNZCaQK5LyZULu_dSBkz60Lcctj7gEWGzAgbD-tNYy88ytdh26BoSn-qakBM0cO_VfycLwlty6oFF1rktwJuuRjrO-xun4nNCFA00S0KLoXtk486QBx6Uqsolq5oJGxIQzsUCoQF69ojWFKgwYdthYRoULXT8qjDr6Atyg1VsX58ti8K-TjM&key=AIzaSyDKBnu8JwKe6sSLCuT6RK5PiCGUQbmbm_Q', rating: 3.9, price_level: 2})
Bar.create({place_id: "ChIJU_qR--ZawokRNebQ3wTM5lo", name: "Toby's Public House", address: "686 6th Avenue, Brooklyn", website: "http://tobyspublichouse.com", pic_url: 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=CnRnAAAAVR7uZdEZ08feaXOcMMK0M92IA1dq4We8h8WLyodW7pkcqJq_CZ1LJTgq-SlPy48xdY9pRLs1w8nQk7m8_NfVzHEIHP6FLSIRtwZ3J2tfl5En9IFSBD0fZul3TeI5t0-Co2aQ4IVkSexWQwcLfeTHMxIQSyG746dXVHrbHqeaptsfHBoUkaY0uQEYpfDZHvgIf04iKmxTG5E&key=AIzaSyDKBnu8JwKe6sSLCuT6RK5PiCGUQbmbm_Q', rating: 4.2, price_level: 2})

Stop.create({trip_id: 1, bar_id: 1, stop_number: 1, completed: false})
Stop.create({trip_id: 1, bar_id: 2, stop_number: 2, completed: false})
Stop.create({trip_id: 1, bar_id: 3, stop_number: 3, completed: false})
Stop.create({trip_id: 1, bar_id: 4, stop_number: 4, completed: false})
