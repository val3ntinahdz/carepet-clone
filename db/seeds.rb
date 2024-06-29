require "open-uri"
User.destroy_all
Veterinary.destroy_all

user1 = User.create!(#first_name: 'Maya',
                     #last_name: 'García',
                     email: 'maya@gmail.com',
                     #phone_number: '692389',
                     #address: 'Av. Félix Cuevas 337, Tlacoquemecatl del Valle, Benito Juárez, 03200 Ciudad de México, CDMX',
                     password: "password")

user2 = User.create!(#first_name: 'Valentina',
                     #last_name: 'León',
                     email: 'vale@gmail.com',
                     #phone_number: '7302037',
                     #address: 'Fracc. Residencial del Bosque, Aldama 142, 71233 Santa Cruz Xoxocotlán, Oax.',
                     password: "password")

user3 = User.create!(#first_name: 'Donovan',
                     #last_name: 'Montiel',
                     email: 'donovan@gmail.com',
                     #phone_number: '73034740',
                     #address: 'Fracc. Hacienda del Valle, Hacienda de Xalpa 130, Morelia, Mich.',
                     password: "password")

user4 = User.create!(#first_name: 'Alan',
                     #last_name: 'Trovo',
                     email: 'alan@gmail.com',
                     #phone_number: '094694028',
                     #address: 'Tenayuca 92, Letran Valle, Benito Juárez, 03650 Ciudad de México, CDMX',
                     password: "password")

user5 = User.create!(#first_name: 'Andrés',
                     #last_name: 'López',
                     email: 'andres@gmail.com',
                     #phone_number: '68300387',
                     #address: 'Ortografía 149, Col. Las Palmas, Cd. Nezahualcóyotl, Estado de México',
                     password: "password")

user1_file = URI.open("https://d26jy9fbi4q9wx.cloudfront.net/rails/active_storage/representations/proxy/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBL2ZMQWc9PSIsImV4cCI6bnVsbCwicHVyIjoiYmxvYl9pZCJ9fQ==--eeb1914fc4383dad45f25102670fa7b9682aa1ec/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdCem9MWm05eWJXRjBTU0lJYW5CbkJqb0dSVlE2RTNKbGMybDZaVjkwYjE5bWFXeHNXd2hwQWNocEFjaDdCam9KWTNKdmNEb09ZWFIwWlc1MGFXOXUiLCJleHAiOm51bGwsInB1ciI6InZhcmlhdGlvbiJ9fQ==--b67d9ded4d28d0969fbb98b4c21b79257705a99a/mayagarciabo.jpg")
user1.photo.attach(io: user1_file, filename: "maya_profile_pic.jpg", content_type: "image/jpg")
user1.save!

user2_file = URI.open("https://d26jy9fbi4q9wx.cloudfront.net/rails/active_storage/representations/proxy/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBL2pMQWc9PSIsImV4cCI6bnVsbCwicHVyIjoiYmxvYl9pZCJ9fQ==--53dc4393f2fd2ee72ed1dd780029241695d57aeb/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdCem9MWm05eWJXRjBTU0lJYW5CbkJqb0dSVlE2RTNKbGMybDZaVjkwYjE5bWFXeHNXd2hwQWNocEFjaDdCam9KWTNKdmNEb09ZWFIwWlc1MGFXOXUiLCJleHAiOm51bGwsInB1ciI6InZhcmlhdGlvbiJ9fQ==--b67d9ded4d28d0969fbb98b4c21b79257705a99a/val3ntinahdz.jpg")
user2.photo.attach(io: user2_file, filename: "valentina_profile_pic.jpg", content_type: "image/jpg")
user2.save!

user3_file = URI.open("https://d26jy9fbi4q9wx.cloudfront.net/rails/active_storage/representations/proxy/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBL1hMQWc9PSIsImV4cCI6bnVsbCwicHVyIjoiYmxvYl9pZCJ9fQ==--569088dff2fcc545a21c470d3913b8adcb97f34e/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdCem9MWm05eWJXRjBTU0lJYW5CbkJqb0dSVlE2RTNKbGMybDZaVjkwYjE5bWFXeHNXd2hwQWNocEFjaDdCam9KWTNKdmNEb09ZWFIwWlc1MGFXOXUiLCJleHAiOm51bGwsInB1ciI6InZhcmlhdGlvbiJ9fQ==--b67d9ded4d28d0969fbb98b4c21b79257705a99a/DMont97.jpg")
user3.photo.attach(io: user3_file, filename: "donovan_profile_pic.jpg", content_type: "image/jpg")
user3.save!

user4_file = URI.open("https://avatars.githubusercontent.com/u/135627782?v=4")
user4.photo.attach(io: user4_file, filename: "alan_profile_pic.jpg", content_type: "image/jpg")
user4.save!

user5_file = URI.open("https://avatars.githubusercontent.com/u/30853355?v=4")
user5.photo.attach(io: user5_file, filename: "andres_profile_pic.jpg", content_type: "image/jpg")
user5.save!

vet1 = Veterinary.create!(dni:'12345',
                          specialization:'cardiology',
                          user_id: user4.id)

vet2 = Veterinary.create!(dni:'987654321',
                          specialization:'neurology',
                          user_id: user5.id)
