# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
    Admin.create(email: "admin@Visitors_Book.com", name: 'Admin', surname: 'Admin', password: '12341234', password_confirmation: '12341234')

    puts("Creating Interests ...")
    interests = Interest.create([{ name: 'Basketbol' }, { name: 'Kamp Yapma' },{ name: 'Balık Tutma' },{ name: 'Doğa Yürüyüşü' },{ name: 'At Binme' },
                                { name: 'Avlanma' },{ name: 'Kayak Yapma' },{ name: 'Motor Sporları' },{ name: 'Dağ Bisikleti Sporu' },{ name: 'Bisiklet Binme' },
                                { name: 'Paintbol' },{ name: 'Fotğrafçılık' },{ name: 'Rafting' },{ name: 'Kaya Tırmanışı' },{ name: 'Koşma' },
                                { name: 'Yelkencilik' },{ name: 'Alış Veriş' },{ name: 'Kano Sporu' },{ name: 'Hava Dalışı' },{ name: 'Futbol' },
                                { name: 'Sörf Yapma' },{ name: 'Yüzme' },{ name: 'Tai Chi' },{ name: 'Tatil Yapma' },{ name: 'Yürüme' },
                                { name: 'Seyehat Etme' },{ name: 'Yemekler' }])

    puts("Creating Tags ...")
    tags = Tag.create([{ name: 'Basketbol' }, { name: 'Kamp Yapma' },{ name: 'Balık Tutma' },{ name: 'Doğa Yürüyüşü' },{ name: 'At Binme' },
                                { name: 'Avlanma' },{ name: 'Kayak Yapma' },{ name: 'Motor Sporları' },{ name: 'Dağ Bisikleti Sporu' },{ name: 'Bisiklet Binme' },
                                { name: 'Paintbol' },{ name: 'Fotğrafçılık' },{ name: 'Rafting' },{ name: 'Kaya Tırmanışı' },{ name: 'Koşma' },
                                { name: 'Yelkencilik' },{ name: 'Alış Veriş' },{ name: 'Kano Sporu' },{ name: 'Hava Dalışı' },{ name: 'Futbol' },
                                { name: 'Sörf Yapma' },{ name: 'Yüzme' },{ name: 'Tai Chi' },{ name: 'Tatil Yapma' },{ name: 'Yürüme' },
                                { name: 'Seyehat Etme' },{ name: 'Yemekler' }])

    puts("Creating Category 1 and its subcategories...")
    c1 = Category.create(name: "Art & Entertainment")

    c1_sub = ["Amphitheater", "Aquarium", "Arcade", "Art Gallery", "Circus", "Concert Hall",
              "Exhibit", "Go Kart Track", "Movie Theater", "Museum", "Pool Hall", "Stadium",
              "Zoo", "Historic Site"]
    for i in 0...c1_sub.size
      s1 = Subcategory.new
      s1.name = c1_sub[i]
      s1.category_id = c1.id
      s1.save
    end

    puts("Creating Category 2 and its subcategories...")
    c2 = Category.create(name: "Food")

    c2_sub = ["Chinese Restaurant", "Japanese Restaurant", "French Restaurant", "German Restaurant",
              "Italian Restaurant", "Mexican Restaurant", "Turkish Restaurant", "Fast-Food Restaurant",
              "Noodle House", "Bakery", "Breakfast Spot", "Buffet", "Cafeteria", "Cafe", "Dessert Shop",
              "Food Truck", "Fried Chicken Joint", "Greek Restaurant", "Juice Bar", "Kebab Restaurant",
              "Pizza Place", "Steakhouse"]
    for i in 0...c2_sub.size
      s2 = Subcategory.new
      s2.name = c2_sub[i]
      s2.category_id = c2.id
      s2.save
    end

    puts("Creating Category 3 and its subcategories...")
    c3 = Category.create(name: "Outdoors")

    c3_sub = ["Gym/Fitness Center", "Paint-ball Field", "Soccer Field", "Tennis Field", "Beach",
              "Fountain", "Garden", "Harbor/Marina", "Lake", "Lighthouse", "National park", "Poll",
              "Rock Climbing Spot", "Ski Area", "States Municipalities", "Volcano", "Waterfall", "Bowling"]
    for i in 0...c3_sub.size
      s3 = Subcategory.new
      s3.name = c3_sub[i]
      s3.category_id = c3.id
      s3.save
    end

    puts("Creating Category 4 and its subcategories...")
    c4 = Category.create(name: "Professional & Other Places")

    c4_sub = ["Auditorium", "Business Center", "Cultural Center", "City Hall", "Library", "Dentist's Office",
              "Hospital", "Mental Health Office", "Rehab Center", "Veterinarian", "Non-Profit", "School",
              "Social Club", "Mosque", "Temple"]
    for i in 0...c4_sub.size
      s4 = Subcategory.new
      s4.name = c4_sub[i]
      s4.category_id = c4.id
      s4.save
    end

    puts("Creating Category 5 and its subcategories...")
    c5 = Category.create(name: "Shop & Service")

    c5_sub = ["ATM", "Antique Shop", "Automotive Shop", "Bank", "Bookstore", "Clothing Store",
              "Comic Shop", "Construction & Landscaping", "Cosmetics Shop", "Dive Shop", "Dry Cleaner",
              "Electronics Store", "Film Studio", "Fishing Store", "Flower Shop", "Supermarket",
              "Gaming Cafe", "Hardware Store", "Home Service", "Market", "Pharmacy", "Rental Service", "Spa"]
    for i in 0...c5_sub.size
      s5 = Subcategory.new
      s5.name = c5_sub[i]
      s5.category_id = c5.id
      s5.save
    end

    puts("Creating Category 6 and its subcategories...")
    c6 = Category.create(name: "Travel & Transport")

    c6_sub = ["Airport", "Bus Station", "Hotel", "Metro Station", "Port", "Tourist Information Center",
              "Train Station"]
    for i in 0...c6_sub.size
      s6 = Subcategory.new
      s6.name = c6_sub[i]
      s6.category_id = c6.id
      s6.save
    end