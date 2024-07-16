require 'open-uri'

# Limpiar las tablas existentes

Appointment.destroy_all
Service.destroy_all
Condition.destroy_all
Disease.destroy_all
Allergy.destroy_all
Allergen.destroy_all
Vaccination.destroy_all
Vaccine.destroy_all
Pet.destroy_all
Veterinary.destroy_all
User.destroy_all

# Crear usuarios
user1 = User.create!(
  first_name: 'Maya',
  last_name: 'García',
  email: 'maya@gmail.com',
  phone_number: '5551234567',
  address: 'Av. Félix Cuevas 337, Tlacoquemecatl del Valle, Benito Juárez, 03200 Ciudad de México, CDMX',
  password: "password"
)
user2 = User.create!(
  first_name: 'Valentina',
  last_name: 'León',
  email: 'valentina@gmail.com',
  phone_number: '5552345678',
  address: 'América 103, Parque San Andrés, Coyoacán, 04040 Ciudad de México, CDMX',
  password: "password"
)
user3 = User.create!(
  first_name: 'Donovan',
  last_name: 'Montiel',
  email: 'donovan@gmail.com',
  phone_number: '5553456789',
  address: 'Berlín 3, Del Carmen, Coyoacán, 04100 Ciudad de México, CDMX',
  password: "password"
)
user4 = User.create!(
  first_name: 'Alan',
  last_name: 'Trovo',
  email: 'alan@gmail.com',
  phone_number: '5554567890',
  address: 'Tenayuca 92, Letran Valle, Benito Juárez, 03650 Ciudad de México, CDMX',
  password: "password"
)
user5 = User.create!(
  first_name: 'Andrés',
  last_name: 'López',
  email: 'andres@gmail.com',
  phone_number: '5555678901',
  address: 'Heroes del 47 92, San Diego Churubusco, Coyoacán, 04120 Ciudad de México, CDMX',
  password: "password"
)

# Adjuntar fotos de perfil
# [user1, user2, user3, user4, user5].each_with_index do |user, index|
# file_url = [
#   "https://example.com/user1_profile_pic.jpg",
#   "https://example.com/user2_profile_pic.jpg",
#   "https://example.com/user3_profile_pic.jpg",
#   "https://example.com/user4_profile_pic.jpg",
#   "https://example.com/user5_profile_pic.jpg"
# ][index]

# file = URI.open(file_url)
# user.photo.attach(io: file, filename: "#{user.first_name.downcase}_profile_pic.jpg", content_type: "image/jpg")
# user.save!
# end

# Crear veterinarios
vet1 = Veterinary.create!(
  dni: '123456789',
  specialization: 'Cardiology',
  user_id: user4.id
)
vet2 = Veterinary.create!(
  dni: '987654321',
  specialization: 'General',
  user_id: user5.id
)

vet3 = Veterinary.create!(
  dni: '135792468',
  specialization: 'General',
  user_id: user3.id
)

# Crear mascotas
pets = [
  {
    name: 'Buddy',
    pet_type: 'Dog',
    breed: 'Labrador',
    birthday_date: '2018-03-25',
    gender: 'Male',
    weight: 30,
    height: 60,
    color: 'Black',
    user_id: user1.id
  },
  {
    name: 'Kitty',
    pet_type: 'Cat',
    breed: 'Siamese',
    birthday_date: '2019-05-14',
    gender: 'Female',
    weight: 10,
    height: 25,
    color: 'White',
    user_id: user1.id
  },
  {
    name: 'Max',
    pet_type: 'Dog',
    breed: 'Beagle',
    birthday_date: '2017-07-22',
    gender: 'Male',
    weight: 20,
    height: 40,
    color: 'Brown',
    user_id: user2.id
  }
]

pet_images_urls = [
  "https://res.cloudinary.com/drlgwfwr5/image/upload/v1720304632/development/wk1ikpnsswu2uq1mw5c2.png",
  "https://res.cloudinary.com/drlgwfwr5/image/upload/v1720304632/development/nnlbnoh8suxtcowadzd4.png",
  "https://res.cloudinary.com/drlgwfwr5/image/upload/v1720304632/development/tufpb2nbqsouqn5ds7xq.png",
]

pets.each_with_index do |pet, i|
  Pet.skip_callback(:create, :before, :set_photo)
  new_pet = Pet.new(pet)
  file =  URI.open(pet_images_urls[i])
  new_pet.photo.attach(io: file, filename: "#{pet[:name]}_pet.jpg", content_type: "image/png")
  new_pet.save!
  Pet.set_callback(:create, :before, :set_photo)
end

# Crear vacunas, alérgenos y enfermedades
vaccines = [
  "Rabies",
  "Distemper",
  "Parvovirus",
  "Adenovirus",
  "Leptospirosis",
  "Bordetella",
  "Lyme Disease",
  "Canine Influenza",
  "Corona Virus"
]
allergens = [
  "Pollen",
  "Dust Mites",
  "Fleas",
  "Food Allergies",
  "Mold Spores",
  "Insect Bites",
  "Chemical Irritants",
  "Plant Allergens",
  "Animal Dander"
]
diseases = [
  "Arthritis",
  "Diabetes",
  "Heart Disease",
  "Kidney Disease",
  "Liver Disease",
  "Hypothyroidism",
  "Hyperthyroidism",
  "Cancer",
  "Obesity"
]

