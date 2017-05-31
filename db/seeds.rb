# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
    Admin.create(email: "admin@Visitors_Book.com", name: 'Admin', surname: 'Admin', password: '12341234', password_confirmation: '12341234')

    interest = Interest.create([{ name: 'Basketbol' }, { name: 'Kamp Yapma' },{ name: 'Balık Tutma' },{ name: 'Doğa Yürüyüşü' },{ name: 'At Binme' },
                                { name: 'Avlanma' },{ name: 'Kayak Yapma' },{ name: 'Motor Sporları' },{ name: 'Dağ Bisikleti Sporu' },{ name: 'Bisiklet Binme' },
                                { name: 'Paintbol' },{ name: 'Fotğrafçılık' },{ name: 'Rafting' },{ name: 'Kaya Tırmanışı' },{ name: 'Koşma' },
                                { name: 'Yelkencilik' },{ name: 'Alış Veriş Yapma' },{ name: 'Kano Sporu' },{ name: 'Hava Dalışı' },{ name: 'Futbol' },
                                { name: 'Sörf Yapma' },{ name: 'Yüzme' },{ name: 'Tai Chi' },{ name: 'Tatil Yapma' },{ name: 'Yürüme' },
                                { name: 'Seyehat Etme' },{ name: 'Yemek Yeme' }])