vaccines.each { |name| Vaccine.create!(name: name) }
allergens.each { |name| Allergen.create!(name: name) }
diseases.each { |name| Disease.create!(name: name) }

# Descripciones reales para los servicios
service_descriptions = {
  "Surgery" => "Comprehensive surgical care including pre-operative assessments, anesthesia, and post-operative care to ensure the best outcomes for your pet.",
  "Consultation" => "Professional veterinary consultations to address any health concerns, perform physical exams, and provide expert advice on your pet's well-being.",
  "Dentistry" => "Advanced dental care services including cleanings, extractions, and oral health assessments to maintain your pet's dental hygiene.",
  "Vaccination" => "Essential vaccination services to protect your pet from common and potentially life-threatening diseases.",
  "Emergency" => "Immediate and critical care for pets in emergency situations, providing life-saving treatments and interventions.",
  "Wellness" => "Comprehensive wellness exams to monitor your pet's health, prevent diseases, and ensure a long and healthy life.",
  "Nutrition" => "Personalized nutrition plans and dietary consultations to meet the specific needs of your pet.",
  "Behavioral" => "Behavioral consultations and training to address any behavioral issues and improve your pet's quality of life.",
  "Dermatology" => "Specialized dermatology services to diagnose and treat skin conditions, allergies, and other dermatological issues."
}

service_descriptions_array = service_descriptions.to_a

# Generar servicios para cada veterinario con descripciones y categorías aleatorias
services = []

# Categorías posibles para servicios
service_categories = ["Medical"]

[vet1, vet2, vet3].each do |vet|
  3.times do
    serv = service_descriptions_array.shift
    new_service = Service.create!(
      name: serv[0],
      description: serv[1],
      category: "Medical",
      fee: rand(50.0..300.0).round(2),
      veterinary_id: vet.id
    )
    services << new_service
  end
end

# service_descriptions.each do |name, description|
#   category = service_categories.sample
#   fee = rand(50.0..300.0).round(2)

#   service1 = Service.create!(
#     name: name,
#     description: description,
#     category: category,
#     fee: fee,
#     veterinary_id: vet1.id
#   )

#   services << service1
# end

Service.create!(
    name: "Haircuts for dogs",
    description: "Very nice haircuts for your dogs and accesible price",
    category: "Grooming",
    fee: 100,
    veterinary_id: vet2.id
)

# Crear citas con datos reales para cada servicio
appointment_data = [
  { datetime: "2024-07-01 10:00:00", reason: "Routine Checkup", status: "Scheduled" },
  { datetime: "2024-07-02 11:00:00", reason: "Vaccination", status: "Completed" },
  { datetime: "2024-07-03 12:00:00", reason: "Dental Cleaning", status: "Scheduled" }
  { datetime: "2024-07-04 13:00:00", reason: "Skin Allergy", status: "Completed" },
  { datetime: "2024-07-05 14:00:00", reason: "Heartworm Test", status: "Cancelled" },
  { datetime: "2024-07-06 15:00:00", reason: "Behavioral Consultation", status: "Scheduled" }
]

Pet.all.each do |pet|
  services.each do |service|
    appointment_data.each do |data|
      Appointment.create!(
        datetime: data[:datetime],
        reason: data[:reason],
        status: data[:status],
        pet: pet,
        service: service,
        fee: service.fee
      )
    end
  end
end

pet1 = Pet.first
Vaccination.create!(pet_id: pet1.id, date: Date.today, comments: 'comentario', vaccine_id: Vaccine.first.id)
Allergy.create!(detected_on: '2021/02/04', severity: 'leve', reactions: 'ojos rojos', comments: 'comentario', pet_id: pet1.id, allergen_id: Allergen.first.id)
Condition.create!(diagnosis_date: '2020/09/13', recovery_date: '2020/12/04', comments: 'Control his weigth, follow a trainning and nutritional plan', pet_id: pet1.id, disease_id: Disease.first.id)

pet2 = Pet.second
Vaccination.create!(pet_id: pet2.id, date: Date.today, comments: 'comentario', vaccine_id: Vaccine.second.id)
Allergy.create!(detected_on: '2023/07/24', severity: 'fuerte', reactions: 'ronchas en la piel', comments: 'comentario', pet_id: pet2.id, allergen_id: Allergen.second.id)
Condition.create!(diagnosis_date: '2023/01/22', recovery_date: Date.today, comments: 'Walk your dog for 10 minutes everyday', pet_id: pet2.id, disease_id: Disease.second.id)

pet3 = Pet.last
Vaccination.create!(pet_id: pet3.id, date: '2024/03/15', comments: 'comentario', vaccine_id: Vaccine.last.id)
Allergy.create!(detected_on: '2022/05/21', severity: 'media', reactions: 'estornudos', comments: 'comentario', pet_id: pet3.id, allergen_id: Allergen.last.id)
Condition.create!(diagnosis_date: '2023/10/09', recovery_date: Date.today, comments: 'Extrict diet and trainning plan', pet_id: pet3.id, disease_id: Disease.last.id)


puts "Seed data generated successfully!"
